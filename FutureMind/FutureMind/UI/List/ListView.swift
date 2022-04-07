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
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.insetsContentViewsToSafeArea = true
        tableView.contentInsetAdjustmentBehavior = .automatic
        return tableView
    }()

    private func setupView() {
        addSubview(tableView)
        tableView.dataSource = self
    }

    override func layoutSubviews() {
      super.layoutSubviews()
      tableView.frame = bounds
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
        2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = "HEllo"
        return cell!
    }


}
