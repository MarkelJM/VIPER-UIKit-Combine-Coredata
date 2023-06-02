//
//  HeroeListView.swift
//  VIPER-UIKit-Combine
//
//  Created by Markel Juaristi on 27/5/23.
//

import Foundation
import UIKit

protocol HeroesListViewProtocol: AnyObject {
    func updateHeroes(_ heroes: [Hero])
    func showError(_ error: Error)
}

class HeroesListViewController: UIViewController, HeroesListViewProtocol {
    var tableView: UITableView!
    
    var presenter: HeroesListPresentationProtocol?
    var heroes: [Hero] = []
    /* probando problemas en la tabla fde heroes*/
    var marvelAPI: MarvelAPI = MarvelAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* probando problemas en la tabla fde heroes*/
        marvelAPI.testGetHeroesRequest()
        
        setupTableView()
        presenter?.viewDidLoad()
    }

    private func setupTableView() {
        tableView = UITableView()
        tableView.register(HeroCell.self, forCellReuseIdentifier: HeroCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.yellow // Color de fondo de la tabla
        view.addSubview(tableView)
        
        // Añadir constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    
    func updateHeroes(_ heroes: [Hero]) {
        print("View received heroes: \(heroes)")
        self.heroes = heroes
        tableView.reloadData()
    }
    
    func showError(_ error: Error) {
        // mas tarde
    }
}


extension HeroesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeroCell.identifier, for: indexPath) as! HeroCell
        cell.imageLoader = ImageLoader()
        cell.configure(with: heroes[indexPath.row])
        return cell
    }


}

extension HeroesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectHero(heroes[indexPath.row])
    }
}
