//
//  ReportFacilitiesViewController.swift
//  MaintenanceManager
//
//  Created by Yoan on 18/05/2021.
//

import UIKit

class RequestFacilitiesViewController: UIViewController {
    var colorBorderTextField = #colorLiteral(red: 0.7490938306, green: 0.7686418295, blue: 0.7889478803, alpha: 0.9531830937).cgColor
    let interventionTypeDict = ["Amélioration", "Correctif", "Préventif", "Travaux Neuf"]
    var departments = Department.all
    var machines = Machine.all
    
    @IBOutlet var generalView: UIView!
    
    @IBOutlet weak var interventionTypeButtonOutlet: UIButton!
    @IBOutlet weak var departmentButtonOutlet: UIButton!
    @IBOutlet weak var departmentUiView: UIView!
    @IBOutlet weak var departmentTableView: UITableView!
    @IBOutlet weak var interventionTypeTexField: UITextField!
    @IBOutlet weak var departmentField: UITextField!
    @IBOutlet weak var nonComplianceSwitch: UISwitch!
    @IBOutlet weak var nonComplianceTextField: UITextField!
    @IBOutlet weak var machineTextField: UITextField!
    @IBOutlet weak var requestTextView: UITextView!
    @IBOutlet weak var numberNonComplianceLabel: UILabel!
    @IBOutlet weak var interventionTypeUiView: UIView!
    @IBOutlet weak var interventionTypeTableView: UITableView!
    @IBOutlet weak var machineButtonOutlet: UIButton!
    @IBOutlet weak var machineUiView: UIView!
    @IBOutlet weak var machineTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nonComplianceHidden()
        designedView()
    }
    
    @IBAction func backwardBarButtonItem(_ sender: UIBarButtonItem) {
        dismiss(animated: true) {}
    }
    
    @IBAction func machineButton() {
        machineTableView.reloadData()
        showOrHiddenMachineUiView()
    }
   
    @IBAction func departmentButton() {
       showOrHiddenDepartmentUiView()
    }
    
    @IBAction func interventionTypeButton() {
        showOrHiddenInterventionTypeUiView()
    }
    
    @IBAction func nonComplianceSwitchAction() {
        if nonComplianceSwitch.isOn {
            nonComplianceShow()
        } else {
            nonComplianceHidden()
        }
    }
    
    private func showOrHiddenMachineUiView() {
        if machineUiView.isHidden {
            UIView.transition(with: machineUiView, duration: 0.3, options: .transitionCrossDissolve , animations: { self.machineUiView.isHidden = false})
        } else {
            UIView.transition(with: machineUiView, duration: 0.3, options: .transitionCrossDissolve , animations: { self.machineUiView.isHidden = true})
        }
    }
    
    
    private func showOrHiddenInterventionTypeUiView() {
        if interventionTypeUiView.isHidden {
            UIView.transition(with: interventionTypeUiView, duration: 0.3, options: .transitionCrossDissolve , animations: { self.interventionTypeUiView.isHidden = false})
        } else {
            UIView.transition(with: interventionTypeUiView, duration: 0.3, options: .transitionCrossDissolve , animations: { self.interventionTypeUiView.isHidden = true})
        }
    }
    
    private func showOrHiddenDepartmentUiView() {
        if departmentUiView.isHidden {
            UIView.transition(with: departmentUiView, duration: 0.3, options: .transitionCrossDissolve , animations: { self.departmentUiView.isHidden = false})
        } else {
            UIView.transition(with: departmentUiView, duration: 0.5, options: .transitionCrossDissolve , animations: { self.departmentUiView.isHidden = true})
        }
    }
    
    private func designedView() {
        designedInterventionTypeView()
        designedDepartmentUiView()
        designedMachineUiView()
        designedMachineButton()
        designedDepartmentButton()
        designedInterventionTypeButton()
    }
    
    private func designedMachineUiView() {
        machineUiView.layer.borderWidth = 1
        machineUiView.layer.cornerRadius = 10
        machineUiView.layer.borderColor = colorBorderTextField
        machineUiView.layer.shadowColor = UIColor.black.cgColor
        machineUiView.layer.shadowOpacity = 0.7
        machineUiView.layer.shadowOffset = .init(width: 0, height: 4)
        machineUiView.layer.shadowRadius = 8
    }
    
    private func designedInterventionTypeButton() {
        interventionTypeButtonOutlet.layer.borderWidth = 1
        interventionTypeButtonOutlet.layer.borderColor =  colorBorderTextField
        interventionTypeButtonOutlet.layer.cornerRadius = 3
    }
    
    private func designedDepartmentButton() {
        departmentButtonOutlet.layer.borderWidth = 1
        departmentButtonOutlet.layer.borderColor = colorBorderTextField
        departmentButtonOutlet.layer.cornerRadius = 3
    }
    
    private func designedMachineButton() {
        machineButtonOutlet.layer.borderWidth = 1
        machineButtonOutlet.layer.borderColor = colorBorderTextField
        machineButtonOutlet.layer.cornerRadius = 4
    }
    
    private func designedInterventionTypeView() {
        interventionTypeUiView.layer.borderWidth = 1
        interventionTypeUiView.layer.cornerRadius = 10
        interventionTypeUiView.layer.borderColor = colorBorderTextField
        interventionTypeUiView.layer.shadowColor = UIColor.black.cgColor
        interventionTypeUiView.layer.shadowOpacity = 0.7
        interventionTypeUiView.layer.shadowOffset = .init(width: 0, height: 4)
        interventionTypeUiView.layer.shadowRadius = 8
    }
    
    private func designedDepartmentUiView() {
        departmentUiView.layer.borderWidth = 1
        departmentUiView.layer.cornerRadius = 10
        departmentUiView.layer.borderColor = colorBorderTextField
        departmentUiView.layer.shadowColor = UIColor.black.cgColor
        departmentUiView.layer.shadowOpacity = 0.7
        departmentUiView.layer.shadowOffset = .init(width: 0, height: 4)
        departmentUiView.layer.shadowRadius = 8
    }
    
    private func nonComplianceShow() {
        numberNonComplianceLabel.alpha = 1
        nonComplianceTextField.alpha = 1
    }
    
    private func nonComplianceHidden() {
        numberNonComplianceLabel.alpha = 0
        nonComplianceTextField .alpha = 0
        nonComplianceTextField.resignFirstResponder()
    }
    
    private func applyBlurEffect() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
}

