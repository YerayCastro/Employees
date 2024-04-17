//
//  EmpleadoDetail.swift
//  Employees
//
//  Created by Yery Castro on 5/3/24.
//

import SwiftUI

struct EmpleadoDetail: View {
    let empleado: Empleado
    @EnvironmentObject var vm: EmpleadosVM
    @ObservedObject var editVM: EmpleadoEditVM
    var body: some View {
        ScrollView {
            ImageDetail(empleado: empleado)
            CellDetail(label: "Department", text: $editVM.department)
            CellDetail(label: "Gender", text: $editVM.gender)
            CellDetail(label: "First Name", text: $editVM.firstName)
            CellDetail(label: "Last Name", text: $editVM.lastName)
            CellDetail(label: "Username", text: $editVM.username)
            CellDetail(label: "Email", text: $editVM.email)
            CellDetail(label: "Address", text: $editVM.address)
            CellDetail(label: "ZIP Code", text: $editVM.zipcode)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    EmpleadoDetail(empleado: .test, editVM: EmpleadoEditVM(empleado: .test))
        .environmentObject(EmpleadosVM.test)
        
}
