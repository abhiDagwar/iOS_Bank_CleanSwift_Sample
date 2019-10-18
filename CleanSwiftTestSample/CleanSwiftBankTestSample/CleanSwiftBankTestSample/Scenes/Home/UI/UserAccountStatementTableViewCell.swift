//
//  UserAccountStatementTableViewCell.swift
//  CleanSwiftBankTestSample
//
//  Created by Shantanu on 18/10/19.
//  Copyright © 2019 Abhishek D. All rights reserved.
//

import UIKit

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
    
    func set(statement: Home.GetAccountStatementList.ViewModel.StatementList) {
        self.userTitle.text = statement.title
        self.userDescription.text = statement.desc
        self.userDate.text = statement.date
        self.userWithdrawnValue.text = "\(statement.value)"
    }
}
