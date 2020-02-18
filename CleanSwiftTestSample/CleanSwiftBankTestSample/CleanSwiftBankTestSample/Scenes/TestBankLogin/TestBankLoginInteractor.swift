//
//  TestBankLoginInteractor.swift
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

protocol TestBankLoginBusinessLogic
{
    func login(request: TestBankLogin.Login.Request)
}

protocol TestBankLoginDataStore
{
    //var name: String { get set }
    var userDetails: UserAccount? { get }
}

class TestBankLoginInteractor: TestBankLoginBusinessLogic, TestBankLoginDataStore
{
    var presenter: TestBankLoginPresentationLogic?
    var worker: TestBankLoginWorker?
    var userDetails: UserAccount?
    
    // MARK: Login
    
    func login(request: TestBankLogin.Login.Request)
    {
        let userID = request.userID
        let password = request.password
        let authenticationWorker = AuthenticationWorker()
        authenticationWorker.login(username: userID ?? "", password: password ?? "") { (success, response, error) in
            if success {
                authenticationWorker.saveUserID("\(response!.userAccount.userID)")
                let response = TestBankLogin.Login.Response(success: success, loginResponse: response!)
                self.userDetails = response.loginResponse.userAccount
                self.presenter?.presentLogin(response: response)
            } else {
                let errorResponse = TestBankLogin.Login.Error(success: success, errorResponse: error!)
                self.presenter?.presentLogin(with: errorResponse)
            }
        }
    }
}
