//
//  ViewController.swift
//  FutureMind
//
//  Created by Krzysztof Lema on 07/04/2022.
//

import UIKit
import SafariServices

class ListViewController: UIViewController {

    let viewModel: ListViewModel

    var listView: ListView {
        return view as? ListView ?? ListView(viewModel: viewModel)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        listView.tableView.delegate = self
    }

    override func loadView() {
        self.view = ListView(viewModel: viewModel)
    }

    init(
        nibName nibNameOrNil: String? = nil,
        bundle nibBundleOrNil: Bundle? = nil,
        viewModel: ListViewModel
    ) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let url = viewModel.futureMindRemoteApi.list.value[indexPath.row].futureMindDetailURL else {
            return
        }
        let safariViewController = SFSafariViewController(url:url)
        navigationController?.present(safariViewController, animated: true)
    }

}
