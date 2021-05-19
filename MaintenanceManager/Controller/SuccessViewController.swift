//
//  SuccessViewController.swift
//  MaintenanceManager
//
//  Created by Yoan on 05/05/2021.
//

import UIKit

class SuccessViewController: UIViewController {
    
    var persons = Person.all
    var signIn = Person()
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initiliseUser()
    }
    private func initiliseUser () {
        for findPerson in persons {
            if findPerson.identifiant == PersonLogged.personLogged {
                firstNameLabel.text = findPerson.firstName
                lastNameLabel.text = findPerson.lastName
                signIn = findPerson
            }
        }
    }
}
