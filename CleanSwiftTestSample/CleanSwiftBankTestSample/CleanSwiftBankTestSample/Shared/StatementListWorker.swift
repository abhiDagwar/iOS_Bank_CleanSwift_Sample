//
//  StatementListWorker.swift
//  CleanSwiftBankTestSample
//
//  Created by Shantanu on 18/10/19.
//  Copyright © 2019 Abhishek D. All rights reserved.
//

import Foundation

class StatementListWorker {
    func getStatementList(completion: @escaping (Bool, AccountStatement?, ErrorResponse?) -> Void)
    {
        _ = Network.taskForGETRequest(url: NetworkRouter.Endpoints.statements.url, responseType: AccountStatement.self) { (statementList, error) in
            if let statementList = statementList {
                completion(true, statementList, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
}
