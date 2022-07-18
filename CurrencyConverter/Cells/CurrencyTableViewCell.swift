//
//  CurrencyTableViewCell.swift
//  CurrencyConverter
//
//  Created by Ahmed App iOS Dev - 1 on 20/06/22.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var name: UILabel!
    var data: Currencyy! {
        didSet {
            self.valueLabel.text = data.rate
            self.currencyImage.image = UIImage(named: data.ccy!)
            self.name.text = data.ccyNm_EN
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
