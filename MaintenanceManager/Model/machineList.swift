//
//  MachineList.swift
//  MaintenanceManager
//
//  Created by Yoan on 25/05/2021.
//

import Foundation
struct MachineList {
    var machineName = ""
    var serialNumber = ""
    var categoryDepartment = ""
    
    static let machine = [
        MachineList(machineName: "Osmoseur", serialNumber: "Os2", categoryDepartment: DepartmentList.department[1] ),
        MachineList(machineName: "comas", serialNumber: "255", categoryDepartment: DepartmentList.department[2]),
        MachineList(machineName: "comas", serialNumber: "256", categoryDepartment: DepartmentList.department[2]),
        MachineList(machineName: "AktaPure", serialNumber: "1321", categoryDepartment: DepartmentList.department[3]),
        MachineList(machineName: "Akta Avant", serialNumber: "2000", categoryDepartment: DepartmentList.department[5]),
        MachineList(machineName: "Toc", serialNumber: "150", categoryDepartment: DepartmentList.department[6])
    ]
     
    static func countMachineListDepartment(field: String) -> Int {
        var count = 0
        var dict: [String] = []
        for element in MachineList.machine {
            if element.categoryDepartment == field {
                dict.append(element.machineName)
                count += 1
            }
        }
       return count
    }
    static func filterMachineByDepartment(field: String) -> [MachineList] {
        var dict: [MachineList] = []
        for element in MachineList.machine {
            if element.categoryDepartment == field {
                dict.append(MachineList(machineName: element.machineName, serialNumber: element.serialNumber, categoryDepartment: element.categoryDepartment))
            }
        }
        return dict
    }
    
}
