//
//  View.swift
//  FutureMind
//
//  Created by Krzysztof Lema on 07/04/2022.
//

import UIKit

class ListView: UIView {

    let viewModel: ListViewModel

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
        tableView.dataSource = self
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
    }

    required init?(coder: NSCoder) {
        fatalError("View is created without Nib files")
    }
}
extension ListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ListTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? ListTableViewCell

        return cell!
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
