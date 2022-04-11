//
//  ViewControllerViewModel.swift
//  FutureMind
//
//  Created by Krzysztof Lema on 07/04/2022.
//

import Combine
import Foundation

class ListViewModel {

    var listViewDataSource: ListViewDataSource
    var futureMindRemoteApi: FutureMindRemoteApi

    init(listViewDataSource: ListViewDataSource, futureMindRemoteApi: FutureMindRemoteApi) {
        self.listViewDataSource = listViewDataSource
        self.futureMindRemoteApi = futureMindRemoteApi
    }

    @objc func pullToRefresh() {
        futureMindRemoteApi.loadList()
    }
}
