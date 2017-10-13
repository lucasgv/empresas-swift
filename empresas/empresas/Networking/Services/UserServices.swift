//
//  UserServices.swift
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
    case login()
}

extension UserService: TargetType {
    var baseURL: URL { return URL(string: "\(APIConfig.BASEURL)\(APIConfig.VERSION)")! }
    var path: String {
        switch self {
        case .login():
            return "/users/login"
        }
    }
    var method: Moya.Method {
        switch self {
        case .login():
            return .get
        }
    }
    var parameters: [String: Any]? {
        return nil
    }
    var sampleData: Data {
        switch self {
        case .login(_):
            return "{{\"id\": \"1\", \"language\": \"Swift\", \"url\": \"https://api.github.com/repos/mjacko/Router\", \"name\": \"Router\"}}}".data(using: .utf8)!
        }
    }
    var task: Task {
        return .request
    }
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
