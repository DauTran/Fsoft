//
//  ViewController.swift
//  UI_Day1
//
//  Created by DauTT1 on 12/30/21.
//  Copyright © 2021 gammad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
//    @IBOutlet weak var btnForgot: UIButton!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initializeAtBegin();

    }
    
    //Hide navigation bar in home screen
//    override func viewWillAppear(_ animated: Bool)
//    {
//        super.viewWillAppear(animated);
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
    
    //    This function to hide the keyboard when user touch out of textfield
    @objc func dismissKeyboard()
    {
        view.endEditing(true);
    }
    
    func initializeAtBegin()
    {
        
        let emailImage = UIImage(named: "iconEmail");
        
        addLeftImageTo(txtField: txtEmail, andImage: emailImage!)
        
        let passwordImage = UIImage(named: "iconPassword");
        
        addLeftImageTo(txtField: password, andImage: passwordImage! );
        
        btnLogin.layer.cornerRadius = 12.0

        
        let tapGesture = UITapGestureRecognizer (target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tapGesture.cancelsTouchesInView = false;
        view.addGestureRecognizer(tapGesture)
        
        //set up for left swipe to back screen
//        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;

    }
    
    //left swipe to back screen
    
    
    
    func addLeftImageTo(txtField: UITextField, andImage img: UIImage)
    {
        let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: img.size.width/2, height: img.size.height/2))
        leftImageView.image = img
        txtField.leftView = leftImageView
        txtField.leftViewMode = .always
        
        let rightBtnForgot = UIButton(frame: CGRect(x: CGFloat(password.frame.size.width), y: CGFloat(password.frame.size.height), width: 72, height: 29))
        rightBtnForgot.setTitle("Forgot?", for: .normal);
        rightBtnForgot.setTitleColor(UIColor.init(red: 39/255, green: 144/255, blue: 245/255, alpha: 0.85), for: .normal)
        rightBtnForgot.titleLabel?.font = UIFont(name: "System", size: 12)
        password.rightView = rightBtnForgot;
        password.rightViewMode = UITextField.ViewMode.always;
    }
    
    
    @IBAction func moveToRegister(_ sender: Any) {
        print("Register ");
        
        let registerView : RegisterViewController = RegisterViewController(nibName: "RegisterViewController", bundle: nil);
//        self.present(registerView, animated: true, completion: nil);
        navigationController?.pushViewController(registerView, animated: true)
//        RegisterViewController
    }
    
}

