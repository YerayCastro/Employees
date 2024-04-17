//
//  CellDetail.swift
//  Employees
//
//  Created by Yery Castro on 5/3/24.
//

import SwiftUI

struct CellDetail: View {
    let label: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(label)
                    .font(.headline)
                    .bold()
                Spacer()
                Text(text)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding()
        }
    }
}

#Preview {
    CellDetail(label: "First Name", text: .constant("Julio César"))
}
