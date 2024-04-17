//
//  Presentation.swift
//  Employees
//
//  Created by Yery Castro on 29/2/24.
//

import Foundation

struct Empleado: Identifiable, Hashable, Encodable, Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let username: String
    let email: String
    let address: String
    let zipcode: String
    let avatar: URL?
    let gender: GenderType
    let department: DptoName
}

extension Empleado {
    var fullname: String {
        "\(lastName), \(firstName)"
    }
    
    var toUpdate: EmpleadosUpdate {
        EmpleadosUpdate(id: id,
                        username: username,
                        firstName: firstName,
                        lastName: lastName,
                        email: email,
                        address: address,
                        avatar: avatar?.absoluteString,
                        zipcode: zipcode,
                        department: department.rawValue,
                        gender: gender.rawValue)
    }
}
