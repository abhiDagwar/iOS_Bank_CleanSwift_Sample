//
//  HomeTest.swift
//  CleanSwiftBankTestSampleTests
//
//  Created by New User on 21/02/20.
//  Copyright © 2020 Abhishek D. All rights reserved.
//

import XCTest

class HomeTest: XCTestCase {
    // MARK: Subject under test
    
    var sut: HomeViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        window = UIWindow()
        setupWelcomeViewController()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupWelcomeViewController()
    {
        let bundle = Bundle(for: self.classForCoder)
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        sut = destinationVC
    }
    
    func loadView()
    {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
        Utils().showActivityIndicator(uiView: sut.view)
    }
    
    // MARK: Test doubles
    
    class HomeBusinessLogicSpy: HomeBusinessLogic
    {
        func getUserDetails(request: Home.GetAccountHolderDetails.Request) {
            //
        }
        
        func getAccountStatementList(request: Home.GetAccountStatementList.Request) {
            //
        }
        
        var logoutCalled = false
        func logout() {
            logoutCalled = true
        }
    }
    
    // MARK: Tests
    
    func testShouldLogoutWhenLogoutButtonIsTapped()
    {
        // Given
        let spy = HomeBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        loadView()
        sut.logoutButtonTapped(self)
        
        // Then
        XCTAssertTrue(spy.logoutCalled, "logoutButtonTapped(_:) should ask the interactor to login")
    }
    
    func testDisplayUserDetails()
    {
        // Given
        let userRes = UserAccount(userID: 01, name: "Abhishek Dagwar", bankAccount: "01HW213CCW", agency: "NEW BANK", balance: 2000.00)
        let viewModel = Home.GetAccountHolderDetails.ViewModel(name: userRes.name, bankAccountInfo: userRes.bankAccount, balance: userRes.balance)
        
        // When
        loadView()
        sut.displayUserDetails(viewModel: viewModel)
        
        // Then
        XCTAssertEqual(sut.accountHolderName.text, "Abhishek Dagwar", "displayUserDetails(viewModel:) should display user account information.")
    }
    
    func testAccountStatementList()
    {
        // Given
        let statementList1 = Home.GetAccountStatementList.ViewModel.StatementList(title: "Jose da Silva Teste", desc: "Credited", date: "10/12/2018", value: 500.00)
        let statementList2 = Home.GetAccountStatementList.ViewModel.StatementList(title: "Pagamento", desc: "Conta de luz", date: "12/12/2018", value: 1.00)
        let statementList3 = Home.GetAccountStatementList.ViewModel.StatementList(title: "Jenifer", desc: "Debited", date: "21/12/2018", value: 5.00)
        let statementList4 = Home.GetAccountStatementList.ViewModel.StatementList(title: "Nick", desc: "Recarrega", date: "22/12/2018", value: 1.00)
        

        let viewModel = Home.GetAccountStatementList.ViewModel(success: true, statementList: [statementList1, statementList2, statementList3, statementList4])
        
        // When
        loadView()
        sut.displayAccountStatementList(viewModel: viewModel)
        
        // Then
        XCTAssertEqual(sut.acStatementList[0].title, viewModel.statementList![0].title, "displayAccountStatementList(viewModel:) should display user account information.")
    }
}
