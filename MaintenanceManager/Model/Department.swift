//
//  Department.swift
//  MaintenanceManager
//
//  Created by Yoan on 05/05/2021.
//

import Foundation
import CoreData

class Department: NSManagedObject {
    static var all : [Department] {
        let request: NSFetchRequest<Department> = Department.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        guard let departments = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return departments
    }
}

struct DepartmentList {
  static let department = ["Control & Quality",
                           "Facilities",
                           "Filling Packaging",
                           "Engineering",
                           "RD Dx",
                           "RD Ls",
                           "Validation"]
}
