//
// ProfileVC.swift.
// Shopping.
// 

import UIKit
import Alamofire
import SkyFloatingLabelTextField
import SwiftyJSON
import KRProgressHUD
class ProfileVC: UIViewController {
    @IBOutlet weak var imgAvata: UIImageView!
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var tfPhoneNumber: SkyFloatingLabelTextField!
    @IBOutlet weak var tfAddress: SkyFloatingLabelTextField!
    @IBOutlet weak var tfEmail: SkyFloatingLabelTextField!
    @IBOutlet weak var tfFullname: SkyFloatingLabelTextField!
    @IBOutlet weak var tfUsername: SkyFloatingLabelTextField!
    @IBOutlet weak var tfdateofbirth: SkyFloatingLabelTextField!
    
    var isEditProfile:Bool = true
    var checkGender:Bool = true
    let datePickerView:UIDatePicker = UIDatePicker()
    var selectedDate: Date = Date() {
        didSet {
            datePickerView.date = selectedDate
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfUsername.isUserInteractionEnabled = false
        setIsUserInterEnab(check: true)
        
        
        
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        tfdateofbirth.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(ProfileVC.datePickerValueChanged), for: .valueChanged)
        
        
        imgAvata.layer.cornerRadius = 40
        imgAvata.layer.masksToBounds = true
        imgAvata.layer.borderWidth = 0.5
        imgAvata.layer.borderColor = #colorLiteral(red: 0.9868738055, green: 0.1452238262, blue: 0.2056418657, alpha: 1)
        
        initUI()
        
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        tfdateofbirth.text = sender.date.toString()
        selectedDate = sender.date
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        initData()
        initUI()
    }
    
    func setTF() {
        tfUsername.text = Data.shared.userProfile.username
        tfEmail.text = Data.shared.userProfile.email
        tfAddress.text = Data.shared.userProfile.address
        tfFullname.text = Data.shared.userProfile.name
        tfPhoneNumber.text = Data.shared.userProfile.phoneNumber
        checkGender = Data.shared.userProfile.gender
        if checkGender {
            btnMale.setImage(#imageLiteral(resourceName: "check-box"), for: UIControl.State.normal)
            btnFemale.setImage(#imageLiteral(resourceName: "blank-check-box"), for: UIControl.State.normal)
        }else{
            btnMale.setImage(#imageLiteral(resourceName: "blank-check-box"), for: UIControl.State.normal)
            btnFemale.setImage(#imageLiteral(resourceName: "check-box"), for: UIControl.State.normal)
        }
        tfdateofbirth.text = Data.shared.userProfile.dateOfBirth.toString()
        selectedDate = Data.shared.userProfile.dateOfBirth
        
    }
    
    func setIsUserInterEnab(check:Bool)  {
        tfPhoneNumber.isUserInteractionEnabled = check
        tfFullname.isUserInteractionEnabled = check
        tfAddress.isUserInteractionEnabled = check
        tfEmail.isUserInteractionEnabled = check
        tfdateofbirth.isUserInteractionEnabled = check
        btnMale.isUserInteractionEnabled = check
        btnFemale.isUserInteractionEnabled = check
        //tfUsername.isUserInteractionEnabled = check
    }
    
    
    @IBAction func actionBack(_ sender: Any) {
        //        let app = UIApplication.shared.delegate as! AppDelegate
        //        app.tabVC?.selectedIndex = 2
        //        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actioncheckMale(_ sender: UIButton) {
        if !checkGender {
            btnMale.setImage(#imageLiteral(resourceName: "check-box"), for: UIControl.State.normal)
            checkGender = true
            btnFemale.setImage(#imageLiteral(resourceName: "blank-check-box"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func actioncheckFemale(_ sender: UIButton) {
        if checkGender {
            btnFemale.setImage(#imageLiteral(resourceName: "check-box"), for: UIControl.State.normal)
            checkGender = false
            btnMale.setImage(#imageLiteral(resourceName: "blank-check-box"), for: UIControl.State.normal)
        }
    }
    
    func formatGroupUserId() -> Int {
        let str = Data.shared.userProfile.groupRole
        switch str {
        case .Admin:
            return 1
        case .Staff:
            return 2
        case .Customer:
            return 3
        case .StaffManager:
            return 4
        default:
            return 0
        }
    }
    
    @IBAction func actionLogout(_ sender: Any) {
        self.view.endEditing(true)
        
        let name:String = tfFullname.text ?? ""
        let email:String = tfEmail.text ?? ""
        let address:String = tfAddress.text ?? ""
        let phoneNumber:String = tfPhoneNumber.text ?? ""
        let gender:Bool = checkGender
        
        
        let datestr:String   = selectedDate.toString("yyyy-MM-dd")
        
        let image:String = ""
        let groupUserId:Int = formatGroupUserId()
        
        APIManager.shared.putUser(name: name, email: email, address: address, phoneNumber: phoneNumber, gender: gender, dateOfBirth: datestr, image: image, groupUserId: groupUserId, progress: true) { (status) in
            Helper.alertUpdateProfile(msg: "Update successful!", target: self)
            self.initData()
        }
    }
}

extension ProfileVC {
    func initUI() {
        self.setTF()
    }
    
    func initData() {
        APIManager.shared.getUser(progress: true) { (status) in
            if status {
                self.setTF()
            }else{
                print("erro")
            }
        }
    }
}
