//
//  ViewController.swift
//  ArbuzTestApp
//
//  Created by Elvina Shamoi on 29.05.2022.
//

import UIKit

class CatalogVC: UIViewController {
    
    var lines = Bundle.main.decode([Line].self, from: "model.json")
    var dataSource: UICollectionViewDiffableDataSource<Line, Arbuz>?
    var cartProducts: [Arbuz] = [] {
        didSet {
            orderButton.isHidden = cartProducts.isEmpty
            orderButton.setTitle("Оформить заказ: \(countTotalSum()) тг", for: .normal)
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var orderButton: GreenButton = {
        let button = GreenButton(titleText: "Оформить заказ: \(countTotalSum()) тг")
        button.addTarget(self, action: #selector(orderClicked), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
        createDataSource()
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createDataSource()
        reloadData()
    }
    
    @objc
    private func orderClicked() {
        let vc = OrderDetailVC()
        vc.totalSum = countTotalSum()
        present(vc, animated: true)
    }
    
    func countTotalSum() -> Int {
        var total = 0
        for item in cartProducts {
            if let weight = item.weight, let price = item.price {
                total += Int((weight * price).rounded())
            }
        }
        return total
    }
}

//MARK: data method's
extension CatalogVC {
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Line, Arbuz>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, section) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseId, for: indexPath) as! ProductCollectionViewCell
            cell.configureCell(with: section)
            cell.delegate = self
            return cell
        })
        dataSource?.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader else {return nil}
            guard let firstSection = self.dataSource?.itemIdentifier(for: indexPath) else {return nil}
            guard let section = self.dataSource?.snapshot().sectionIdentifier(containingItem: firstSection) else {return nil}
            if section.title.isEmpty {return nil}
            sectionHeader.title.text = section.title
            return sectionHeader
        }
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Line, Arbuz>()
        snapshot.appendSections(lines)
        for section in lines {
            snapshot.appendItems(section.items, toSection: section)
        }
        dataSource?.apply(snapshot)
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout{
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem.init(layoutSize: .init(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1)))
            item.contentInsets.trailing = 10
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension:        .fractionalWidth(1.5), heightDimension: .absolute(230)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = .init(top: 16, leading: 16, bottom: 32, trailing: 0)
            let header = self.createSectionHeader()
            section.boundarySupplementaryItems = [header]
            return section
        }
    }
    
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem{
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let layoutHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize,
                                                                       elementKind: UICollectionView.elementKindSectionHeader,
                                                                       alignment: .top)
        return layoutHeader
    }
}

// MARK: UI configurations
extension CatalogVC {
    func configureUI() {
        title = "Поиск"
        collectionView.delegate = self
        collectionView.collectionViewLayout = createLayout()
        collectionView.register(ProductCollectionViewCell.nib(), forCellWithReuseIdentifier: ProductCollectionViewCell.reuseId)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
        view.addSubview(orderButton)
        orderButton.isHidden = true
    }
    
    func configureConstraints() {
        orderButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.bottom.equalToSuperview().inset(90)
            make.left.right.equalToSuperview().inset(15)
        }
    }
}

//MARK: delegate's method implementation
extension CatalogVC: QuantityChangedDelegate {
    func changeQuantity(item: Arbuz, quantity: Int) {
        let index = cartProducts.firstIndex { $0.id == item.id }
        if let idx = index {
            if quantity == 0 {
                cartProducts.remove(at: idx)
            } else {
                cartProducts[idx].quantity = quantity
            }
        } else if quantity != 0 {
            cartProducts.append(item)
        }
    }
}

extension CatalogVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailedVC = ArbuzDetailVC()
        detailedVC.arbuz = lines[indexPath.section].items[indexPath.row]
        present(detailedVC, animated: true)
    }
}

