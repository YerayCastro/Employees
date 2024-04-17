//
//  empleadoEditVM.swift
//  Employees
//
//  Created by Yery Castro on 2/3/24.
//

import SwiftUI


final class EmpleadoEditVM: ObservableObject {
    @Published var empleado: Empleado
    
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var address = ""
    @Published var zipcode = ""
    @Published var username = ""
    @Published var department = ""
    @Published var gender = ""
    @Published var showAlert = false
    @Published var errorMsg = ""
    @Published var favoritos: [Empleado] = []
    
    let validator = Validators.shared
    
    init(empleado: Empleado) {
        self.empleado = empleado
        firstName = empleado.firstName
        lastName = empleado.lastName
        email = empleado.email
        address = empleado.address
        zipcode = empleado.zipcode
        username = empleado.username
        department = empleado.department.rawValue
        gender = empleado.gender.rawValue

    }
    
    func validateError() -> String {
        var msg = ""
        if let error = validator.isEmpty(firstName) {
            msg += "First Name \(error)\n"
        }
        if let error = validator.isEmpty(lastName) {
            msg += "Last Name \(error)\n"
        }
        if let error = validator.validEmail(email) {
            msg += "Email \(error)\n"
        }
        if let error = validator.isEmpty(address) {
            msg += "Address \(error)\n"
        }
        if let error = validator.isEmpty(username) {
            msg += "Username \(error)\n"
        }
        return String(msg.dropLast())
    }

    
    func validateEmpleado() -> Empleado? {
        guard let genderType = GenderType(rawValue: gender),
              let dptoName = DptoName(rawValue: department) else {
            return nil
        }
        
        let msg = validateError()
        if msg.isEmpty {
            return Empleado(id: empleado.id,
                            firstName: firstName,
                            lastName: lastName,
                            username: username,
                            email: email,
                            address: address,
                            zipcode: zipcode,
                            avatar: empleado.avatar,
                            gender: genderType,
                            department: dptoName)
        } else {
            errorMsg = msg
            showAlert.toggle()
            return nil
        }
    }
    
    func saveFavoritesToFile() {
        do {
            let data = try JSONEncoder().encode(favoritos)
            let fileURL = getDocumentsDirectory().appendingPathComponent("misempleados.json")
            try data.write(to: fileURL, options: .atomicWrite)
        } catch {
            print("Error al guardar los favoritos: \(error)")
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func addToFavorites(empleado: Empleado) {
        if !favoritos.contains(where: { $0.id == empleado.id }) {
            favoritos.append(empleado)
            saveFavoritesToFile()
        }
    }
    
    func removeFromFavorites(empleadoToRemove: Empleado) {
            if let index = favoritos.firstIndex(where: { $0.id == empleadoToRemove.id }) {
                favoritos.remove(at: index)
                saveFavoritesToFile()
            }
    }
    
    func loadFavoritesFromFile() {
        let fileURL = getDocumentsDirectory().appendingPathComponent("misempleados.json")
        if let data = try? Data(contentsOf: fileURL) {
            favoritos = (try? JSONDecoder().decode([Empleado].self, from: data)) ?? []
        }
    }

}
