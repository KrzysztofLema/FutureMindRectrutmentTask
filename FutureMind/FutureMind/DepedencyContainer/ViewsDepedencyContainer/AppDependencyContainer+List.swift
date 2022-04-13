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
        let listViewController = ListViewController(viewModel: makeListViewModel(),dataSource: dataSource)
        listViewController.view.accessibilityLabel = ViewsAccessibilityLabels.ListView.view
        return listViewController
    }

    func makeListViewModel() -> ListViewModel {
       return ListViewModel(futureMindRemoteApi: makeFutureMindRemoteApi())
    }
}
