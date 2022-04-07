//
//  AppDepedencyContainer+ViewController.swift
//  FutureMind
//
//  Created by Krzysztof Lema on 07/04/2022.
//

typealias ListFactories = ListFactory & ListViewModelFactory

protocol ListFactory {
    func makeListViewController() -> ListViewController
}

protocol ListViewModelFactory {
    func makeListViewModel() -> ListViewModel
}

extension AppDependencyContainer: ListFactories  {
    func makeListViewController() -> ListViewController {
        ListViewController(viewModel: makeListViewModel())
    }

    func makeListViewModel() -> ListViewModel {
        ListViewModel()
    }
}