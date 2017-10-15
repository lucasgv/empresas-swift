//
//  Investor.swift
//  empresas
//
//  Created by Lucas Goes Valle on 15/10/17.
//  Copyright © 2017 Lucas Valle. All rights reserved.
//

import Mapper

struct Investor: Mappable {
    
    let id: Int
    let investor_name: String
    let email: String
    let city: String
    let country: String
    let balance: Double
    let photo: String?
    let portfolio_value: Double
    let first_access: Bool
    let super_angel: Bool
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try investor_name = map.from("investor_name")
        try email = map.from("email")
        try city = map.from("city")
        try country = map.from("country")
        try balance = map.from("balance")
        photo = map.optionalFrom("photo")
        try portfolio_value = map.from("portfolio_value")
        try first_access = map.from("first_access")
        try super_angel = map.from("super_angel")
    }
}
