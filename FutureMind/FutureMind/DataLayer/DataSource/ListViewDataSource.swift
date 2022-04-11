//
//  ListViewDataSource.swift
//  FutureMind
//
//  Created by Krzysztof Lema on 09/04/2022.
//
import UIKit
import Combine

protocol ListViewDataSource {
    var listViewDiffableDataSource: UITableViewDiffableDataSource<ListViewSection, FutureMind>? { get }
    func setupDataSource(tableView: UITableView)
    func applyFutureMinds(results: [FutureMind])
}

class ListViewDataSourceImpl: ListViewDataSource {

    var listViewDiffableDataSource: UITableViewDiffableDataSource<ListViewSection, FutureMind>?

    func setupDataSource(tableView: UITableView) {
        listViewDiffableDataSource = UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: { tableView, indexPath, futureMind in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ListTableViewCell.reuseIdentifier,
                for: indexPath
            ) as? ListTableViewCell else {
                return UITableViewCell()
            }
            cell.setupCell(with: futureMind)
            return cell
        })
    }

    func applyFutureMinds(results: [FutureMind]) {
        var snapshot = NSDiffableDataSourceSnapshot<ListViewSection, FutureMind>()
        guard listViewDiffableDataSource != nil else { return }

        snapshot.deleteAllItems()
        snapshot.appendSections([.mainSection])

        if results.isEmpty {
            listViewDiffableDataSource?.apply(snapshot, animatingDifferences: true)
            return
        }

        snapshot.appendItems(results, toSection: .mainSection)
        listViewDiffableDataSource?.apply(snapshot, animatingDifferences: true)
    }
}

enum ListViewSection: CaseIterable {
        case mainSection
}
