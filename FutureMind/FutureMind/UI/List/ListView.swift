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
    let dataSource: ListViewDataSource

    private var subscriptions = Set<AnyCancellable>()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            UINib(nibName: ListTableViewCell.reuseIdentifier, bundle: .main),
            forCellReuseIdentifier: ListTableViewCell.reuseIdentifier
        )
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.refreshControl = UIRefreshControl()
        tableView.accessibilityLabel = AccessibilityElement.ListView.tableView
        return tableView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .medium
        indicator.startAnimating()
        indicator.accessibilityLabel = AccessibilityElement.ListView.activityIndicator
        return indicator
    }()

    init(frame: CGRect = .zero, viewModel: ListViewModel, listViewDataSource: ListViewDataSource) {
        self.viewModel = viewModel
        self.dataSource = listViewDataSource
        super.init(frame: frame)
        setupView()
        setupConstrains()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("View is created without Nib files")
    }
}

private extension ListView {
    func bind() {
        viewModel.allFutureMinds.sink { _ in
        } receiveValue: { [weak self] futureMinds in
            guard let self = self else { return }
            self.tableView.refreshControl?.endRefreshing()
            self.dataSource.applyFutureMinds(results: futureMinds)
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }.store(in: &subscriptions)
    }

    func setupConstrains() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func setupView() {
        addSubview(tableView)
        addSubview(activityIndicator)

        tableView.refreshControl?.addTarget(
            viewModel,
            action: #selector(viewModel.pullToRefresh),
            for: .valueChanged
        )
    }
}
