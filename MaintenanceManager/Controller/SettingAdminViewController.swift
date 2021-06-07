//
//  SettingAdminViewController.swift
//  MaintenanceManager
//
//  Created by Yoan on 06/06/2021.
//

import UIKit

class SettingAdminViewController: UIViewController {

    @IBOutlet weak var departmentButton: UIButton!
    @IBOutlet weak var jobButton: UIButton!
    @IBOutlet weak var equipmentStatus: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designedButton()
    }
    private func designedButton(){
        departmentButton.layer.cornerRadius = 8
        jobButton.layer.cornerRadius = 8
        equipmentStatus.layer.cornerRadius = 8
    }
    
}
