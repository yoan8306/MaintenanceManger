//
//  NewDepartmentViewController.swift
//  MaintenanceManager
//
//  Created by Yoan on 28/05/2021.
//

import UIKit

class NewDepartmentViewController: UIViewController {

    @IBOutlet weak var departmentTableView: UITableView!
    @IBOutlet weak var createNewDepartmentOutlet: UIButton!
    @IBOutlet weak var newDepartmentTextField: UITextField!
    var refreshControl = UIRefreshControl()
    var department = Department.all
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNewDepartmentOutlet.layer.cornerRadius = 8
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        departmentTableView.addSubview(refreshControl)
    }
    @objc func refresh(_ sender: AnyObject) {
        department = Department.all
        departmentTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    @IBAction func createNewDepartment() {
        if checkDoubleDepartmentInsert() {
          saveNewDepartment()
        }
    }
    
    private func saveNewDepartment() {
        let NewDepartment = newDepartmentTextField.text?.capitalizingFirstLetter().trimmingCharacters(in: .whitespaces)
        let addNewDepartment = Department(context: AppDelegate.viewContext)
        addNewDepartment.title = NewDepartment
        newDepartmentTextField.text = ""
        do {
            try AppDelegate.viewContext.save()
            let message = AlertMessage.presentAlert(alertTitle: "Success", alertMessage: "Success", buttonTitle: "OK", alertStyle: .cancel)
            present(message, animated: true) {
                self.department = Department.all
                self.departmentTableView.reloadData()
            }
        } catch  {
            let message = AlertMessage.presentAlert(alertTitle: "Error", alertMessage: "Une erreur est survenue durant la sauvegarde. Veuillez recommencer l'opération", buttonTitle: "OK", alertStyle: .cancel)
            present(message, animated: true) {
                self.department = Department.all
                self.departmentTableView.reloadData()
            }
        }
    }
    
    private func checkDoubleDepartmentInsert() -> Bool {
        let NewDepartment = newDepartmentTextField.text?.capitalizingFirstLetter().trimmingCharacters(in: .whitespaces)
        if NewDepartment == "" {
            let message = AlertMessage.presentAlert(alertTitle: "Error", alertMessage: "Veuillez renseigner le nom d'une nouvelle catégorie", buttonTitle: "OK", alertStyle: .cancel)
            present(message, animated: true, completion: nil)
            return false
        }
            for department in department {
                if department.title == NewDepartment {
                    let message = AlertMessage.presentAlert(alertTitle: "Error", alertMessage: "Cette catégorie existe déjà.", buttonTitle: "OK", alertStyle: .cancel)
                    present(message, animated: true, completion: nil)
                    return false
                }
        }
        return true
    }
    
}

extension NewDepartmentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        department.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "departmentCell", for: indexPath)
        let departmentTitle = department[indexPath.row]
        
        cell.textLabel?.text = departmentTitle.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexpath: IndexPath) {
        if editingStyle == .delete {
            let commit = department[indexpath.row]
            AppDelegate.viewContext.delete(commit)
           department.remove(at: indexpath.row)
            tableView.deleteRows(at: [indexpath], with: .automatic)
           try? AppDelegate.viewContext.save()
        }
    }
}
