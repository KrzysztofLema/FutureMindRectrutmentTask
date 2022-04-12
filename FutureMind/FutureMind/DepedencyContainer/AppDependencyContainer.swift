//
//  AppDepedencyContainer.swift
//  FutureMind
//
//  Created by Krzysztof Lema on 07/04/2022.
//

class AppDependencyContainer {

    func makeFutureMindRemoteApi() -> FutureMindRemoteApi {
        FutureMindRemoteApiImpl()
    }

    let dataSource = ListViewDataSourceImpl()
}
