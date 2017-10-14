//
//  loginViewModel.swift
//  empresas
//
//  Created by Lucas Goes Valle on 14/10/17.
//  Copyright © 2017 Lucas Valle. All rights reserved.
//

import RxSwift
import RxCocoa
import Moya
import Mapper
import Moya_ModelMapper
import RxOptional
import RxSwiftUtilities

struct LoginViewModel {
    
    let activityIndicator = ActivityIndicator()
    
    let usernameBGColor: Driver<UIColor>
    let passwordBGColor: Driver<UIColor>
    let credentialsValid: Driver<Bool>
    let provider: RxMoyaProvider<UserService>
    
    init(usernameText: Driver<String>, passwordText: Driver<String>) {
        
        let usernameValid = usernameText
            .distinctUntilChanged()
            .throttle(0.3)
            .map { $0.utf8.count > 3 }
        
        let passwordValid = passwordText
            .distinctUntilChanged()
            .throttle(0.3)
            .map { $0.utf8.count > 3 }
        
        usernameBGColor = usernameValid
            .map { $0 ? UIColor.black : UIColor.white }
        
        passwordBGColor = passwordValid
            .map { $0 ? UIColor.black : UIColor.white }
        
        credentialsValid = Driver.combineLatest(usernameValid, passwordValid) { $0 && $1 }
        self.provider = RxMoyaProvider<UserService>()
    }
    
    func login(_ username: String, password: String) -> Observable<User?> {
        return self.provider
            .request(UserService.login(username: username, password: password))
            .debug()
            .mapObjectOptional(type: User.self)
    }
    
}
