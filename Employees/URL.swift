//
//  URL.swift
//  Employees
//
//  Created by Yery Castro on 29/2/24.
//

import Foundation

let prod = URL(string: "https://acacademy-employees-api.herokuapp.com/api/")!
let api = prod

extension URL {
    static let getEmpleados = api.appending(path: "getEmpleados")
    static let empleado = api.appending(path: "empleado")
    static func getEmpleado(id: Int) -> URL {
        api.appending(path: "getEmpleado").appending(path: "\(id)")
    }
}
