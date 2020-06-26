//
//  OrderCell.swift
//  Shopping
//
//  Created by apple on 6/25/20.
//  Copyright © 2020 KhanhHung. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lbNameP: UILabel!
    @IBOutlet weak var lbSoLuong: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var btTruSL: UIButton!
    @IBOutlet weak var btCongSL: UIButton!
    @IBOutlet weak var btDelete: UIButton!
    
    var handle: ((OrderProduct) -> Void)?
    var handleDelete:((OrderProduct) -> Void)?
    var item: OrderProduct = OrderProduct() {
        didSet {
            lbSoLuong.text = "\(item.SoLuong)"
            lbNameP.text = "\(item.product.categoryName)" + " " + "\(item.product.name)"
            lbPrice.text = "\(item.product.price) đ"
            if item.SoLuong <= 1 {
                btTruSL.isUserInteractionEnabled = false
            }else{
                btTruSL.isUserInteractionEnabled = true

            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func actionTruSL(_ sender: Any) {
        if item.SoLuong > 1 {
            item.SoLuong -= 1
            handle?(item)
        }
    }
    @IBAction func actionCongSL(_ sender: Any) {item.SoLuong += 1
        handle?(item)
        btTruSL.isUserInteractionEnabled = true
    }
    
    @IBAction func actionDelete(_ sender: Any) {
        handleDelete?(item)
    }
}
