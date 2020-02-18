//
//  TestBankLoginViewController.swift
//  Test_Bank_iOS
//
//  Created by Abhishek D on 13/10/19.
//  Copyright (c) 2019 Abhishek D. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol TestBankLoginDisplayLogic: class
{
    func displayLogin(viewModel: TestBankLogin.Login.ViewModel)
    func displayError(errorModel: TestBankLogin.Login.ErrorModel)
}

class TestBankLoginViewController: UIViewController, TestBankLoginDisplayLogic
{
    var interactor: TestBankLoginBusinessLogic?
    var router: (NSObjectProtocol & TestBankLoginRoutingLogic & TestBankLoginDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = TestBankLoginInteractor()
        let presenter = TestBankLoginPresenter()
        let router = TestBankLoginRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    // MARK: Login
    
    @IBOutlet weak var userIDTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBAction func unwindToLogin(segue:UIStoryboardSegue) {
        Utils().hideActivityIndicator(uiView: self.view)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any)
    {
        login()
    }
    
    private func login()
    {
        let userID = userIDTextField.text
        let password = passwordTextField.text
        
        if !isLoginTextFieldEmpty(userID, password: password) {
            Utils().showActivityIndicator(uiView: self.view)
            let request = TestBankLogin.Login.Request(userID: userID, password: password)
            interactor?.login(request: request)
        } else {
            messageLabel.text = NSLocalizedString("Enter username / password to login", comment: "")
        }
    }
    
    private func isLoginTextFieldEmpty(_ userID: String?, password: String?) -> Bool
    {
        if let userID = userID, let password = password {
            if !userID.isEmpty && !password.isEmpty {
                return false
            } else {
                return true
            }
        } else {
            return true
        }
    }
    
    
}

extension TestBankLoginViewController {
    func displayLogin(viewModel: TestBankLogin.Login.ViewModel)
    {
        Utils().hideActivityIndicator(uiView: self.view)
        
        if viewModel.success {
            performSegue(withIdentifier: "Home", sender: nil)
            messageLabel.text = NSLocalizedString("Welcome", comment: "")
        } else {
            userIDTextField.text = nil
            passwordTextField.text = nil
            messageLabel.text = NSLocalizedString("Your email/password didn't match", comment: "")
        }
    }
    
    func displayError(errorModel: TestBankLogin.Login.ErrorModel) {
        //Handle Error
        Utils().hideActivityIndicator(uiView: self.view)
        userIDTextField.text = nil
        passwordTextField.text = nil
        messageLabel.text = errorModel.errorResponse.message
    }
}
