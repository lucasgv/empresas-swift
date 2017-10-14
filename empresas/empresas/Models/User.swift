//
//  User.swift
//  empresas
//
//  Created by Lucas Valle on 13/10/17.
//  Copyright © 2017 Lucas Valle. All rights reserved.
//

import Mapper

struct User: Mappable {

    let success: Bool
    
    init(map: Mapper) throws {
        try success = map.from("success")
    }
}

