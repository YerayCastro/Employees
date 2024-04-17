//
//  EmployeesApp.swift
//  Employees
//
//  Created by Yery Castro on 29/2/24.
//

import SwiftUI

@main
struct EmployeesApp: App {
    @StateObject var vm = EmpleadosVM()
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(vm)
        }
    }
}
