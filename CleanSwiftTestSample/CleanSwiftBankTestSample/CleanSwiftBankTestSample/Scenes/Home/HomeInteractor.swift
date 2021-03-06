//
//  HomeInteractor.swift
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

protocol HomeBusinessLogic
{
    func getUserDetails(request: Home.GetAccountHolderDetails.Request)
    func getAccountStatementList(request: Home.GetAccountStatementList.Request)
    func logout()
}

protocol HomeDataStore
{
    var userDetails: UserAccount? { get set }
}

/**
 This class acts as a mediator between the Worker (StatementListWorker) and the Presenter. It communicates with the ViewController which passes all the Request params needed for the Worker. Before proceeding to the Worker, a validation is done to check if everything is sent properly. The Worker returns a response and the Interactor passes that response towards the Presenter.
 
 Usage:
    - The viewController send the request to fetch user account details.
    - The viewController send the request to fetch user account statement details.
    - The logout functionality is use to logout the user from the application.
 */

class HomeInteractor: HomeBusinessLogic, HomeDataStore
{
    var userDetails: UserAccount?
    var presenter: HomePresentationLogic?
}

extension HomeInteractor {
    /**
     This function send the request to the worker to fetch user account details.
     
     - Parameters:
        - request: Create a request from viewcontroller to fetch the user details from network call.
     */
    func getUserDetails(request: Home.GetAccountHolderDetails.Request)
    {
        guard let userDetails = userDetails else {
            print("Error fetching user details.")
            return
        }
        
        let response = Home.GetAccountHolderDetails.Response(userAccountDetails: userDetails)
        presenter?.presentUserDetails(response: response)
    }
    
    /**
     This function send the request to the worker to fetch user account statement details.
     
     - Parameters:
        - request: Create a request from viewcontroller to fetch the user account statement details from network call.
     */
    func getAccountStatementList(request: Home.GetAccountStatementList.Request)
    {
        let statementListWorker = StatementListWorker()
        statementListWorker.getStatementList { (success, statementList, error) in
            
            if success {
                let response = Home.GetAccountStatementList.Response(success: success, accountStatement: statementList?.statementList)
                self.presenter?.presentAccountStatementList(response: response)
            }  else {
                
                guard let error = error else {
                    return
                }
                let errorResponse = Home.GetAccountStatementList.Error(success: success, errorResponse: error)
                self.presenter?.presentAccountStatementList(with: errorResponse)
            }
        }
    }
    
    /**
     This function call present the request to presenter to logout from the application.
     */
    func logout() {
        presenter?.presentLogout()
    }
}
