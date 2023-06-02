//
//  RouterSeries.swift
//  VIPER-UIKit-Combine
//
//  Created by Markel Juaristi on 28/5/23.
//

import Foundation
import UIKit

protocol SeriesListRoutingProtocol: AnyObject {
    // Navigation goes here
}

class SeriesListRouter: SeriesListRoutingProtocol {
    weak var viewController: UIViewController?
    // No se implementa navigateToSerieDetail ya que no hay una pantalla de detalle por el momento
}


