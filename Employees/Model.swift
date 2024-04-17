//
//  Model.swift
//  Employees
//
//  Created by Yery Castro on 29/2/24.
//

import Foundation


enum DptoName: String, Codable, CaseIterable, Identifiable {
    case accounting = "Accounting"
    case businessDevelopment = "Business Development"
    case engineering = "Engineering"
    case humanResources = "Human Resources"
    case legal = "Legal"
    case marketing = "Marketing"
    case productManagement = "Product Management"
    case researchAndDevelopment = "Research and Development"
    case sales = "Sales"
    case services = "Services"
    case support = "Support"
    case training = "Training"
    
    var id: Self { self }
}

enum GenderType: String, Codable, CaseIterable, Identifiable {
    case female = "Female"
    case male = "Male"
    
    var id: Self { self }
}

enum SortType: String, CaseIterable, Identifiable {
    case ascendent = "Ascendent"
    case descendent = "Descendent"
    case byID = "By ID"
    
    var id: Self { self }
}
