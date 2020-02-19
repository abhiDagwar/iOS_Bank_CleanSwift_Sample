//
//  HomeViewController+TableView.swift
//  CleanSwiftBankTestSample
//
//  Created by Shantanu on 18/10/19.
//  Copyright © 2019 Abhishek D. All rights reserved.
//

import UIKit

/**
 This extension will display the user account statement list to the table view.
 */
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return acStatementList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let displayStatement = acStatementList[indexPath.row]
        
        if let statementListCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiers.userCell) as? UserAccountStatementTableViewCell {
            statementListCell.set(statement: displayStatement)
            
            return statementListCell
        }
        
        return UITableViewCell()
    }
    
}
