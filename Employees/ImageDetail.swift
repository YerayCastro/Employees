//
//  ImageDetail.swift
//  Employees
//
//  Created by Yery Castro on 5/3/24.
//

import SwiftUI

struct ImageDetail: View {
    let empleado: Empleado
    var body: some View {
        AsyncImage(url: empleado.avatar) { image in
            image
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 10))
        } placeholder: {
            Image(systemName: "person")
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    ImageDetail(empleado: .test)
        
}
