//
//  View.swift
//  FutureMind
//
//  Created by Krzysztof Lema on 07/04/2022.
//

import UIKit
import Combine

class ListView: UIView {

    let viewModel: ListViewModel
    var cancallables = Set<AnyCancellable>()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            UINib(nibName: ListTableViewCell.reuseIdentifier, bundle: .main),
            forCellReuseIdentifier: ListTableViewCell.reuseIdentifier
        )
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200

        tableView.refreshControl = UIRefreshControl()
        
        return tableView
    }()

    private func setupView() {
        addSubview(tableView)

        tableView.dataSource = viewModel.listViewDataSource.listViewDiffableDataSource
        viewModel.listViewDataSource.setupDataSource(tableView: tableView)
        
        tableView.refreshControl?.addTarget(viewModel, action: #selector(viewModel.pullToRefresh), for: .valueChanged)
    }

    init(frame: CGRect = .zero, viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        setupView()
        setupConstrains()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("View is created without Nib files")
    }

    func bind() {
        viewModel.futureMindRemoteApi.list
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { error in
                debugInfo("Completion")
        }, receiveValue: { futureMind in
            self.viewModel.listViewDataSource.applyFutureMinds(results: futureMind)
            self.tableView.refreshControl?.endRefreshing()
        }).store(in: &cancallables)
    }

    func setupConstrains() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
