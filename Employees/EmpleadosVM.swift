//
//  ViewModel.swift
//  Employees
//
//  Created by Yery Castro on 29/2/24.
//

import Foundation

final class EmpleadosVM: ObservableObject {
    let network: DataInteractor
    @Published var empleados: [Empleado] = []
    @Published var showAlert = false
    @Published var msg = ""
    @Published var deleteAlert = false
    
    @Published var sortType: SortType = .byID
    @Published var search = ""
    @Published var loading = true
    @Published var favoritos: [Empleado] = []
    var empleadoToDelete: Empleado?
    
    var departments: [String] {
        DptoName.allCases.map {
            String(localized: LocalizedStringResource(stringLiteral: $0.rawValue))
        }.sorted()
    }
    
    var dptos: [DptoName] {
        DptoName.allCases.sorted { d1, d2 in
            String(localized: LocalizedStringResource(stringLiteral: d1.rawValue)) <= String(localized: LocalizedStringResource(stringLiteral: d2.rawValue))
        }
    }
    
    init(network: DataInteractor = Network()) {
        self.network = network
        Task { 
            await MainActor.run { loading = true }
            await getEmpleados()
            await MainActor.run { loading = false }
        }
    }
    
    func getEmpleados() async {
        do {
            let emps = try await network.getEmpleados()
            await MainActor.run {
                self.empleados = emps
            }
        } catch {
            await MainActor.run {
                self.msg = "\(error)"
                self.showAlert.toggle()
            }
        }
    }
    
    func getEmpleadosByDpto(dpto: DptoName) -> [Empleado] {
        empleados
            .filter { $0.department == dpto }
            .filter {
                if search.isEmpty {
                    true
                } else {
                    $0.fullname.range(of: search, options: [.caseInsensitive, .diacriticInsensitive]) != nil
                }
            }
            .sorted { e1, e2 in
                switch sortType {
                case .ascendent:
                    e1.fullname <= e2.fullname
                case .descendent:
                    e1.fullname >= e2.fullname
                case .byID:
                    e1.id < e2.id
                }
            }
    }
    
    func deleteEmpleadoAlert(empleado: Empleado) {
        msg = "Are you sure to delete the employee \(empleado.fullname)"
        deleteAlert.toggle()
        empleadoToDelete = empleado
    }
    
    func deleteEmpleado() {
        if let empleadoToDelete {
                empleados.removeAll(where: { $0.id == empleadoToDelete.id })
        }
    }
    
    func updateEmpleado(empleado: Empleado) async {
        do {
            try await updateEmpleadoAsync(empleado: empleado)
        } catch {
            await MainActor.run {
                self.msg = "\(error)"
                self.showAlert.toggle()
            }
        }
    }

    
    func updateEmpleadoAsync(empleado: Empleado) async throws {
        try await network.updateEmpleado(empleado: empleado)
        await MainActor.run {
            updateEmpleadoArray(empleado: empleado)
        }
    }
    
    func updateEmpleadoArray(empleado: Empleado) {
        if let first = empleados.firstIndex(where: { $0.id == empleado.id }) {
            empleados[first] = empleado
        }
    }
    
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private func saveEmpleadosToFileAsync() async {
        do {
            let data = try JSONEncoder().encode(empleados)
            try await withCheckedThrowingContinuation { continuation in
                do {
                    let fileURL = getDocumentsDirectory().appendingPathComponent("misempleados.json")
                    try data.write(to: fileURL, options: .atomic)
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        } catch {
            print("Error al guardar los mangas: \(error)")
        }
    }
    
    func saveFavoritesToFile() async {
        do {
            let data = try JSONEncoder().encode(favoritos)
            let fileURL = getDocumentsDirectory().appendingPathComponent("misempleados.json")
            try data.write(to: fileURL, options: .atomic)
        } catch {
            print("Error al guardar los favoritos: \(error)")
        }
    }
    
    func addToFavorites(empleado: Empleado) {
        if !favoritos.contains(where: { $0.id == empleado.id }) {
            favoritos.append(empleado)
            Task {
                await saveFavoritesToFile()
            }
        }
    }
    
    func removeFromFavorites(empleadoToRemove: Empleado) {
        if let index = favoritos.firstIndex(where: { $0.id == empleadoToRemove.id }) {
            favoritos.remove(at: index)
            Task {await saveFavoritesToFile()}
        }
    }
    
    func loadFavoritesFromFile() {
        let fileURL = getDocumentsDirectory().appendingPathComponent("misempleados.json")
        if let data = try? Data(contentsOf: fileURL) {
            favoritos = (try? JSONDecoder().decode([Empleado].self, from: data)) ?? []
        }
    }
}
