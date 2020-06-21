//
// HomeTableCell.swift.
// Shopping.
// 

import UIKit

class HomeTableCell: UITableViewCell {

    @IBOutlet weak var lbAddress: UILabel!
    
    @IBOutlet weak var lbPhoneNuber: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbSTT: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
