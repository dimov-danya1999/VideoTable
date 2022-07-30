//
//  ViewController.swift
//  NewTableVIEW+Collection
//
//  Created by mac on 30.07.2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.indetificator)
        return table
    }()
    
    private var model = [CellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        tableView.tableHeaderView = video() // создаем заголовок таблицы в качество видео
        setupModel()
    }
    
    private func video() -> UIView? {
        guard let path = Bundle.main.path(forResource: "video", ofType: "mp4") else { return
         nil
    }
    let url = URL(fileURLWithPath: path)
        let player = AVPlayer(url: url)
        player.volume = 1
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        let players = AVPlayerLayer(player: player)
        players.frame = header.bounds
        header.layer.addSublayer(players)
        players.videoGravity = .resizeAspectFill
        player.play()
        return header
    }
    
    private func configureTable() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupModel() {
        model.append(.collectionView(models: [CollectionViewCellModel(title: "Бег", image: "sport1"),
                                              CollectionViewCellModel(title: "Спорт", image: "sport2"),
                                              CollectionViewCellModel(title: "Мотивация", image: "sport3"),
                                              CollectionViewCellModel(title: "Здоровье", image: "sport4"),
                                              CollectionViewCellModel(title: "Успех", image: "sport5"),
                                              CollectionViewCellModel(title: "Хорошее настроение", image: "sport6"),
                                              CollectionViewCellModel(title: "Дофамин", image: "sport7")],
                                     row: 2))
        
        model.append(.list(models: [
            ListCellModel(title: "ЧТО-ТО 1"),
            ListCellModel(title: "ЧТО-ТО 2"),
            ListCellModel(title: "ЧТО-ТО 3"),
            ListCellModel(title: "ЧТО-ТО 4"),
            ListCellModel(title: "ЧТО-ТО 5"),
            ListCellModel(title: "ЧТО-ТО 6"),
            ListCellModel(title: "ЧТО-ТО 7")
                                   ]))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch model[section] {
        case .list(let models): return models.count
        case .collectionView(_, _): return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch model[indexPath.section] {
        case .list(let models):
            let model = models[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                     for: indexPath)
            cell.textLabel?.text = model.title
            return cell
            
        case .collectionView(let models, _):
            let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.indetificator, for: indexPath) as! CollectionTableViewCell
            cell.configure(with: models)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("печать")
    }
    
    //высота строки к пути индексу
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch model[indexPath.section] {
        case .list(_): return 50
        case .collectionView(_, let row ): return 180 * CGFloat(row)
        }
    }
}

extension ViewController: CollectionViewCellDelegate {
    
    func didSelectIte(with model: CollectionViewCellModel) {
        print("seltct")
    }
}

