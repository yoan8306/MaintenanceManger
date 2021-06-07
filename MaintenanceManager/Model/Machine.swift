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
    
    static var orderByDepartment: [[Machine]] {
        let request: NSFetchRequest<Machine> = Machine.fetchRequest()
//        request.sortDescriptors = [
//            NSSortDescriptor(key: "machine.name", ascending: true)]
        guard let machine = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return machine.convertedToArrayOfArray
    }
}

extension Array where Element == Machine {
    var convertedToArrayOfArray: [[Machine]] {
        var dict = [Department: [Machine]]()
        for machine in self where machine.department != nil {
            dict[machine.department!, default: []].append(machine)
        }
        var result = [[Machine]]()
        for (_, val) in dict {
            result.append(val)
        }
        return result
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
