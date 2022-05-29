//
//  BasicTextField.swift
//  ArbuzTestApp
//
//  Created by Elvina Shamoi on 29.05.2022.
//

import UIKit

class BasicTextField: UITextField {

    init(placeholder: String) {
        super.init(frame: .zero)
        self.layer.cornerRadius = 10
        self.borderStyle = .roundedRect
        self.layer.borderWidth = 0.3
        self.font = .boldSystemFont(ofSize: 12)
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.placeholder = placeholder
        self.leftViewMode = .always
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
