//
//  ContentView.swift
//  Employees
//
//  Created by Yery Castro on 29/2/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: EmpleadosVM
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.dptos) { dpto in
                    empleadosSection(empleados: vm.getEmpleadosByDpto(dpto: dpto),
                                     dpto: dpto.rawValue)
                }
            }
            .navigationTitle("Employees")
            .searchable(text: $vm.search, prompt: "Search for an employee")
            .sortedButton(sortType: $vm.sortType)
            .navigationDestination(for: Empleado.self) { empleado in
                EmpleadoEdit(editVM: EmpleadoEditVM(empleado: empleado))
            }
            .refreshable {
                await vm.getEmpleados()
            }
        }
        .deleteAlert(isPresented: $vm.deleteAlert,
                     msg: vm.msg,
                     deleteAction: vm.deleteEmpleado)
        .alert("App Alert",
               isPresented: $vm.showAlert) { } message: {
            Text(vm.msg)
        }
    }
    
    func empleadosSection(empleados: [Empleado], dpto: String) -> some View {
        Group {
            if empleados.count > 0 {
                Section {
                    ForEach(empleados) { empleado in
                        NavigationLink(value: empleado) {
                            EmpleadoCell(empleado: empleado,
                                         deleteAction: vm.deleteEmpleadoAlert)
                        }
                    }
                } header: {
                    Text(LocalizedStringKey(dpto))
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(EmpleadosVM.test)
}
