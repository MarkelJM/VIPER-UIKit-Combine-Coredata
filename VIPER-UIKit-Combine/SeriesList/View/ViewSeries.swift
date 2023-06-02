//
//  ViewSeries.swift
//  VIPER-UIKit-Combine
//
//  Created by Markel Juaristi on 28/5/23.
//

import Foundation
import UIKit

protocol SeriesListViewProtocol: AnyObject {
    var imageLoader: ImageLoaderProtocol { get }
    func updateSeries(_ series: [Serie])
    func showError(_ error: Error)
}

class SeriesListView: UITableViewController, SeriesListViewProtocol {
    var presenter: SeriesListPresentationProtocol?
    var imageLoader: ImageLoaderProtocol // Debes inicializar este imageLoader en algún momento
    var series: [Serie] = []
    
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
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return series.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SerieCell", for: indexPath) as! SerieCell
        cell.configure(with: series[indexPath.row], imageLoader: imageLoader)
        return cell
    }
    
    func updateSeries(_ series: [Serie]) {
        self.series = series
        tableView.reloadData()
    }
    
    func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        present(alertController, animated: true)
    }
}

