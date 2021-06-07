//
//  EquipmentStatus.swift
//  MaintenanceManager
//
//  Created by Yoan on 02/06/2021.
//

import Foundation
import CoreData

class EquipmentStatus: NSManagedObject {
    static var all: [EquipmentStatus] {
        let request: NSFetchRequest<EquipmentStatus> = EquipmentStatus.fetchRequest()
        guard let status = try? AppDelegate.viewContext.fetch(request) else {
            return[]
        }
       
        return status
    }
}
