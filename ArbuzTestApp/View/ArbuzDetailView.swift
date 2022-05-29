//
//  ArbuzDetailView.swift
//  ArbuzTestApp
//
//  Created by Elvina Shamoi on 29.05.2022.
//

import UIKit

class ArbuzDetailView: UIView {
    
    var arbuzInfo: Arbuz? {
        didSet {
            nameLabel.text = arbuzInfo?.name ?? ""
//            quantityLabel.text = "\(arbuzInfo?.quantity ?? 1)"
            counterView.cnt = arbuzInfo?.quantity ?? 1
            descriptionLabel.text = arbuzInfo?.description ?? ""
            if let weight = arbuzInfo?.weight, let price = arbuzInfo?.price {
                weightLabel.text = "Вес: \(weight) кг"
                totalPriceLabel.text = "Цена: \(Int((weight * price).rounded())) тг"
                priceKg.text = "\(price)/кг"
            }
            if let status = arbuzInfo?.status.rawValue {
                setStatus(with: status)
            }
        }
    }
    
    private lazy var counterView = CounterView()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    let weightLabel = UILabel()
    
    let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    let priceKg = UILabel()
    let quantityLabel = UILabel()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    var delegate: QuantityChangedDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        counterView.cnt = arbuzInfo?.quantity ?? 1
        counterView.layer.backgroundColor = UIColor.secondarySystemBackground.cgColor
        counterView.layer.cornerRadius = 10
        counterView.didSelectItem = {
            let cnt = self.counterView.cnt
            guard let arbuzItem = self.arbuzInfo else { return }
            self.delegate?.changeQuantity(item: arbuzItem , quantity: self.counterView.cnt)
        }
        [nameLabel, weightLabel, totalPriceLabel, counterView, descriptionLabel, statusLabel, priceKg].forEach {
            self.addSubview($0)
        }
    }
    
    func setStatus(with status: String) {
        switch status {
        case ArbuzStatus.ready.rawValue:
            statusLabel.textColor = .systemGreen
        case ArbuzStatus.notReady.rawValue:
            statusLabel.textColor = .systemYellow
        case ArbuzStatus.gone.rawValue:
            statusLabel.textColor = .systemRed
        default:
            statusLabel.textColor = .black
        }
        statusLabel.text = status
    }
    
    func configureConstraints() {
        
        counterView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.top.equalTo(totalPriceLabel.snp_bottomMargin).offset(15)
            make.left.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        statusLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        totalPriceLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalTo(priceKg.snp_bottomMargin).offset(15)
            make.left.right.equalToSuperview()
        }
        
        priceKg.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.top.equalTo(weightLabel.snp_bottomMargin).offset(15)
            make.left.right.equalToSuperview()
        }
        
        weightLabel.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.top.equalTo(statusLabel.snp_bottomMargin).offset(15)
            make.left.right.equalToSuperview()
        }
        
//        quantityLabel.snp.makeConstraints { make in
//            make.height.equalTo(40)
//            make.top.equalTo(totalPriceLabel.snp_bottomMargin).offset(15)
//            make.left.right.equalToSuperview()
//        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(counterView.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }
    
}

