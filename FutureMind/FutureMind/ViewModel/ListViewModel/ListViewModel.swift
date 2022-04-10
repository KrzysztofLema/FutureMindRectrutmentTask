//
//  ViewControllerViewModel.swift
//  FutureMind
//
//  Created by Krzysztof Lema on 07/04/2022.
//

class ListViewModel {

    var listViewDataSource: ListViewDataSource

    init(listViewDataSource: ListViewDataSource) {
        self.listViewDataSource = listViewDataSource
    }
}
