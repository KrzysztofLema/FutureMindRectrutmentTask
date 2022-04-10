//
//  AppDepedencyContainer.swift
//  FutureMind
//
//  Created by Krzysztof Lema on 07/04/2022.
//

class AppDependencyContainer {
    func makeListViewDataSource() -> ListViewDataSource {
        ListViewDataSourceImpl()
    }
}
