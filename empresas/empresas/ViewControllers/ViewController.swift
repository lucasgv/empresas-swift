//
//  ViewController.swift
//  empresas
//
//  Created by Lucas Valle on 13/10/17.
//  Copyright © 2017 Lucas Valle. All rights reserved.
//

import Moya
import Moya_ModelMapper
import UIKit
import RxCocoa
import RxSwift
import SwiftyUserDefaults

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewModel = LoginViewModel(usernameText: usernameTextField.rx.text.orEmpty.asDriver(),
                                       passwordText: passwordTextField.rx.text.orEmpty.asDriver())
        
        viewModel.credentialsValid
            .drive(onNext: { [unowned self] valid in
                self.enterButton.isEnabled = valid
            })
            .addDisposableTo(disposeBag)
        
        enterButton.rx.tap
            .withLatestFrom(viewModel.credentialsValid)
            .filter { $0 }
            .flatMapLatest { [unowned self] valid -> Observable<User?> in
                viewModel.login(self.usernameTextField.text!, password: self.passwordTextField.text!)
                    .trackActivity(viewModel.activityIndicator)
                    .observeOn(SerialDispatchQueueScheduler(qos: .userInteractive))
            }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] User in
                if User?.success == true {
                    Defaults[.userLogged] = true
                } else {
                    let alertController = UIAlertController(title: "Atenção", message: "Login ou senha inválidos.", preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            })
            .addDisposableTo(disposeBag)
        
        
        viewModel.activityIndicator
            .distinctUntilChanged()
            .drive(onNext: { [unowned self] active in
                self.hideKeyboard()
                self.activityIndicator.isHidden = !active
                if active {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
                self.enterButton.isEnabled = !active
            })
            .addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func hideKeyboard() {
        self.usernameTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === usernameTextField {
            passwordTextField.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }
        return false
    }


}

