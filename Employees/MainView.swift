//
//  TabView.swift
//  Employees
//
//  Created by Yery Castro on 5/3/24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var vm: EmpleadosVM
    var body: some View {
        TabView {
            ContentView()
                .tabItem { Label("Empleados", systemImage: "person") }
            EmpleadosFav(empleado: .test, editVM: EmpleadoEditVM(empleado: .test))
                .tabItem { Label("Favoritos", systemImage: "star") }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(EmpleadosVM.test)
}
