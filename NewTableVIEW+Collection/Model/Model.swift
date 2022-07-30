//
//  Model.swift
//  NewTableVIEW+Collection
//
//  Created by mac on 30.07.2022.
//

import Foundation

enum CellModel {
    case collectionView(models: [CollectionViewCellModel], row: Int)
    case list(models: [ListCellModel])
}
struct ListCellModel {
    let title: String
}
struct CollectionViewCellModel {
    let title: String
    let image: String
}
