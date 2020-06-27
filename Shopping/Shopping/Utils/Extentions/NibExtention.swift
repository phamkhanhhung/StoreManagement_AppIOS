//
// NibExtention.swift.
// Shopping.
// 

import Foundation
import UIKit

protocol NibReusable: class {
    static var reuseIdentifier: String { get }
    static var nibName: String { get }
}

extension NibReusable where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
    static var reuseIdentifier: String {
        return nibName
    }
}

extension UITableViewCell: NibReusable { }

extension UICollectionViewCell: NibReusable { }

extension UITableViewHeaderFooterView: NibReusable { }

extension UICollectionView {
    func register<Cell: NibReusable>(_ cell: Cell.Type) {
        let nib = UINib(nibName: cell.nibName, bundle: Bundle(for: cell))
        register(nib, forCellWithReuseIdentifier: cell.reuseIdentifier)
    }
    func dequeueReusableCell<Cell: NibReusable>(forIndexPath indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Could not dequeue cell with identifier: \(Cell.reuseIdentifier)")
        }
        return cell
    }
}

extension UITableView: UITableViewDelegate {
    func register<Cell: NibReusable>(_ cell: Cell.Type) {
        let nib = UINib(nibName: Cell.nibName, bundle: Bundle(for: cell))
        register(nib, forCellReuseIdentifier: Cell.reuseIdentifier)
    }
    
    func dequeueReusableCell<Cell: NibReusable>(forIndexPath indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Could not dequeue cell with identifier: \(Cell.reuseIdentifier)")
        }
        return cell
    }
    
    func registerHeaderFooterView<Cell: NibReusable>(_ cell: Cell.Type) {
        let nib = UINib(nibName: Cell.nibName, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: Cell.reuseIdentifier)
    }
    
    func dequeueReusableHeaderFooterView<Cell: NibReusable>() -> Cell {
        guard let header = dequeueReusableHeaderFooterView(withIdentifier: Cell.reuseIdentifier) as? Cell else {
            fatalError("Could not dequeue header with identifier: \(Cell.reuseIdentifier)")
        }
        return header
    }
}
