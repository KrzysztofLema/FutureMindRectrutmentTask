//
//  ViewControllerViewModel.swift
//  FutureMind
//
//  Created by Krzysztof Lema on 07/04/2022.
//

import Combine

class ListViewModel {

    var listViewDataSource: ListViewDataSource
    var futureMindRemoteApi: FutureMindRemoteApi

    init(listViewDataSource: ListViewDataSource, futureMindRemoteApi: FutureMindRemoteApi) {
        self.listViewDataSource = listViewDataSource
        self.futureMindRemoteApi = futureMindRemoteApi
    }

}
