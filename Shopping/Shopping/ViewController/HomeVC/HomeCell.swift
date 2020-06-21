//
// HomeCell.swift.
// Shopping.
// 

import UIKit

class HomeCell: UICollectionViewCell {

    @IBOutlet weak var imgProduct: UIImageView!
    
    @IBOutlet weak var lbNameProduct: UILabel!
    
    @IBOutlet weak var lbDD: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbSupplierName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        lbDD.attributedText = NSAttributedString(string: "đ", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        
    }
    
    
}
