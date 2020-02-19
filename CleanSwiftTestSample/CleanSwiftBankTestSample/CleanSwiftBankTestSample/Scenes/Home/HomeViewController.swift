//
//  HomeViewController.swift
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

protocol HomeDisplayLogic: class
{
    func displayUserDetails(viewModel: Home.GetAccountHolderDetails.ViewModel)
    func displayAccountStatementList(viewModel: Home.GetAccountStatementList.ViewModel)
    func displayLogout()
}

/**
 This class communicate with the Interactor, and get a response back from the Presenter. Also, when there is a need for transition, it will communicate with the Router.
 
 Usage:
    - **User Details** - Display user details to the UI.
    - **Statement List** - Display user account statement list to the UI.
 */
class HomeViewController: UIViewController, HomeDisplayLogic
{
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeDataPassing)?
    
    var acStatementList: [Home.GetAccountStatementList.ViewModel.StatementList] = []
    
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
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
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
        getUserInfo()
        getAccountStatementList()
    }
    
    // MARK: Display User Account Info
    
    @IBOutlet weak var accountHolderName: UILabel!
    @IBOutlet weak var accountInfo: UILabel!
    @IBOutlet weak var accountBalance: UILabel!
    
    func getUserInfo()
    {
        let request = Home.GetAccountHolderDetails.Request()
        interactor?.getUserDetails(request: request)
    }
    
    
    
    // MARK: Account Statement List
    
    @IBOutlet weak var userDataTableView: UITableView!
    
    struct cellIdentifiers {
        static let userCell = "userCell"
    }
    
    func getAccountStatementList()
    {
        let request = Home.GetAccountStatementList.Request()
        interactor?.getAccountStatementList(request: request)
    }
    
    // MARK: Logout
    
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBAction func logoutButtonTapped(sender: UIButton)
    {
        logout()
    }
    
    func logout()
    {
        interactor?.logout()
    }
}

extension HomeViewController {
    func displayUserDetails(viewModel: Home.GetAccountHolderDetails.ViewModel)
    {
        accountHolderName.text = viewModel.name
        accountInfo.text = viewModel.bankAccountInfo
        accountBalance.text = "\(viewModel.balance)"
    }
    
    func displayAccountStatementList(viewModel: Home.GetAccountStatementList.ViewModel)
    {
        if let statementList = viewModel.statementList {
            acStatementList = statementList
            userDataTableView.reloadData()
        }
        
    }
    
    func displayLogout()
    {
        performSegue(withIdentifier: "Login", sender: nil)
    }
}
