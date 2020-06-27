//
// OHCell.swift.
// Shopping.
// 

import UIKit

class OHCell: UITableViewCell {
    @IBOutlet weak var lbTotalPrice: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var vShadow: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vShadow.layer.shadowColor = UIColor(white: 0, alpha: 0.08).cgColor
        vShadow.layer.shadowOffset = CGSize(width: 0, height: 2)
        vShadow.layer.shadowOpacity = 1
        vShadow.layer.shadowRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension OHCell {
    func configCell(order: OrderHistory) {
        lbDate.text = String(order.orderDate.toString())
        let stt = order.status
        if stt {
            lbStatus.text = "Paid"
        }else{
            lbStatus.text = "Unpaid"
        }
        lbTotalPrice.text = String(order.totalPrice.currency()) + " đ"
        selectionStyle = .none
    }
}
