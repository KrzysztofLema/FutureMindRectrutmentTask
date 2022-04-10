//
//  ListViewDataSource.swift
//  FutureMind
//
//  Created by Krzysztof Lema on 09/04/2022.
//
import UIKit

protocol ListViewDataSource {
    var listViewDiffableDataSource: UITableViewDiffableDataSource<ListViewSection, FutureMind>? { get }

    func setupDataSource(tableView: UITableView)
    func applyFutureMinds()
}

class ListViewDataSourceImpl: ListViewDataSource {

    var listViewDiffableDataSource: UITableViewDiffableDataSource<ListViewSection, FutureMind>?

    func setupDataSource(tableView: UITableView) {
        listViewDiffableDataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, futureMind in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else {
                return UITableViewCell()
            }
            cell.setupCell(with: futureMind)
            return cell
        })
    }

    func applyFutureMinds() {
        var snapshot = NSDiffableDataSourceSnapshot<ListViewSection, FutureMind>()
        guard listViewDiffableDataSource != nil else { return }

        snapshot.deleteAllItems()
        snapshot.appendSections([.mainSection])

        if FutureMind.fakeData.isEmpty {
            listViewDiffableDataSource?.apply(snapshot, animatingDifferences: true)
            return
        }

        snapshot.appendItems(FutureMind.fakeData, toSection: .mainSection)
        listViewDiffableDataSource?.apply(snapshot, animatingDifferences: true)
    }
}

enum ListViewSection: CaseIterable {
        case mainSection
}

