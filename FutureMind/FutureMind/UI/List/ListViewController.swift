//
//  ViewController.swift
//  FutureMind
//
//  Created by Krzysztof Lema on 07/04/2022.
//

import UIKit
import SafariServices
import Combine

class ListViewController: UIViewController {

    let viewModel: ListViewModel
    let dataSource: ListViewDataSource
    var subscriptions = Set<AnyCancellable>()

    // swiftlint:disable force_cast
    var listView: ListView {
        return view as! ListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        listView.tableView.delegate = self
        listView.tableView.dataSource = dataSource.listViewDiffableDataSource
        dataSource.setupDataSource(tableView: listView.tableView)
        bind()
    }

    override func loadView() {
        self.view = ListView(viewModel: viewModel, listViewDataSource: dataSource)
    }

    init(
        nibName nibNameOrNil: String? = nil,
        bundle nibBundleOrNil: Bundle? = nil,
        viewModel: ListViewModel,
        dataSource: ListViewDataSource
    ) {
        self.viewModel = viewModel
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ListViewController {
    func bind() {
        viewModel.allFutureMindsError.sink { error in
            self.present(error: error)
        }.store(in: &subscriptions)
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presentSafariViewController(at: indexPath)
    }
}

private extension ListViewController {
    func presentSafariViewController(at indexPath: IndexPath) {
        guard let url = viewModel.futureMinds[indexPath.row].futureMindDetailURL else {
            return
        }
        let safariViewController = SFSafariViewController(url:url)
        safariViewController.modalPresentationStyle = .popover
        navigationController?.present(safariViewController, animated: true)
    }
}
