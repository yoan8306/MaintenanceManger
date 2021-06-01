//
//  CreatePersonViewController.swift
//  MaintenanceManager
//
//  Created by Yoan on 05/05/2021.
//

import UIKit

class CreatePersonViewController: UIViewController {
var personSelectedCell = Person()
    var persons = Person.all
    var person = Person()
   
    
    let department = Department.all
    let job = Job.all
    var jobIndex : String = "no job"
    var departmentIndex : String = "no department"
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var createButtonOutlet: UIButton!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var departmentPickerView: UIPickerView!
    @IBOutlet weak var jobPickerView: UIPickerView!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var addDepartmentButton: UIButton!
    @IBOutlet weak var addJobRoleButton: UIButton!
    
    
    @IBAction func hideKeyboard(_ sender: UITapGestureRecognizer) {
        firstNameField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    
    override func viewDidLoad() {
        persons = Person.all
        designedButtonAdd()
        createButtonDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func createButton() {
        if checkField() && checkPassWord() {
        addPerson()
            resetView()
            persons = Person.all
            tableView.reloadData()
        } else {
           return
        }
    }
    
    private func designedButtonAdd() {
        addDepartmentButton.layer.cornerRadius = 8
        addJobRoleButton.layer.cornerRadius = 8
    }
    
    private func addPerson() {
        let firstName = firstNameField.text?.filter { !$0.isWhitespace }
        let lastName = lastNameField.text?.trimmingCharacters(in: .whitespaces)
        let password = passwordField.text?.trimmingCharacters(in: .whitespaces)
        
        let initialFirstName = firstName?.components(separatedBy: "-")
        var firstNameIdentifiant = ""

        for string in initialFirstName! {
            firstNameIdentifiant += String(string.first!.lowercased())
        }
        
        guard let personFirstName = firstName, let personLastName = lastName, let personPassword = password else {
            return
        }
            var identifiant = String()
        identifiant = firstNameIdentifiant + personLastName.lowercased()
        
        let person = Person(context: AppDelegate.viewContext)
        person.firstName = personFirstName
        person.lastName = personLastName
        person.password = personPassword
        person.department = getSelectDepartment()
        person.identifiant = identifiant
        person.job = getSelectJob()
        try? AppDelegate.viewContext.save()
        
    }
    
    private func getSelectDepartment() -> Department? {
        let index = departmentPickerView.selectedRow(inComponent: 0)
        return department[index]
    }
    
    private func getSelectJob() -> Job? {
        let index = jobPickerView.selectedRow(inComponent: 0)
        return job[index]
    }
    
    
    private func resetView() {
        passwordField.layer.borderWidth = 0
        confirmPasswordField.layer.borderWidth = 0
        firstNameField.text = ""
        lastNameField.text = ""
        passwordField.text = ""
        confirmPasswordField.text = ""
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
    
    private func checkField() ->Bool {
        var error = 0
        if firstNameField.text!.count >= 3 {
            firstNameField.layer.borderWidth = 0
            firstNameField.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            firstNameLabel.isHidden = true
        } else {
            firstNameField.layer.borderWidth = 2
            firstNameField.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            firstNameField.layer.cornerRadius = 6
            firstNameLabel.isHidden = false
            firstNameLabel.text = "More or equal 3 characters"
            firstNameLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
           error += 1
        }
        if lastNameField.text!.count >= 3 {
            lastNameField.layer.borderWidth = 2
            lastNameField.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            lastNameLabel.isHidden = true
        } else {
            lastNameField.layer.borderWidth = 2
            lastNameField.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            lastNameField.layer.cornerRadius = 6
            lastNameLabel.isHidden = false
            lastNameLabel.text = "More or equal 3 characters"
            lastNameLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            error += 1
        }
        if error == 0 {
            return true
        } else {
            return false
        }
    }
    
    private func createButtonDesign() {
        createButtonOutlet.layer.cornerRadius = 8
        createButtonOutlet.layer.borderWidth = 3
        createButtonOutlet.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        createButtonOutlet.layer.shadowOffset = .zero
        createButtonOutlet.layer.shadowRadius = 8
        createButtonOutlet.layer.shadowColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        createButtonOutlet.layer.shadowOpacity = 1
    }
}

extension CreatePersonViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as? PersonTableViewCell else {
            return UITableViewCell()
        }
        let person = persons[indexPath.row]
        
        cell.configure(firstName: person.firstName!, lastName: person.lastName!, password: person.password ?? "No passWord", department: person.department?.title ?? "No department", jobRole: (person.job?.jobRole) ?? "No value", identifiant: person.identifiant ?? "No identifiant")
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        personSelectedCell = persons[indexPath.row]
        performSegue(withIdentifier: "DetailPerson", sender: self)
        }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailPerson" {
            let personSelectedVC = segue.destination as! PersonDetailViewController
            personSelectedVC.personSelected = personSelectedCell
        }
    }
}

extension CreatePersonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let commit = persons[indexPath.row]
            AppDelegate.viewContext.delete(commit)
            persons.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            try? AppDelegate.viewContext.save()
        }
    }
}

extension CreatePersonViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
            return titleRow.title
        } else if pickerView == jobPickerView {
            let titleRow = job[row]
            return titleRow.jobRole
        }
        return ""
    }
    
}
