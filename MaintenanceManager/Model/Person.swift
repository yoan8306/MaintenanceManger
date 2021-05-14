//
//  Person.swift
//  MaintenanceManager
//
//  Created by Yoan on 05/05/2021.
//
import CoreData
import Foundation

class Person: NSManagedObject  {
    static var all: [Person] {
        let request: NSFetchRequest<Person> = Person.fetchRequest()
       // request.sortDescriptors = [NSSortDescriptor(key: "firstName", ascending: true)]
        guard let persons = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return persons
    }
}

extension Person {
    
     func savePerson(firstName: String, lastName: String, password:String, jobRole: Job, department: Department, identifiant: String) {
        let person = Person(context: AppDelegate.viewContext)
        
        person.firstName = firstName
        person.lastName = lastName
        person.password = password
        person.department = department
        person.job = jobRole
        person.identifiant = identifiant
        
        do {
            try AppDelegate.viewContext.save()
        } catch {
//            presentAlert()
        }
    }
    
//    private func presentAlert () {
//        let alertVC = UIAlertController(title: "Erreur", message: "La personne que vous venez d'ajouter n'a pas être enregistrée pour une raison inconnue", preferredStyle: .alert)
//        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alertVC.addAction(action)
//        present(alertVC, animated: true, completion: nil)
//    }
}

