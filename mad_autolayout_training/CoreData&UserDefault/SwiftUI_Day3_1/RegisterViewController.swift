//
//  RegisterViewController.swift
//  UI_Day1
//
//  Created by DauTT1 on 12/30/21.
//  Copyright © 2021 gammad. All rights reserved.
//

import UIKit

protocol RegisterViewControllerProtocol {
    func getInformationUser(userInformation: (fullName: String, email: String));
}

class RegisterViewController: UIViewController {

    @IBOutlet weak var txtEmailIcon: UITextField!

    @IBOutlet weak var txtFullNameIcon: UITextField!
    var delegate : RegisterViewControllerProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeAtBegin(); 
        // Do any additional setup after loading the view.
    
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true);
    }
    
    func initializeAtBegin()
    {
        let emailIcon = UIImage(named: "iconEmail");
        
        addLeftImageTo(txtField: txtEmailIcon, andImage: emailIcon!)
        
        let fullNameIcon = UIImage(named: "iconFace-1");
        
        addLeftImageTo(txtField: txtFullNameIcon, andImage: fullNameIcon!)
        
    
        let tapGesture = UITapGestureRecognizer (target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tapGesture.cancelsTouchesInView = false;
        view.addGestureRecognizer(tapGesture)

    }
    
    func addLeftImageTo(txtField: UITextField, andImage img: UIImage)
    {
        let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: img.size.width/2, height: img.size.height/2))
        leftImageView.image = img
        txtField.leftView = leftImageView
        txtField.leftViewMode = .always
    }

    @IBAction func registerInfor(_ sender: Any) {
//        var appDel : AppDelegate = UIApplication.sha
        
//        UserDefaults.standard.setValue(txtFullNameIcon.text, forKey: "FullNameKay");
//        UserDefaults.standard.setValue(txtEmailIcon.text, forKey: "EmailKay");
//
//        let fullNameFromUD = UserDefaults.standard.object(forKey: "FullNameKay")
//        let emailFromUD = UserDefaults.standard.object(forKey: "EmailKay")
//        print("FullNameKay \(String(describing: fullNameFromUD)) EmailKay \(String(describing: emailFromUD))")

        delegate?.getInformationUser(userInformation: (fullName: txtFullNameIcon.text!, email: txtEmailIcon.text!))

        let alertController = UIAlertController(title: "Registrantion successful!", message: "You have successfully registered the information.", preferredStyle: .alert)
        let actionClose = UIAlertAction(title: "Close", style: .cancel, handler: {_ in
//            self.dismiss(animated: true, completion:{print("Hello")})
            self.navigationController?.popToRootViewController(animated: true)
        })
        alertController.addAction(actionClose);
        self.present(alertController, animated: true, completion: nil)
        
        
//        self.navigationController?.popToRootViewController(animated: true)

    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
