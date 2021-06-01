//
//  Machine.swift
//  MaintenanceManager
//
//  Created by Yoan on 01/06/2021.
//

import Foundation
import CoreData


class Machine: NSManagedObject {
    static var all: [Machine] {
        let request : NSFetchRequest <Machine> = Machine.fetchRequest()
        guard let machines = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return machines
     }
}

extension Machine {
    static func listByDepartment(departmentField: String) -> [Machine] {
        var dict: [Machine] = []
        let machines = Machine.all
        for element in machines {
            if element.department?.title == departmentField {
                dict.append(element)
            }
        }
        return dict
    }
    
}
