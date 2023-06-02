//
//  ImageLoader.swift
//  VIPER-UIKit-Combine
//
//  Created by Markel Juaristi on 27/5/23.
//

import UIKit

protocol ImageLoaderProtocol {
    func loadImage(from url: URL, into imageView: UIImageView)
}

class ImageLoader: ImageLoaderProtocol {
    func loadImage(from url: URL, into imageView: UIImageView) {
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                }
            } catch {
                print("Error loading image: \(error)")
            }
        }
    }
}


/*
class ImageLoader: ImageLoaderProtocol {
    func loadImage(from url: URL, into imageView: UIImageView) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }
    }
}
*/
