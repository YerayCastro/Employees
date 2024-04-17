//
//  DeleteAlert.swift
//  Employees
//
//  Created by Yery Castro on 1/3/24.
//

import SwiftUI

struct DeleteAlert: ViewModifier {
    @Binding var isPresented: Bool
    let msg: String
    let deleteAction: () -> Void
    
    func body(content: Content) -> some View {
        content
            .alert("Validation to delete",
                   isPresented: $isPresented) {
                Button(role: .destructive) {
                    deleteAction()
                } label: {
                    Text("Delete")
                }
                Button(role: .cancel) {} label: {
                    Text("Cancel")
                }
            } message: {
                Text(msg)
            }
    }
}

extension View {
    func deleteAlert(isPresented: Binding<Bool>, msg: String, deleteAction: @escaping () -> Void) -> some View {
        modifier(DeleteAlert(isPresented: isPresented, msg: msg, deleteAction: deleteAction))
    }
}
