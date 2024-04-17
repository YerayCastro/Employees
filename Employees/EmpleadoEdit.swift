//
//  EmpleadoEdit.swift
//  Employees
//
//  Created by Yery Castro on 2/3/24.
//

import SwiftUI

struct EmpleadoEdit: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var vm: EmpleadosVM
    @ObservedObject var editVM: EmpleadoEditVM
    
    @FocusState private var campo: EmpleadosField?
    
    var body: some View {
        Form {
            Section {
                EditTextField(label: "First Name", text: $editVM.firstName)
                    .textContentType(.name)
                    .textInputAutocapitalization(.words)
                    .focused($campo, equals: .firstName)
                EditTextField(label: "Last Name", text: $editVM.lastName)
                    .textContentType(.familyName)
                    .textInputAutocapitalization(.words)
                    .focused($campo, equals: .lastName)
                EditTextField(label: "Address", text: $editVM.address)
                    .textContentType(.fullStreetAddress)
                    .textInputAutocapitalization(.words)
                    .focused($campo, equals: .address)
                EditTextField(label: "ZIP Code", text: $editVM.zipcode,
                               validator: Validators.shared.noValidate)
                    .textContentType(.postalCode)
                    .autocorrectionDisabled()
                    .focused($campo, equals: .zipcode)
                Picker("Gender", selection: $editVM.gender) {
                    ForEach(GenderType.allCases) { gender in
                        Text(LocalizedStringKey(gender.rawValue))
                            .tag(gender.rawValue)
                    }
                }
            } header: {
                Text("Personal data")
            }
            .submitLabel(.next)
            .onSubmit {
                campo?.next()
            }
            
            Section {
                Picker("Department", selection: $editVM.department) {
                    ForEach(vm.dptos) { dpto in
                        Text(LocalizedStringKey(dpto.rawValue))
                            .tag(dpto.rawValue)
                    }
                }
                EditTextField(label: "Email", text: $editVM.email,
                               validator: Validators.shared.validEmail)
                    .textContentType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .focused($campo, equals: .email)
                EditTextField(label: "Username", text: $editVM.username,
                               validator: Validators.shared.greaterThan4)
                    .textContentType(.username)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .focused($campo, equals: .username)
            } header: {
                Text("Company details")
            }
            .submitLabel(.next)
            .onSubmit {
                campo?.next()
            }
        }
        .navigationTitle("Edit employee")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    if let empleado = editVM.validateEmpleado() {
                        Task {
                            vm.addToFavorites(empleado: empleado)
                            await vm.updateEmpleado(empleado: empleado)
                    
                            
                            dismiss()
                        }
                    }
                } label: {
                    Text("Save")
                }
            }
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Button {
                        campo?.prev()
                    } label: {
                        Image(systemName: "chevron.up")
                    }
                    Button {
                        campo?.next()
                    } label: {
                        Image(systemName: "chevron.down")
                    }
                    Spacer()
                    Button {
                        campo = nil
                    } label: {
                        Image(systemName: "keyboard")
                    }
                }
            }
        }
        .alert("Validation Error",
               isPresented: $editVM.showAlert) {
            
        } message: {
            Text(editVM.errorMsg)
        }
    }
}

#Preview {
    NavigationStack {
        EmpleadoEdit(editVM: EmpleadoEditVM(empleado: .test))
            .environmentObject(EmpleadosVM.test)
    }
}
