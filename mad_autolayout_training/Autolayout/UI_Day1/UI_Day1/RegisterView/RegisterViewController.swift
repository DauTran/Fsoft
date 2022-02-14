//
//  RegisterViewController.swift
//  UI_Day1
//
//  Created by DauTT1 on 12/30/21.
//  Copyright © 2021 gammad. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var txtEmailIcon: UITextField!
    @IBOutlet weak var txtPasswordIcon: UITextField!
    @IBOutlet weak var txtFullNameIcon: UITextField!
    @IBOutlet weak var txtCompanyNameIcon: UITextField!
    
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
        
        let passwordIcon = UIImage(named: "iconPassword");
        
        addLeftImageTo(txtField: txtPasswordIcon, andImage: passwordIcon! );
        let fullNameIcon = UIImage(named: "iconFace-1");
        
        addLeftImageTo(txtField: txtFullNameIcon, andImage: fullNameIcon!)
        
        let companyNameIcon = UIImage(named: "iconCompany");
        
        addLeftImageTo(txtField: txtCompanyNameIcon, andImage: companyNameIcon! );
        
    
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
