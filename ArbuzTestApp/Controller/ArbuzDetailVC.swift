//
//  ArbuzDetailedView.swift
//  ArbuzTestApp
//
//  Created by Elvina Shamoi on 29.05.2022.
//

import UIKit
import SnapKit

class ArbuzDetailVC: UIViewController {

    var arbuz: Arbuz? {
        didSet {
            imageView.image = UIImage(named: arbuz?.image ?? "arbuz1")
            detailView.arbuzInfo = arbuz
        }
    }
    
    let detailView = ArbuzDetailView()
    
    let imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
    }
    
    func configureUI() {
        detailView.delegate = self
        view.backgroundColor = .white
        [imageView, detailView].forEach {
            view.addSubview($0)
        }
    }
    
    func configureConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(K.screenHeight / 2.3)
        }
        
        detailView.snp.makeConstraints({ make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.left.right.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(10)
        })
    }
    
}

extension ArbuzDetailVC: QuantityChangedDelegate {
    func changeQuantity(item: Arbuz, quantity: Int) {
        if quantity == 0 {
            self.dismiss(animated: true)
        } else {
            self.arbuz?.quantity = quantity
        }
    }
}
