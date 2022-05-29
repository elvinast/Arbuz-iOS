//
//  GreenButton.swift
//  ArbuzTestApp
//
//  Created by Elvina Shamoi on 29.05.2022.
//

import UIKit

class GreenButton: UIButton {

    init(titleText: String) {
        super.init(frame: .zero)
        self.titleLabel?.font = .boldSystemFont(ofSize: 16)
        self.setTitle(titleText, for: .normal)
        self.backgroundColor = .systemGreen
        self.tintColor = .white
        self.layer.cornerRadius = 20
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
