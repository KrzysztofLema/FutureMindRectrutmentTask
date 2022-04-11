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
        return tableView
    }()

    private func setupView() {
        addSubview(tableView)
        tableView.dataSource = viewModel.listViewDataSource.listViewDiffableDataSource
        tableView.delegate = self
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = safeAreaLayoutGuide.layoutFrame
    }

    init(frame: CGRect = .zero, viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        setupView()
        viewModel.listViewDataSource.setupDataSource(tableView: tableView)
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("View is created without Nib files")
    }

    func bind() {
        viewModel.futureMindRemoteApi.list?
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { error in
        }, receiveValue: { futureMind in
            self.viewModel.listViewDataSource.applyFutureMinds(results: futureMind)
        }).store(in: &cancallables)
    }
}

extension ListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
