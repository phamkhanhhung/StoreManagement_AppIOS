//
// UIImageViewExtention.swift.
// Shopping.
// 

import Foundation
import Kingfisher
import UIKit

extension UIImageView {
    func imageWithUrl(_ urlString: String, placeholder: UIImage?) {
        if urlString.count > 0 {
            self.kf.setImage(with: URL.init(string: urlString), placeholder: placeholder, options: [.transition(ImageTransition.fade(1))], progressBlock: { (receivedSize, totalSize) in
                
            }) { (result) in
                switch result {
                case .success(let value):
                    if value.source.url?.absoluteString == urlString {
                        self.image = value.image
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        } else {
            self.image = placeholder
        }
    }
    
    func imageWithUrl(_ urlString: String) {
        if urlString.count > 0 {
            self.kf.setImage(with: URL.init(string: urlString), placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: { (receivedSize, totalSize) in
                
            }) { (result) in
                switch result {
                case .success(let value):
                    if value.source.url?.absoluteString == urlString {
                        self.image = value.image
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
}
