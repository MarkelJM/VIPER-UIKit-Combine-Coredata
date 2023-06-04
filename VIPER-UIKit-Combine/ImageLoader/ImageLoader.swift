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


//AÑADIENDO IMAGEN POR DEFECTO SI NO HAY IMAGE EN LA API(COMO ES EL CASO DE VARIOS)

class ImageLoader: ImageLoaderProtocol {
    let defaultImage = UIImage(named: "MarvelLogo")  // Asegúrate de tener una imagen llamada 'default_image' en tus assets

    func loadImage(from url: URL, into imageView: UIImageView) {
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        imageView.image = self.defaultImage
                    }
                }
            } catch {
                print("Error loading image: \(error)")
                DispatchQueue.main.async {
                    imageView.image = self.defaultImage
                }
            }
        }
    }
}

/*
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
*/

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
