//
//  Extensions.swift
//  LocalNotifications
//
//  Created by Mohamed Sobhi  Fouda on 7/31/18.
//  Copyright © 2018 CareerFoundry. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error:", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
