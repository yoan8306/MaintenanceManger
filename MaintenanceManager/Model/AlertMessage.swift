//
//  AlertMessage.swift
//  MaintenanceManager
//
//  Created by Yoan on 31/05/2021.
//

import Foundation
import UIKit

struct AlertMessage {
    static func presentAlert (alertTitle title: String, alertMessage message: String,buttonTitle titleButton: String, alertStyle style: UIAlertAction.Style ) -> UIAlertController {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: titleButton, style: style, handler: nil)
        alertVC.addAction(action)
        return alertVC
    }
}
