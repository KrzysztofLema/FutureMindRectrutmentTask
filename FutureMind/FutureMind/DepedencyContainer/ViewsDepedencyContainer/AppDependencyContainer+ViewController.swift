//
//  AppDepedencyContainer+ViewController.swift
//  FutureMind
//
//  Created by Krzysztof Lema on 07/04/2022.
//

protocol ViewControllerFactory {
    func makeViewController() -> ViewController
}

extension AppDependencyContainer: ViewControllerFactory {
    func makeViewController() -> ViewController {
        return ViewController()
    }
}
