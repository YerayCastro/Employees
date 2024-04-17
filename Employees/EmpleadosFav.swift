//
//  EmpleadosFav.swift
//  Employees
//
//  Created by Yery Castro on 5/3/24.
//

import SwiftUI

struct EmpleadosFav: View {
    let empleado: Empleado
    @EnvironmentObject var vm: EmpleadosVM
    @ObservedObject var editVM: EmpleadoEditVM
    let item = GridItem(.adaptive(minimum: 150), alignment: .center)
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [item], content: {
                    ForEach(vm.favoritos) { empleado in
                        NavigationLink(value: empleado) {
                            CellFavs(empleado: empleado, editVM: EmpleadoEditVM(empleado: empleado))
                        }
                    }
                })
                .navigationDestination(for: Empleado.self) { empleado in
                    EmpleadoDetail(empleado: empleado, editVM: EmpleadoEditVM(empleado: empleado))
                }
                .navigationTitle("Favoritos")
                .navigationBarTitleDisplayMode(.inline)
            }
            .onAppear {
                vm.loadFavoritesFromFile()
            }
        }
    }
}

#Preview {
    NavigationStack {
        EmpleadosFav(empleado: .test, editVM: EmpleadoEditVM(empleado: .test))
            .environmentObject(EmpleadosVM.test)
    }
}
