//
//  ViewController.swift
//  FutureMind
//
//  Created by Krzysztof Lema on 07/04/2022.
//

import UIKit

class ListViewController: UIViewController {

    let viewModel: ListViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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

