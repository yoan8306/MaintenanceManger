//
//  PersonTableViewCell.swift
//  MaintenanceManager
//
//  Created by Yoan on 05/05/2021.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var jobRoleLabel: UILabel!
    @IBOutlet weak var identifiantLabel: UILabel!
    
    
    func configure(firstName: String, lastName: String, password: String, department: String, jobRole: String, identifiant: String) {
        firstNameLabel.text = firstName
        lastNameLabel.text = lastName
        passwordLabel.text = password
        departmentLabel.text = department
        jobRoleLabel.text = jobRole
        identifiantLabel.text = identifiant
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
