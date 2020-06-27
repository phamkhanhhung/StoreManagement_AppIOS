//
// HomeVC.swift.
// Shopping.
//

import UIKit
import Alamofire
import SwiftyJSON
import SkyFloatingLabelTextField
import KRProgressHUD
import SwiftyAttributes

class HomeVC: UIViewController {
    
    @IBOutlet weak var clvProduct: UICollectionView!
    @IBOutlet weak var tbvChooses: UITableView!
    @IBOutlet weak var lbSearch: UISearchBar!
    @IBOutlet weak var vBranch: UIView!
    @IBOutlet weak var lbBranch: UILabel!
    @IBOutlet weak var btChange: UIButton!
    
    var searchData:[Product] = []
    
    var selectedBranch: Branch = Branch() {
        didSet {
            lbBranch.attributedText = "You are viewing the product at ".withAttribute(.textColor(Color(white: 0, alpha: 0.5))) + "\(selectedBranch.description0)".withAttribute(.textColor(Color("F93963", alpha: 1)))
            Data.shared.branchid = selectedBranch.id
            self.reloadDataWith(brandId: selectedBranch.id)
        }
    }
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initData()
        clvProduct.keyboardDismissMode = .interactive
        
        self.lbSearch.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initUI()
        self.lbSearch.endEditing(false)

    }
    
    @IBAction func actionChangeBranch(_ sender: Any) {
        if vBranch.isHidden {
            vBranch.isHidden = false
            btChange.setAttributedTitle("Close".withAttributes([.textColor(Color("F93963", alpha: 1)), .underlineStyle(.single), .underlineColor(Color("F93963", alpha: 1))]), for: .normal)
        }else{
            vBranch.isHidden = true
            btChange.setAttributedTitle("Change".withAttributes([.textColor(Color("F93963", alpha: 1)), .underlineStyle(.single), .underlineColor(Color("F93963", alpha: 1))]), for: .normal)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension HomeVC{
    func initUI()  {
        
        clvProduct.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
        clvProduct.dataSource = self
        clvProduct.delegate = self
        clvProduct.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        lbSearch.setMagnifyingGlassColorTo(color: #colorLiteral(red: 0.9764705882, green: 0.2235294118, blue: 0.3882352941, alpha: 1))
        tbvChooses.register(UINib.init(nibName: "HomeTableCell", bundle: nil), forCellReuseIdentifier: "HomeTableCell")
        tbvChooses.dataSource = self
        tbvChooses.delegate = self
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        refreshControl.tintColor = #colorLiteral(red: 0.9764705882, green: 0.2235294118, blue: 0.3882352941, alpha: 1)
        clvProduct.addSubview(refreshControl)
        self.setupNav()
    }
    
    @objc func refresh() {
        reloadDataWith(brandId: selectedBranch.id, false)
    }
    
    func setupNav() {
//        let right = UIBarButtonItem(image: #imageLiteral(resourceName: "home_branch").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.showBranch))
//        self.navigationItem.rightBarButtonItem = right
    }
    
    @objc func showBranch() {
        
    }
    
    func initData(){
        KRProgressHUD.show()
        Data.shared.branch = []
        AF.request("http://52.77.233.77:8081/api/Branch?page=1&pagesize=100", method: .get, parameters: nil,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let value = response.value {
                    if let json = JSON(rawValue: value) {
                        for js in json["items"].arrayValue {
                            let pro = Branch.init(json: js)
                            Data.shared.branch.append(pro)
                            self.tbvChooses.reloadData()
                        }
                        if let branch = Data.shared.branch.first {
                            self.selectedBranch = branch
                        } else {
                            KRProgressHUD.dismiss()
                        }
                    } else {
                        KRProgressHUD.dismiss()
                    }
                } else {
                    KRProgressHUD.dismiss()
                }
                break
            case .failure(let error):
                KRProgressHUD.dismiss()
                print(response)
                print(error)
            }
        }
    }
    
    func reloadDataWith(brandId: Int, _ isShowProgress: Bool = true) {
        if isShowProgress {
            KRProgressHUD.show()
        }
        
        AF.request("http://52.77.233.77:8081/api/Product/GetAllProductInBranch?BranchId=" + String(brandId) + "&page=1&pagesize=100", method: .get, parameters: nil,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            KRProgressHUD.dismiss()
            switch response.result {
            case .success:
                if let value = response.value {
                    if let json = JSON(rawValue: value) {
                        let total = json["total"].intValue
                        Data.shared.totalProduct = total
                        Data.shared.product.removeAll()
                        self.searchData.removeAll()
                        for js in json["items"].arrayValue {
                            let pro = Product.init(json: js)
                            Data.shared.product.append(pro)
                            self.searchData.append(pro)
                        }
                        self.clvProduct.reloadData()
                        
                    }
                }
                
                break
            case .failure(let error):
                
                print(response)
                print(error)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.refreshControl.endRefreshing()
            }
        }
    }
}

extension HomeVC: UITableViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.shared.branch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.keyboardDismissMode = .onDrag
        let tbCell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath as IndexPath) as! HomeTableCell
        tbCell.configWith(branch: Data.shared.branch[indexPath.row], selected: selectedBranch)
        return tbCell
    }
}

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        vBranch.isHidden = true
        btChange.setAttributedTitle("Change".withAttributes([.textColor(Color("F93963", alpha: 1)), .underlineStyle(.single), .underlineColor(Color("F93963", alpha: 1))]), for: .normal)
        Data.shared.product.removeAll()
