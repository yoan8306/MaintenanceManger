//
//  MachineTableViewCell.swift
//  MaintenanceManager
//
//  Created by Yoan on 01/06/2021.
//

import UIKit

class MachineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var machineNameLabel: UILabel!
    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var machineDepartmentLabel: UILabel!
    
    func configureMachine(machineName: String, serialNumber: String, machineDepartment: String) {
        machineNameLabel.text = machineName
        serialNumberLabel.text = serialNumber
        machineDepartmentLabel.text = machineDepartment
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
