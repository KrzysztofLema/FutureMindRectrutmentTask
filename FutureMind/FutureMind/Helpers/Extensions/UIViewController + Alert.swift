//
//  UIViewController + Alert.swift
//  FutureMind
//
//  Created by Krzysztof Lema on 13/04/2022.
//

import Foundation
import UIKit
import Combine

extension UIViewController {

    func present(error: RemoteApiError) {
      let errorAlertController = UIAlertController(title: "Error",
                                                   message: error.errorDescription,
                                                 preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default)
    errorAlertController.addAction(okAction)
    present(errorAlertController, animated: true, completion: nil)
  }
}
