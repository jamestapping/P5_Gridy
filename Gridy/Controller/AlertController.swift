//
//  AlertController.swift
//  Gridy
//
//  Created by James on 27/11/2020.
//

import Foundation
import UIKit


extension UIAlertController{
    class func customAlertController(title : String, message : String) -> UIAlertController{
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) {
            (action: UIAlertAction) in print("Youve pressed OK Button")
        }
        alertController.addAction(OKAction)
        return alertController
    }
}
