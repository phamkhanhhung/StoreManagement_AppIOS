//
// OrderCell.swift.
// Shopping.
// 

import UIKit

class OrderCell: UICollectionViewCell {

    @IBOutlet weak var lbNameP: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var btCongSL: UIButton!
    @IBOutlet weak var lbSoLuong: UILabel!
    @IBOutlet weak var btTruSL: UIButton!
    @IBOutlet weak var btDelete: UIButton!
    
    var handle: ((OrderProduct) -> Void)?
    var handleDelete:((OrderProduct) -> Void)?
    var item: OrderProduct = OrderProduct() {
        didSet {
            lbSoLuong.text = "\(item.SoLuong)"
            lbNameP.text = "\(item.product.categoryName)" + " " + "\(item.product.name)"
            lbPrice.text = "\(item.product.price)"
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if item.SoLuong <= 1 {
            btTruSL.isUserInteractionEnabled = false
        }
    }
    
    @IBAction func actionTruSL(_ sender: Any) {
        if item.SoLuong > 1 {
            item.SoLuong -= 1
            handle?(item)
        }
        
    }
    @IBAction func actionCongSL(_ sender: Any) {
        
        item.SoLuong += 1
        handle?(item)
        btTruSL.isUserInteractionEnabled = true
    }
    @IBAction func actionDelete(_ sender: Any) {
        handleDelete?(item)
    }
    
}
