//
//  ViewController+.swift
//  ArbuzTestApp
//
//  Created by Elvina Shamoi on 29.05.2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(with text: String, message: String = "") {
        let alert = UIAlertController(title: text, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
