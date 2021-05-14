//
//  PersonDetailViewController.swift
//  MaintenanceManager
//
//  Created by Yoan on 13/05/2021.
//

import UIKit

class PersonDetailViewController: UIViewController {
    var personSelected = Person()

    @IBOutlet weak var departmentPickerView: UIPickerView!
    @IBOutlet weak var jobPickerView: UIPickerView!
    @IBOutlet weak var departmentSwitch: UISwitch!
    @IBOutlet weak var jobSwitch: UISwitch!
    @IBOutlet weak var passwordSwitch: UISwitch!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var cancelButtonOutlet: UIButton!
    @IBOutlet weak var confirmButtonOutlet: UIButton!
    @IBOutlet weak var firstNameLastNameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var departmentJobLabel: UILabel!
    
    var job = JobPicker.job
    var department = DepartmentPicker.department
    
    @IBAction func departmentSwitchAction() {
        if departmentSwitch.isOn {
            departmentPickerView.isHidden = false
        } else {
            departmentPickerView.isHidden = true
        }
       
    }
    @IBAction func jobSwitchAction() {
        if jobSwitch.isOn {
            jobPickerView.isHidden = false
        } else {
            jobPickerView.isHidden = true
        }
       
    }
    
    @IBAction func passwordSwitchAction() {
        if passwordSwitch.isOn {
            passwordField.isHidden = false
            confirmPasswordField.isHidden = false
        } else {
            passwordLabel.isHidden = true
            passwordField.isHidden = true
            confirmPasswordField.isHidden = true
        }
    }
    @IBAction func confirmButton() {
            saveNewData()
        resetView()
    }
    
    @IBAction func cancelButton() {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameLastNameLabel.text = "\(personSelected.firstName!) \(personSelected.lastName!)"
        departmentJobLabel.text = "\(personSelected.department?.title ?? "No department") / \(personSelected.job?.jobRole ?? "No job")"
        designedButton()
    }
    
        private func checkPassWord() -> Bool{
            if (passwordField.text == confirmPasswordField.text) && (passwordField.text!.count > 5) {
                passwordLabel.isHidden = true
                return true
            } else {
                let red = UIColor.red
                passwordField.layer.borderColor = red.cgColor
                confirmPasswordField.layer.borderColor = red.cgColor
                passwordField.layer.borderWidth = 2
                confirmPasswordField.layer.borderWidth = 2
                passwordField.layer.cornerRadius = 6
                confirmPasswordField.layer.cornerRadius = 6
                passwordLabel.isHidden = false
                passwordLabel.text = "Contains more 5 characters or is not same password"
                passwordLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                return false
            }
        }
    
    private func saveNewData() {
        if jobSwitch.isOn {
            let jobIndex = jobPickerView.selectedRow(inComponent: 0)
            personSelected.job?.jobRole = job[jobIndex]
        }
        if departmentSwitch.isOn {
            let departmentIndex = departmentPickerView.selectedRow(inComponent: 0)
            personSelected.department?.title = department[departmentIndex]
        }
        if passwordSwitch.isOn {
            if checkPassWord() {
                personSelected.password = confirmPasswordField.text
                passwordField.text = ""
                confirmPasswordField.text = ""
            }
        }
        do {
            try AppDelegate.viewContext.save()
        } catch {
        }
    }
    
    private func resetView() {
        jobSwitch.isOn = false
        jobPickerView.isHidden = true
        departmentSwitch.isOn = false
        departmentPickerView.isHidden = true
        if !passwordSwitch.isOn {
            passwordLabel.isHidden = true
            passwordSwitch.isOn = false
            passwordField.isHidden = true
            passwordField.text = ""
            confirmPasswordField.isHidden = true
            confirmPasswordField.text = ""
        }
        departmentJobLabel.text = "\(personSelected.department?.title ?? "No department") / \(personSelected.job?.jobRole ?? "No job")"
    }
    private func designedButton() {
        confirmButtonOutlet.layer.cornerRadius = 8
        confirmButtonOutlet.layer.borderWidth = 1
        cancelButtonOutlet.layer.cornerRadius = 8
        cancelButtonOutlet.layer.borderWidth = 1
    }
}

extension PersonDetailViewController: UIPickerViewDataSource, UIPickerViewDelegate {
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            var countRows: Int = 0
            if pickerView == departmentPickerView {
                countRows = department.count
            } else if pickerView == jobPickerView {
                countRows = job.count
            }
            return countRows
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if pickerView == departmentPickerView {
                let titleRow = department[row]
                return titleRow
            } else if pickerView == jobPickerView {
                let titleRow = job[row]
                return titleRow
            }
            return ""
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if pickerView == departmentPickerView {
              print(self.department[row])
            } else if pickerView == jobPickerView {
              print(self.job[row])
            }
        }

}
