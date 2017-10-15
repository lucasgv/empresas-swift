//
//  DefaultsKeys.swift
//  empresas
//
//  Created by Lucas Goes Valle on 15/10/17.
//  Copyright © 2017 Lucas Valle. All rights reserved.
//

import SwiftyUserDefaults

extension DefaultsKeys {
    static let userLogged = DefaultsKey<Bool>("userLogged")
    static let userObject = DefaultsKey<[String: Any]>("userObject")
}
