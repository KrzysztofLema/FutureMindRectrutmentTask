//
//  View.swift
//  FutureMind
//
//  Created by Krzysztof Lema on 07/04/2022.
//

import UIKit

class ListView: UIView {

    let viewModel: ListViewModel

    init(frame: CGRect = .zero, viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("View is created without Nib files")
    }
}
