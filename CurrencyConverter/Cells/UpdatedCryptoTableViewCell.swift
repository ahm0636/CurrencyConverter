//
//  UpdatedCryptoTableViewCell.swift
//  CurrencyConverter
//
//  Created by Ahmed App iOS Dev - 1 on 15/07/22.
//

import UIKit

class UpdatedCryptoTableViewCell: UITableViewCell {

    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var imageCrypto: UIImageView!
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var changeDaily: UILabel!

    let character: Character = "-"

    var data: Crypto! {
        didSet {
            self.name.text = data.name ?? "N/A"
            self.symbol.text = data.symbol?.uppercased() ?? "N/A"
            self.value?.text = "\(String(describing: data.priceUSD ?? 0.0))$"
            self.imageCrypto.image = UIImage(named: data.symbol?.uppercased() ?? "")
            self.changeDaily.text = "\(String(Double(round(100 * data.priceChangeDaily!) / 100)))"
            
            if self.changeDaily.text!.contains(character) {
                changeDaily.textColor = .red
            } else {
                changeDaily.textColor = .green
            }

        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        imageCrypto.makeRounded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension UIImageView {

    func makeRounded() {
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}
