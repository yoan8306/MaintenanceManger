//
//  NewJobRoleViewController.swift
//  MaintenanceManager
//
//  Created by Yoan on 30/05/2021.
//

import UIKit

class NewJobRoleViewController: UIViewController {

    
    @IBOutlet weak var newJobTextField: UITextField!
    @IBOutlet weak var createNewJobButton: UIButton!
    @IBOutlet weak var jobTableView: UITableView!
    var refreshControl = UIRefreshControl()
    
    var jobs = Job.all
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNewJobButton.layer.cornerRadius = 8
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        jobTableView.addSubview(refreshControl)
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
        jobs = Job.all
        jobTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    @IBAction func CreateNewJobActionButton() {
        if checkDoubleJobInsert() {
            saveNewJob()
        }
    }
    
    private func saveNewJob() {
        let newJob = newJobTextField.text?.capitalizingFirstLetter().trimmingCharacters(in: .whitespaces)
        let addNewJob = Job(context: AppDelegate.viewContext)
        addNewJob.jobRole = newJob
        do {
            let successMessage = AlertMessage.presentAlert(alertTitle: "Success", alertMessage: "Success", buttonTitle: "OK", alertStyle: .cancel)
            try AppDelegate.viewContext.save()
            jobs = Job.all
            jobTableView.reloadData()
            present(successMessage, animated: true)
            newJobTextField.text = ""
        } catch  {
            let errorMessage = AlertMessage.presentAlert(alertTitle: "Error", alertMessage: "Une erreur est survenue lors de la sauvegarde.", buttonTitle: "OK", alertStyle: .cancel)
            jobs = Job.all
            jobTableView.reloadData()
            present(errorMessage, animated: true)
        }
    }
    
    private func checkDoubleJobInsert() -> Bool {
        let newJob = newJobTextField.text?.capitalizingFirstLetter().trimmingCharacters(in: .whitespaces)
        if newJob == "" {
            let errorMessage = AlertMessage.presentAlert(alertTitle: "Error", alertMessage: "Veuillez renseigner le nom d'une nouvelle catégorie", buttonTitle: "OK", alertStyle: .cancel)
            present(errorMessage, animated: true)
            return false
        }
            for jobRole in jobs {
                if jobRole.jobRole == newJob {
                    let errorMessage = AlertMessage.presentAlert(alertTitle: "Error", alertMessage: "Cette categorie existe déjà.", buttonTitle: "OK", alertStyle: .cancel)
                    present(errorMessage, animated: true)
                    return false
                }
        }
        return true
    }
}


extension NewJobRoleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        jobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell", for: indexPath)
        let jobTitle = jobs[indexPath.row]
        
        cell.textLabel?.text = jobTitle.jobRole
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexpath: IndexPath) {
        if editingStyle == .delete {
            let commit = jobs[indexpath.row]
            AppDelegate.viewContext.delete(commit)
           jobs.remove(at: indexpath.row)
            tableView.deleteRows(at: [indexpath], with: .automatic)
           try? AppDelegate.viewContext.save()
        }
    }
    
}