///Mark Table View ///

extension RequestFacilitiesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberSection = 0
        if  tableView == interventionTypeTableView {
            numberSection = interventionTypeDict.count
        } else if tableView == departmentTableView {
            numberSection = departments.count
        } else if tableView == machineTableView {
            numberSection = Machine.listByDepartment(departmentField: departmentField.text!).count
        }
            return numberSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if tableView == interventionTypeTableView {
         cell = tableView.dequeueReusableCell(withIdentifier: "interventionTypeCell", for: indexPath)
        let type = interventionTypeDict[indexPath.row]
        cell.textLabel?.text = type
        } else
        if tableView == departmentTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "departmentCell", for: indexPath)
            let department = departments[indexPath.row]
            cell.textLabel?.text = department.title
        } else
        if tableView == machineTableView {
            cell =  tableView.dequeueReusableCell(withIdentifier: "machineCell", for: indexPath)
            let machine = Machine.listByDepartment(departmentField: departmentField.text!)[indexPath.row]
            cell.textLabel?.text = machine.name
            cell.detailTextLabel?.text = machine.serialNumber
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == interventionTypeTableView {
        interventionTypeTexField.text = interventionTypeDict[indexPath.row]
        interventionTypeUiView.isHidden = true
        } else if tableView == departmentTableView {
            let select = departments[indexPath.row]
            departmentField.text = select.title
            machineTextField.text = ""
            departmentUiView.isHidden = true
        } else if tableView == machineTableView {
            let machineSelected = MachineList.filterMachineByDepartment(field: departmentField.text!)[indexPath.row]
            machineTextField.text = machineSelected.machineName + " - S/N: " + machineSelected.serialNumber
            machineUiView.isHidden = true
        }
    }
}

