//
//  SharedMethods.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 29/07/2024.
//

import Foundation
import UIKit

extension UIViewController{
    func showAlerts(title:String,message:String) {
           let alert = UIAlertController(title: title, message:message , preferredStyle: .alert)
           let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           alert.addAction(okAction)
           
           self.present(alert, animated: true, completion: nil)
    }
}
