//
//  HeroCell.swift
//  VIPER-UIKit-Combine
//
//  Created by Markel Juaristi on 27/5/23.
//

import UIKit

class HeroCell: UITableViewCell {
    
    var heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var heroNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var imageLoader: ImageLoaderProtocol?
    
    static let identifier = "HeroCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(heroImageView)
        addSubview(heroNameLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            heroImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            heroImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            heroImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            heroImageView.widthAnchor.constraint(equalToConstant: 100),
            
            heroNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            heroNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            heroNameLabel.leadingAnchor.constraint(equalTo: heroImageView.trailingAnchor, constant: 10),
            heroNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
    }
    /*
    func configure(with hero: Hero) {
        heroNameLabel.text = hero.name
        if let imageUrl = URL(string: "\(hero.thumbnail.path).\(hero.thumbnail.thumbnailExtension ?? "")") {
            imageLoader?.loadImage(from: imageUrl, into: heroImageView)
        }
    }
     */
    func configure(with hero: Hero) {
        heroNameLabel.text = hero.name
        if let imageUrl = URL(string: "\(hero.thumbnail.path).\(hero.thumbnail.thumbnailExtension ?? "")") {
            print("aqui imagenes celdas")
            print("Image URL: \(imageUrl)") // Imprime la URL de la imagen
            imageLoader?.loadImage(from: imageUrl, into: heroImageView)
        }
    }

}


