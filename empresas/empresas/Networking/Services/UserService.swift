//
//  UserService.swift
//  empresas
//
//  Created by Lucas Valle on 13/10/17.
//  Copyright © 2017 Lucas Valle. All rights reserved.
//

import Foundation
import Moya

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}

enum UserService {
    case login(username:String, password: String)
}

extension UserService: TargetType {
    var baseURL: URL { return URL(string: "\(APIConfig.BASEURL)\(APIConfig.VERSION)")! }
    var path: String {
        switch self {
        case .login(_, _):
            return "/users/auth/sign_in"
        }
    }
    var method: Moya.Method {
        switch self {
        case .login(_, _):
            return .post
        }
    }
    var parameters: [String: Any]? {
        switch self {
        case .login(let username, let password):
            return ["email": username, "password": password]
        }
    }
    var sampleData: Data {
        switch self {
        case .login(_):
            return "{\"investor\":{\"id\":1,\"investor_name\":\"Teste Apple\",\"email\":\"testeapple@ioasys.com.br\",\"city\":\"BH\",\"country\":\"Brasil\",\"balance\":1000000,\"photo\":null,\"portfolio\":{\"enterprises_number\":0,\"enterprises\":[]},\"portfolio_value\":1000000,\"first_access\":false,\"super_angel\":false},\"enterprise\":null,\"success\":true}".data(using: .utf8)!
        }
    }
    var task: Task {
        return .request
    }
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
