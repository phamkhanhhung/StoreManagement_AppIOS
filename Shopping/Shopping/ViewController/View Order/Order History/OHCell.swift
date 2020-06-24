//
// OHCell.swift.
// Shopping.
// 

import UIKit

class OHCell: UITableViewCell {

    @IBOutlet weak var lbTotalPrice: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbNuber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
