//
//  ViewSeries.swift
//  VIPER-UIKit-Combine
//
//  Created by Markel Juaristi on 28/5/23.
//

import Foundation
import UIKit
import Combine

/*
protocol SeriesListViewProtocol: AnyObject {
    var imageLoader: ImageLoaderProtocol { get }
    func updateSeries(_ series: [Serie])
    
    func showError(_ error: Error)
}
*/


protocol SeriesListViewProtocol: AnyObject {
    var imageLoader: ImageLoaderProtocol { get }
    var seriesPublisher: AnyPublisher<[Serie], Never> { get }
    func showError(_ error: Error)
    func updateSeries(_ series: [Serie])
}

class SeriesListView: UIViewController, SeriesListViewProtocol {
    var presenter: SeriesListPresentationProtocol?
    var imageLoader: ImageLoaderProtocol
    var series: [Serie] = []
    
    private let seriesSubject = PassthroughSubject<[Serie], Never>()
    /* Teoricamente, "PassthroughSubject"  permite que otros componentes se suscriban y reciban las series actualizadas cada vez que se actualizan*/
    var seriesPublisher: AnyPublisher<[Serie], Never> {
        seriesSubject.eraseToAnyPublisher()
    }
    
    private var tableView: UITableView!

    init(imageLoader: ImageLoaderProtocol) {
        self.imageLoader = imageLoader
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter?.viewDidLoad()
        self.view.backgroundColor = UIColor.green
    }

    private func setupTableView() {
        tableView = UITableView()
        tableView.register(SerieCell.self, forCellReuseIdentifier: "SerieCell")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    func updateSeries(_ series: [Serie]) {
        print(series)
        self.series = series
        tableView.reloadData()
        seriesSubject.send(series)
    }
    
    func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        present(alertController, animated: true)
    }
}

extension SeriesListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return series.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SerieCell", for: indexPath) as! SerieCell
        cell.configure(with: series[indexPath.row], imageLoader: imageLoader)
        return cell
    }
}

extension SeriesListView: UITableViewDelegate {
    // al no habe interaccion no necesario implementar, pero bueno esta bien por si quiero mostrar ampliado la serie o lo que toque. tocaria implementar el protocolo del presenter.
}


/*
class SeriesListView: UITableViewController, SeriesListViewProtocol {
    var presenter: SeriesListPresentationProtocol?
    var imageLoader: ImageLoaderProtocol
    var series: [Serie] = []
    
    private let seriesSubject = PassthroughSubject<[Serie], Never>()
    /* Teoricamente, "PassthroughSubject"  permite que otros componentes se suscriban y reciban las series actualizadas cada vez que se actualizan*/
    var seriesPublisher: AnyPublisher<[Serie], Never> {
        seriesSubject.eraseToAnyPublisher()
    }
    
    init(imageLoader: ImageLoaderProtocol) {
        self.imageLoader = imageLoader
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SerieCell.self, forCellReuseIdentifier: "SerieCell")
        presenter?.viewDidLoad()
        self.view.backgroundColor = UIColor.green 
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return series.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SerieCell", for: indexPath) as! SerieCell
        cell.configure(with: series[indexPath.row], imageLoader: imageLoader)
        return cell
    }
    /*
    func updateSeries(_ series: [Serie]) {
        self.series = series
        tableView.reloadData()
    }
    */
    
    func updateSeries(_ series: [Serie]) {
        self.series = series
        tableView.reloadData()
        seriesSubject.send(series)  // Usando el PassthroughSubject aquí
    }
    
    func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        present(alertController, animated: true)
    }
}
*/





