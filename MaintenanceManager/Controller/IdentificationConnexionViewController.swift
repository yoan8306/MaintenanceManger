//
//  IdentificationConnexionViewController.swift
//  MaintenanceManager
//
//  Created by Yoan on 05/05/2021.
//

import UIKit

class IdentificationConnexionViewController: UIViewController {
    var persons = Person.all
    
    @IBOutlet weak var superUserField: UITextField!
    @IBOutlet weak var passwordSuperUserField: UITextField!
    @IBOutlet weak var AccessSuperUserView: UIView!
    @IBOutlet var addPersonBarButton: UIBarButtonItem! // strong IBOutlet
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var identifiantField: UITextField!
    @IBOutlet weak var goButtonOutlet: UIButton!
    @IBOutlet var principalView: UIView!
    var counter = 0
    
    @IBAction func plusButton(_ sender: UIBarButtonItem) {
        superUserField.becomeFirstResponder()
        UIView.transition(with: AccessSuperUserView, duration: 0.5, options:.transitionCurlUp , animations: { self.AccessSuperUserView.isHidden = false})
        principalView.alpha = 0.7
    }
    @IBAction func superUserButton() {
        if superUserField.text == "Admin" && passwordSuperUserField.text == "" {//"MasterKey" {
           initialiseSuperUserView()
            performSegue(withIdentifier: "bddSuperUserSegue", sender: self)
        }
    }
    
    @IBAction func activeBarButton() {
        if counter == 1 {
            AccessSuperUserView.layer.cornerRadius = 8
            self.navigationItem.rightBarButtonItem = self.addPersonBarButton
        } else {
            counter += 1
        }
    }
    @IBAction func goButton() {
        var success = Bool()
        for findPerson in persons {
            if findPerson.identifiant == identifiantField.text?.lowercased() {
                if findPerson.password == passwordField.text {
                    PersonLogged.personLogged = findPerson.identifiant!
                    success = true
                           initialiseView()
                    animationSuccessButton()
                }
            }
        }
        if !success {
        animationErrorConnexionButton()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialiseSuperUserView()
        }
    
    override func viewWillAppear(_ animated: Bool) {
       initialiseView()
        initialiseSuperUserView()
    }
    
    private func initialiseSuperUserView () {
        principalView.alpha = 1
        superUserField.text = ""
        passwordSuperUserField.text = ""
        AccessSuperUserView.isHidden = true
    }
    
    
    private func initialiseView() {
        principalView.alpha = 1
        persons = Person.all
        passwordField.text = ""
        identifiantField.text = ""
        self.navigationItem.rightBarButtonItem = nil
        counter = 0
        passwordField.resignFirstResponder()
        identifiantField.becomeFirstResponder()
    }
    
    private func animationSuccessButton() {
        UIView.animate(withDuration: 0.5, animations: {
            self.goButtonOutlet.transform = CGAffineTransform(translationX: 80, y: 0)
        },
        completion: { _ in
            UIView.animate(withDuration: 0.6) {
                self.performSegue(withIdentifier: "successSegue", sender: self)
                self.goButtonOutlet.transform = CGAffineTransform.identity
            }
        }
        )
    }
    private func animationErrorConnexionButton() {
        UIView.animate(withDuration: 0.5, animations: {
            self.goButtonOutlet.transform = CGAffineTransform(rotationAngle: .pi)
        },
        completion: { _ in
            UIView.animate(withDuration: 0.3, animations: {
                self.goButtonOutlet.transform = CGAffineTransform.identity
            })
        })
    }
    
    
}

extension IdentificationConnexionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if identifiantField.isFirstResponder {
            passwordField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
extension IdentificationConnexionViewController {
    
    @IBAction func hideKeyboard(_ sender: UITapGestureRecognizer) {
        counter = 0
        principalView.alpha = 1
        identifiantField.resignFirstResponder()
        passwordField.resignFirstResponder()
        superUserField.text = ""
        passwordSuperUserField.text = ""
        AccessSuperUserView.isHidden = true
        self.navigationItem.rightBarButtonItem = nil
    }
}

