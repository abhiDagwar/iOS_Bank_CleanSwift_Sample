//
//  TestBankLoginPresenter.swift
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

protocol TestBankLoginPresentationLogic
{
    func presentLogin(response: TestBankLogin.Login.Response)
}

class TestBankLoginPresenter: TestBankLoginPresentationLogic
{
    weak var viewController: TestBankLoginDisplayLogic?
    
    // MARK: Login
    
    func presentLogin(response: TestBankLogin.Login.Response)
    {
        let viewModel = TestBankLogin.Login.ViewModel(success: response.success, loginResponse: response.loginResponse)
        viewController?.displayLogin(viewModel: viewModel)
    }
}
