//
//  SuccessVC.swift
//  ArbuzTestApp
//
//  Created by Elvina Shamoi on 29.05.2022.
//

import UIKit

class SuccessVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
    }
    
    let imageView = UIImageView(image: UIImage(named: "happy"))
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Ваш заказ успешно создан:)"
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    
    let button = GreenButton(titleText: "На главную")
    
    func configureUI() {
        view.backgroundColor = .white
        button.addTarget(self, action: #selector(goHome), for: .touchUpInside)
        [imageView, label, button].forEach {
            view.addSubview($0)
        }
    }
    
    @objc private func goHome() {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
    func configureConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(K.screenHeight / 3)
        }
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(20)
        }
        button.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(50)
            make.height.equalTo(48)
        }
    }

}
