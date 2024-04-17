//
//  DataTest.swift
//  Employees
//
//  Created by Yery Castro on 29/2/24.
//

import Foundation

extension Empleado {
    static let test = Empleado(id: 1, firstName: "Julio César", lastName: "Fernández", username: "jcfmunoz", email: "jcfmunoz@icloud.com", address: "Apple Park", zipcode: "28000", avatar: URL(string: "https://pbs.twimg.com/profile_images/1017076264644022272/tetffw3o_400x400.jpg"), gender: .male, department: .engineering)
}

extension EmpleadosVM {
    static let test = EmpleadosVM(network: DataTest())
}

struct DataTest: DataInteractor {
    let url = Bundle.main.url(forResource: "testEmpleados", withExtension: "json")!
    
    func loadTestData() throws -> [Empleado] {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([DTOEmpleado].self, from: data).map(\.toPresentation)
    }
    
    func getEmpleados() async throws -> [Empleado] {
        try loadTestData()
    }
    
    func updateEmpleado(empleado: Empleado) async throws {}
}
