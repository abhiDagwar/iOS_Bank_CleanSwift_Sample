//
//  TestBankLoginTest.swift
//  CleanSwiftBankTestSampleTests
//
//  Created by tcs on 06/11/19.
//  Copyright © 2019 Abhishek D. All rights reserved.
//

@testable import CleanSwiftBankTestSample
import XCTest

class TestBankLoginTest: XCTestCase {
    // MARK: Subject under test
    
    var sut: TestBankLoginViewController!
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
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "TestBankLoginViewController") as! TestBankLoginViewController
        sut = destinationVC
    }
    
    func loadView()
    {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
        Utils().showActivityIndicator(uiView: sut.view)
    }

    
    // MARK: Test doubles
    
    class TestBankLoginBusinessLogicSpy: TestBankLoginBusinessLogic
    {
        var loginCalled = false
        
        func login(request: TestBankLogin.Login.Request)
        {
            loginCalled = true
        }
    }
    
    // MARK: Tests
    
    func testShouldLoginWhenLoginButtonIsTapped()
    {
        // Given
        let spy = TestBankLoginBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        loadView()
        sut.loginButtonTapped(self)
        
        // Then
        XCTAssertTrue(spy.loginCalled, "loginButtonTapped(_:) should ask the interactor to login")
    }
    
    func testDisplayLoginOnSuccess()
    {
        // Given
        let userRes = UserAccount(userID: 01, name: "Abhishek Dagwar", bankAccount: "01HW213CCW", agency: "NEW BANK", balance: 2000.00)
        let code = 01
        let message = "No Error"
        let errorRes = ErrorResponse(code: code, message: message)
        let loginRes = LoginResponse(userAccount: userRes, error: errorRes)
        let viewModel = TestBankLogin.Login.ViewModel(success: true, loginResponse: loginRes)
        
        // When
        loadView()
        sut.displayLogin(viewModel: viewModel)
        
        // Then
        XCTAssertEqual(sut.messageLabel.text, "Welcome", "loginButtonTapped(_:) should display a greeting")
    }
    
    func testDisplayLoginOnFailure()
    {
        // Given
        let userRes: UserAccount = UserAccount(userID: 00, name: "", bankAccount: "", agency: "", balance: 00.00)
        let code = 02
        let message = "Error"
        let errorRes = ErrorResponse(code: code, message: message)
        let loginRes = LoginResponse(userAccount: userRes, error: errorRes)
        let viewModel = TestBankLogin.Login.ViewModel(success: false, loginResponse: loginRes)
        
        // When
        loadView()
        sut.displayLogin(viewModel: viewModel)
        
        // Then
        XCTAssertEqual(sut.messageLabel.text, "Your email/password didn't match", "loginButtonTapped(_:) should display an error")
    }
    
    func testDisplayUserIDEmpty()
    {
        // Given
        let userID = ""
        let password = "Test"
        
        // When
        loadView()
        sut.login(userID: userID, password: password)
        
        // Then
        XCTAssertEqual(sut.messageLabel.text, "Enter username / password to login", "loginButtonTapped(_:) should display an error")

    }
    
    func testDisplayPasswordEmpty()
    {
        // Given
        let userID = ""
        let password = "Test"
        
        // When
        loadView()
        sut.login(userID: userID, password: password)
        
        // Then
        XCTAssertEqual(sut.messageLabel.text, "Enter username / password to login", "loginButtonTapped(_:) should display an error")
    }
}
