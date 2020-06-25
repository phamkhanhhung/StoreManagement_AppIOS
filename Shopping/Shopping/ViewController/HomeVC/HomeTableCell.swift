//
// HomeTableCell.swift.
// Shopping.
// 

import UIKit

class HomeTableCell: UITableViewCell {

    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var lbPhoneNuber: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var imvTick: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configWith(branch: Branch, selected: Branch) {
        lbAddress.text = String(branch.address)
        lbPhoneNuber.text = String(branch.phoneNumber)
        lbDescription.text = String(branch.description0)
        imvTick.isHidden = branch.id != selected.id
    }
}
