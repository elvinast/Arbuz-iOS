//
//  ProductCollectionViewCell.swift
//  ArbuzTestApp
//
//  Created by Elvina Shamoi on 29.05.2022.
//

import UIKit

protocol QuantityChangedDelegate {
    func changeQuantity(item: Arbuz, quantity: Int)
}

class ProductCollectionViewCell: UICollectionViewCell {

    static let reuseId = "ProductCollectionViewCell"
    
    static func nib() -> UINib{
    return UINib(nibName: "ProductCollectionViewCell", bundle: nil)
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    private lazy var counterView = CounterView()
    private var arbuzItem: Arbuz?
    var delegate: QuantityChangedDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        configureConstraints()
        counterView.didSelectItem = {
            let cnt = self.counterView.cnt
            guard let arbuzItem = self.arbuzItem else { return }
            self.delegate?.changeQuantity(item: arbuzItem , quantity: self.counterView.cnt)
        }
    }
    
    func configureUI() {
        self.addSubview(counterView)
        counterView.layer.backgroundColor = UIColor.secondarySystemBackground.cgColor
        counterView.layer.cornerRadius = 10
        imageView.layer.cornerRadius = 4
    }
    
    func configureConstraints() {
        counterView.snp.makeConstraints { make in
            make.width.equalTo(imageView.snp.width).inset(20)
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom)
            make.height.equalTo(30)
       }
    }
    
    func configureCell(with item: Arbuz) {
        arbuzItem = item
        nameLabel.text = item.name ?? ""
        imageView.image = UIImage(named: item.image ?? "")
        if let weight = item.weight, let price = item.price {
            weightLabel.text = "\(weight) кг"
            priceLabel.text = "\(Int((weight * price).rounded())) тг"
        }
        counterView.cnt = item.quantity ?? 1
    }
}