//        self.lbSearch.text = ""
        self.searchData.removeAll()
        self.clvProduct.reloadData()
        self.tbvChooses.reloadData()
        selectedBranch = Data.shared.branch[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath as IndexPath) as! HomeCell
        let str:String = searchData[indexPath.row ].categoryName + " " + searchData[indexPath.row].name
        cell.lbNameProduct.text = String(str)
        cell.lbSupplierName.text = String(searchData[indexPath.row ].supplierName)
        cell.lbPrice.attributedText = "đ".withAttributes([.underlineStyle(.single), .underlineColor(Color("F93963", alpha: 1))]) + " \(searchData[indexPath.row ].price)".attributedString
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        if !(searchData[indexPath.row].pictures.count <= 0){
            cell.imgProduct.kf.setImage(with: URL(string: searchData[indexPath.row].pictures[0].imageUrl), placeholder: UIImage(named: "noimage"), options: [], progressBlock: { (a, b) in
                
            }) { (result) in
                switch result {
                case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                }
            }
        }

        return cell
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = (view.frame.width-30)/2
        let height = width*4/3
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = InforProductVC(nibName: "InforProductVC", bundle: nil)
        let str1:String = searchData[indexPath.row ].categoryName + " " + searchData[indexPath.row].name
        vc.name = str1
        vc.price = String(searchData[indexPath.row].price)
        vc.dicr = searchData[indexPath.row].description0
        vc.vitri = indexPath.row
        vc.Cty = searchData[indexPath.row].supplierName
        collectionView.deselectItem(at: indexPath, animated: true)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
//        let nav = UINavigationController(rootViewController: vc)
//        nav.modalPresentationStyle = .fullScreen
//        self.present(nav, animated: true, completion: nil)
        
    }
}

extension HomeVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchWith(string: "")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchWith(string: searchText)
    }
    
    func searchWith(string: String) {
        self.searchData.removeAll()
        for item in Data.shared.product {
            if item.name.lowercased().contains(string.lowercased()) ||
                item.categoryName.lowercased().contains(string.lowercased()) ||
                item.description0.lowercased().contains(string.lowercased()) ||
                string.count == 0 {
                self.searchData.append(item)
            }
        }
        self.clvProduct.reloadData()
    }
}

extension UISearchBar {
    func setMagnifyingGlassColorTo(color: UIColor) {
        let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
        let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
        glassIconView?.tintColor = color
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
