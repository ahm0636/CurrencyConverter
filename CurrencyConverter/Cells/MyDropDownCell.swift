//
//  MyDropDownCell.swift
//  CurrencyConverter
//
//  Created by Ahmed App iOS Dev - 1 on 28/06/22.
//

import UIKit
import DropDown

class MyDropDownCell: DropDownCell {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
     //   flagImageView.contentMode = .scaleAspectFit
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
