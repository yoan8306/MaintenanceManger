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
        }
    }
}

class PersonLogged {
    private struct Logged {
    static let personLogged = String()
}
    static var personLogged: String {
        get {
            return UserDefaults.standard.string(forKey: Logged.personLogged) ?? "No value"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Logged.personLogged)
        }
    }
}
