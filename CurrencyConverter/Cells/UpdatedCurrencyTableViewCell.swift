//
//  UpdatedCurrencyTableViewCell.swift
//  CurrencyConverter
//
//  Created by Ahmed App iOS Dev - 1 on 13/07/22.
//

import UIKit

class UpdatedCurrencyTableViewCell: UITableViewCell {

    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var valueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
