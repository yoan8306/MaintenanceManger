//
//  NewEquipmentStatusViewController.swift
//  MaintenanceManager
//
//  Created by Yoan on 06/06/2021.
//

import UIKit

class NewEquipmentStatusViewController: UIViewController {

    @IBOutlet weak var insertButton: UIButton!
    @IBOutlet weak var newStatusEquipmentTextField: UITextField!
    @IBOutlet weak var equipmentStatusTableView: UITableView!
    
    var statusEquipment = EquipmentStatus.all
    
    override func viewDidLoad() {
        statusEquipment = EquipmentStatus.all
        equipmentStatusTableView.reloadData()
        super.viewDidLoad()
        insertButton.layer.cornerRadius = 8
    }
    
    @IBAction func insertButtonAction() {
        if checkDoubleStateInsert() {
            saveNewEquipmentStatus()
        }
    }
    
    private func saveNewEquipmentStatus() {
        guard let newStateEquipment = newStatusEquipmentTextField.text?.capitalizingFirstLetter().trimmingCharacters(in: .whitespaces) else {
            return
        }
        let addNewState = EquipmentStatus(context: AppDelegate.viewContext)
        addNewState.state = newStateEquipment
        
        do {
            let successMessage = AlertMessage.presentAlert(alertTitle: "Success", alertMessage: "Success", buttonTitle: "OK", alertStyle: .cancel)
            try AppDelegate.viewContext.save()
            statusEquipment = EquipmentStatus.all
            equipmentStatusTableView.reloadData()
            present(successMessage, animated: true)
            newStatusEquipmentTextField.text = ""
        } catch  {
            let errorMessage = AlertMessage.presentAlert(alertTitle: "Error", alertMessage: "Une erreur est survenue lors de la sauvegarde.", buttonTitle: "OK", alertStyle: .cancel)
            statusEquipment = EquipmentStatus.all
            equipmentStatusTableView.reloadData()
            present(errorMessage, animated: true)
        }
    }
    
    private func checkDoubleStateInsert() -> Bool {
        let newStateEquipment = newStatusEquipmentTextField.text?.capitalizingFirstLetter().trimmingCharacters(in: .whitespaces)
        if newStateEquipment == "" {
            let errorMessage = AlertMessage.presentAlert(alertTitle: "Error", alertMessage: "Veuillez renseigner le nom d'un nouvelle état d'équipement", buttonTitle: "OK", alertStyle: .cancel)
            present(errorMessage, animated: true)
            return false
        }
            for state in statusEquipment {
                if state.state == newStateEquipment {
                    let errorMessage = AlertMessage.presentAlert(alertTitle: "Error", alertMessage: "Cette état existe déjà.", buttonTitle: "OK", alertStyle: .cancel)
                    present(errorMessage, animated: true)
                    return false
                }
        }
        return true
    }
}


extension NewEquipmentStatusViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusEquipment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "equipmentStatusCell", for: indexPath)
        let statusEquipmentStatusTitle = statusEquipment[indexPath.row]
        
        cell.textLabel?.text = statusEquipmentStatusTitle.state
        
        return cell
    }
    
    
}
