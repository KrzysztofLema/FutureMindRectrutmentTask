//
//  ListTableViewCell.swift
//  FutureMind
//
//  Created by Krzysztof Lema on 09/04/2022.
//

import UIKit
import Kingfisher

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var futureMindImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var modificationDateLabel: UILabel!

    func setupCell(with futureMind: FutureMind) {
        descriptionLabel.text = futureMind.description
        titleLabel.text = futureMind.title
        modificationDateLabel.text = futureMind.modificationDate
        futureMindImageView.kf.indicatorType = .activity
        futureMindImageView.kf.setImage(with: futureMind.imageUrl, placeholder: UIImage(named: "placeholderImage"), options: nil, completionHandler: nil)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
