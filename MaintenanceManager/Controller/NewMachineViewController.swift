//
//  NewMachineViewController.swift
//  MaintenanceManager
//
//  Created by Yoan on 01/06/2021.
//

import UIKit

class NewMachineViewController: UIViewController {
    
    @IBOutlet weak var newMachineTextField: UITextField!
    @IBOutlet weak var newSerialNumberTextField: UITextField!
    @IBOutlet weak var departmentPickerView: UIPickerView!
    @IBOutlet weak var createMachineOutletButton: UIButton!
    @IBOutlet weak var machineTableView: UITableView!
    
    var machines = Machine.orderByDepartment
    var departments = Department.all
    var refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        machines = Machine.orderByDepartment
        machineTableView.reloadData()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        machineTableView.addSubview(refreshControl)
        
        
    }
    @objc func refresh(_ sender: AnyObject) {
        machines = Machine.orderByDepartment
        machineTableView.reloadData()
        refreshControl.endRefreshing()
    }
    @IBAction func createMachineButton(_ sender: Any) {
        if checkDoubleMachineInList() {
            saveMachine()
        }
        machines = Machine.orderByDepartment
        machineTableView.reloadData()
    }
    
    private func checkDoubleMachineInList() -> Bool {
        let machines = Machine.all
        let newNameMachine = newMachineTextField.text?.capitalizingFirstLetter().trimmingCharacters(in: .whitespaces)
        let newSerialNumber = newSerialNumberTextField.text
        var check = true
        
        for element in machines {
            if element.name == newNameMachine {
                let errorMessage = AlertMessage.presentAlert(alertTitle: "Error", alertMessage: "Le nom de cette machine existe déjà !", buttonTitle: "OK", alertStyle: .cancel)
                present(errorMessage, animated: true)
                check = false
            } else if newSerialNumber != "" {
                        if element.serialNumber == newSerialNumber {
                            let errorMessage = AlertMessage.presentAlert(alertTitle: "Error", alertMessage: "Le numéro de cette machine est déjà utilisé ! - voir - \(String(describing: element.name))", buttonTitle: "OK", alertStyle: .cancel)
                                present(errorMessage, animated: true)
                            check = false
                        }
                    }
        }
        return check
    }
    
    private func saveMachine() {
        guard let machineName = newMachineTextField.text, let machineSerialNumber = newSerialNumberTextField.text else {
            return
        }
        let machine = Machine(context: AppDelegate.viewContext)
        machine.name = machineName.capitalizingFirstLetter().trimmingCharacters(in: .whitespaces)
        machine.serialNumber = machineSerialNumber
        machine.department = getDepartmentSelected()
        do {
            try  AppDelegate.viewContext.save()
           let messageSuccess = AlertMessage.presentAlert(alertTitle: "Success", alertMessage: "La nouvelle machine a été ajoutéé à la liste", buttonTitle: "OK", alertStyle: .cancel)
            present(messageSuccess, animated: true)
            newMachineTextField.text = ""
            newSerialNumberTextField.text = ""
        } catch  {
            let messageError = AlertMessage.presentAlert(alertTitle: "Error", alertMessage: "Une erreur est survenue pendant la sauvegarde de la machine", buttonTitle: "OK", alertStyle: .cancel)
            present(messageError, animated: true)
        }
    }
    
    private func getDepartmentSelected() -> Department? {
        let index = departmentPickerView.selectedRow(inComponent: 0)
        return departments[index]
    }
    
}

extension NewMachineViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return machines.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        machines[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MachineCell", for: indexPath) as? MachineTableViewCell else {
            return UITableViewCell()
        }
        
        let machine = machines[indexPath.section][indexPath.row]
        
        cell.configureMachine(machineName: machine.name ?? "No name", serialNumber: machine.serialNumber ?? "No serial number", machineDepartment: machine.department?.title ?? "no department")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let titleDepartment = machines[section].first?.department, let department = titleDepartment.title else {
            return nil
        }
        var totalMachine = 0
        for _ in machines[section] {
            totalMachine += 1
        }
        let titleHeader = department +  ": \(totalMachine)"
        return titleHeader
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let commit = machines[indexPath.section][indexPath.row]
            AppDelegate.viewContext.delete(commit)
            machines[indexPath.section].remove(at: indexPath.row)
            machineTableView.deleteRows(at: [indexPath], with: .left)
            try? AppDelegate.viewContext.save()
        }
    }
    
}

extension NewMachineViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return departments.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let titleRow = departments[row]
        return titleRow.title
    }
    
    
}
