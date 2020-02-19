//
//  UserAccountStatementTableViewCell.swift
//  CleanSwiftBankTestSample
//
//  Created by Shantanu on 18/10/19.
//  Copyright © 2019 Abhishek D. All rights reserved.
//

import UIKit

/**
 This class shows the user statement details list
 
 - Parameters:
    - userTitle: Enter a valid username to login
    - userDescription: Enter a valid password to login
    - userDate: Enter a valid password to login
    - userWithdrawnValue: Enter a valid password to login
 */

class UserAccountStatementTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userTitle: UILabel!
    @IBOutlet weak var userDescription: UILabel!
    @IBOutlet weak var userDate: UILabel!
    @IBOutlet weak var userWithdrawnValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /**
     This function sets the value from a statement list to show the user transaction details like the withdrawal date, withdrawal amount, etc.
     
     - Parameters:
        - statement: A statement details from the statement list.
     */
    func set(statement: Home.GetAccountStatementList.ViewModel.StatementList) {
        self.userTitle.text = statement.title
        self.userDescription.text = statement.desc
        self.userDate.text = statement.date
        self.userWithdrawnValue.text = "\(statement.value)"
    }
}
