//
//  AppDepedencyContainer.swift
//  FutureMind
//
//  Created by Krzysztof Lema on 07/04/2022.
//

import Foundation

class AppDependencyContainer {
    
    func makeFutureMindRemoteApi() -> FutureMindRemoteApi {
        let sessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: sessionConfiguration)
        return FutureMindRemoteApiImpl(urlSession: urlSession)
    }
    
    let dataSource = ListViewDataSourceImpl()
}
