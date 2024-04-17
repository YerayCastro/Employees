//
//  DTOModel.swift
//  Employees
//
//  Created by Yery Castro on 29/2/24.
//

import Foundation

struct DTOEmpleado: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let username: String
    let email: String
    let address: String
    let zipcode: String
    let avatar: String
    
    struct Gender: Codable {
        let id: Int
        let gender: GenderType
    }
    let gender: Gender
    
    struct Department: Codable {
        let id: Int
        let name: DptoName
    }
    let department: Department
}

extension DTOEmpleado {
    var toPresentation: Empleado {
        Empleado(id: id,
                 firstName: firstName,
                 lastName: lastName,
                 username: username,
                 email: email,
                 address: address,
                 zipcode: zipcode, 
                 avatar: URL(string: avatar),
                 gender: gender.gender,
                 department: department.name)
    }
}

struct EmpleadosUpdate: Codable {
    var id: Int
    var username: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var address: String?
    var avatar: String?
    var zipcode: String?
    var department: String?
    var gender: String?
}
