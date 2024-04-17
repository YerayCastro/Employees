//
//  CellFavs.swift
//  Employees
//
//  Created by Yery Castro on 5/3/24.
//

import SwiftUI

struct CellFavs: View {
    @EnvironmentObject var vm: EmpleadosVM
    let empleado: Empleado
    @Environment(\.dismiss) var dismiss
    @ObservedObject var editVM: EmpleadoEditVM
    var body: some View {
        VStack {
            Text(empleado.fullname)
                .font(.subheadline)
                .bold()
            
            AsyncImage(url: empleado.avatar){ image in
                image
                    .resizable()
                    .scaledToFit()
                    .symbolVariant(.fill)
                    .symbolVariant(.circle)
                    .frame(width: 150)
                    .background {
                        Color(white: 0.9)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } placeholder: {
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
                    .symbolVariant(.fill)
                    .symbolVariant(.circle)
                    .frame(width: 150)
                    .background {
                        Color(white: 0.9)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            Button {
                Task {
                    vm.removeFromFavorites(empleadoToRemove: empleado)
                }
            } label: {
                Image(systemName: "trash")
            }
        }
    }
}

#Preview {
    CellFavs(empleado: .test, editVM: EmpleadoEditVM(empleado: .test))
}
