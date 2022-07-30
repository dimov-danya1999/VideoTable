//
//  CollectionTableViewCell.swift
//  NewTableVIEW+Collection
//
//  Created by mac on 30.07.2022.
//

import UIKit

protocol CollectionViewCellDelegate: AnyObject {
    func didSelectIte(with model: CollectionViewCellModel)
}

class CollectionTableViewCell: UITableViewCell {
    
    public weak var delegate: CollectionViewCellDelegate?
    
    static let indetificator = "CollectionTableViewCell"
    
     var model = [CollectionViewCellModel]()

    private let collectionView: UICollectionView
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 170, height: 170)
        layout.sectionInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.indetificator)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    public func configure(with models: [CollectionViewCellModel] ) {
        self.model = models
        collectionView.reloadData()
    }
}

extension CollectionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let models = model[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.indetificator, for: indexPath) as! CollectionViewCell
        cell.congigureisModel(with: models)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = model[indexPath.row]
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.didSelectIte(with: model)
    }
}
