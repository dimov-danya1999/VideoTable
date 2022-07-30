//
//  CollectionViewCell.swift
//  NewTableVIEW+Collection
//
//  Created by mac on 30.07.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let indetificator = "CollectionViewCell"
    
    private let myLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let myImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(myLabel)
        contentView.addSubview(myImage)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myImage.frame = CGRect(x: 5,
                               y: 5,
                               width: contentView.frame.size.width - 10,
                               height: contentView.frame.size.height-5-50)
        
        myLabel.frame = CGRect(x: 5,
                               y: contentView.frame.size.height - 50,
                               width: contentView.frame.size.width - 10,
                               height:50)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func congigureisModel(with model: CollectionViewCellModel) {
        myLabel.text = model.title
        myImage.image = UIImage(named: model.image)
    }
}
