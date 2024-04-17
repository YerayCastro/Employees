//
//  EmpleadosFielde.swift
//  Employees
//
//  Created by Yery Castro on 2/3/24.
//

import Foundation

enum EmpleadosField {
    case firstName
    case lastName
    case address
    case zipcode
    case email
    case username
    
    mutating func next() {
        switch self {
        case .firstName:
            self = .lastName
        case .lastName:
            self = .address
        case .address:
            self = .zipcode
        case .zipcode:
            self = .email
        case .email:
            self = .username
        case .username:
            self = .firstName
        }
    }
    
    mutating func prev() {
        switch self {
        case .firstName:
            self = .username
        case .lastName:
            self = .firstName
        case .address:
            self = .lastName
        case .zipcode:
            self = .address
        case .email:
            self = .zipcode
        case .username:
            self = .email
        }
    }
}
