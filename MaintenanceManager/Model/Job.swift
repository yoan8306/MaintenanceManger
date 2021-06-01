//
//  Job.swift
//  MaintenanceManager
//
//  Created by Yoan on 05/05/2021.
//

import Foundation
import CoreData

class Job: NSManagedObject {
    static var all: [Job] {
        let request : NSFetchRequest<Job> = Job.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "jobRole", ascending: true)]
        
        guard let jobs = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return jobs
     }
}

