//
//  Report.swift
//  MaintenanceManager
//
//  Created by Yoan on 18/05/2021.
//

import Foundation
import CoreData
class Report: NSManagedObject {
    static var all : [Report] {
        let request: NSFetchRequest<Report> = Report.fetchRequest()
        guard let reports = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return reports
     }
}
