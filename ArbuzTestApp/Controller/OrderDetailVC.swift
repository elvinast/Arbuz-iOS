//
//  OrderDetailView.swift
//  ArbuzTestApp
//
//  Created by Elvina Shamoi on 29.05.2022.
//

import UIKit

class OrderDetailVC: UIViewController {

    var totalSum: Int? {
        didSet {
            guard let totalSum = totalSum else { return }
            nextButton.setTitle("Оформить заказ: \(totalSum) тг", for: .normal)
        }
    }
    
    lazy var nextButton: GreenButton = {
        let button = GreenButton(titleText: "Оформить заказ")
        button.addTarget(self, action: #selector(nextClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var enterLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите данные для доставки"
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var addressTextField = BasicTextField(placeholder: "Название улицы")
    lazy var homeTextField = BasicTextField(placeholder: "Номер дома")
    lazy var flatNumberTextField = BasicTextField(placeholder: "№ квартиры")
    lazy var homeNumTextField = BasicTextField(placeholder: "Подъезд")
    lazy var clientNameTextField = BasicTextField(placeholder: "Ваше имя")
    lazy var phoneTextField = BasicTextField(placeholder: "Введите номер телефона")
    let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
    }
    
    @objc private func nextClicked() {
        if isValid() {
            let vc = SuccessVC()
            present(vc, animated: true)
        }
    }
    
    private func isValid() -> Bool {
        var valid = true
        [addressTextField.text, homeTextField.text, clientNameTextField.text, phoneTextField.text].forEach {
            if ($0 ?? "").isEmpty {
                showAlert(with: "Введите все поля")
                valid = false
            }
        }
        if !valid { return false }
        if !validateField(string: addressTextField.text ?? "") {
            showAlert(with: "Поле улицы должно содержать только буквы.")
            return false
        }
        if !validateField(string: clientNameTextField.text ?? "") {
            showAlert(with: "Имя должно содержать только буквы.", message: "Только если вы не ребенок Илона Маска:)")
            return false
        }
        return true
    }
    
    private func validateField(string: String) -> Bool {
        let validationFormat = "[а-яА-Я\\s]+"
        let fieldPredicate = NSPredicate(format:"SELF MATCHES %@", validationFormat)
        return fieldPredicate.evaluate(with: string)
    }

    private func configureUI() {
        datePicker.locale = Locale(identifier: "ru")
        view.backgroundColor = .white
        [nextButton, addressTextField, enterLabel, homeTextField, flatNumberTextField, homeNumTextField, clientNameTextField, phoneTextField, datePicker].forEach {
            view.addSubview($0)
        }
    }
    
    private func configureConstraints() {
        
        homeTextField.snp.makeConstraints { make in
            make.width.equalTo(K.screenWidth / 3.3)
            make.height.equalTo(48)
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(addressTextField.snp.bottom).offset(20)
        }
        
        homeNumTextField.snp.makeConstraints { make in
            make.width.equalTo(K.screenWidth / 3.3)
            make.height.equalTo(48)
            make.left.equalTo(homeTextField.snp.right).offset(8)
            make.top.equalTo(addressTextField.snp.bottom).offset(20)
        }
        
        flatNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(addressTextField.snp.bottom).offset(20)
            make.height.equalTo(48)
            make.left.equalTo(homeNumTextField.snp.right).offset(8)
            make.right.equalToSuperview().inset(15)
        }
        
        clientNameTextField.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(homeTextField.snp.bottom).offset(20)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(clientNameTextField.snp.bottom).offset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(60)
            make.height.equalTo(48)
        }
        
        enterLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50)
        }
        
        addressTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(enterLabel.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
}
