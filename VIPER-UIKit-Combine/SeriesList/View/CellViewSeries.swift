//
//  CellViewSeries.swift
//  VIPER-UIKit-Combine
//
//  Created by Markel Juaristi on 28/5/23.
//

import Foundation
import UIKit

class SerieCell: UITableViewCell {
    var serieImageView: UIImageView!
    var serieTitleLabel: UILabel!
    var serieDescriptionLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        serieImageView = UIImageView()
        serieImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(serieImageView)

        serieTitleLabel = UILabel()
        serieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(serieTitleLabel)

        serieDescriptionLabel = UILabel()
        serieDescriptionLabel.numberOfLines = 7
        serieDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(serieDescriptionLabel)
        
        
        self.backgroundColor = UIColor.red 

        NSLayoutConstraint.activate([
            serieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            serieImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            serieImageView.heightAnchor.constraint(equalToConstant: 100),
            serieImageView.widthAnchor.constraint(equalToConstant: 100),

            serieTitleLabel.leadingAnchor.constraint(equalTo: serieImageView.trailingAnchor, constant: 8),
            serieTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            serieTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            serieDescriptionLabel.leadingAnchor.constraint(equalTo: serieImageView.trailingAnchor, constant: 8),
            serieDescriptionLabel.topAnchor.constraint(equalTo: serieTitleLabel.bottomAnchor, constant: 8),
            serieDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            serieDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with serie: Serie, imageLoader: ImageLoaderProtocol) {
        serieTitleLabel.text = serie.title
        serieDescriptionLabel.text = serie.description
        if let imageUrl = URL(string: "\(serie.thumbnail.path).\(serie.thumbnail.thumbnailExtension ?? "")") {
            imageLoader.loadImage(from: imageUrl, into: serieImageView)
        }
    }
}
