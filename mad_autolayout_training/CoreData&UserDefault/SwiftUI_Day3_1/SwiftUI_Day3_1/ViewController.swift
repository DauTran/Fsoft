//
//  ViewController.swift
//  SwiftUI_Day3_1
//
//  Created by DauTT1 on 1/10/22.
//  Copyright © 2022 gammad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, RegisterViewControllerProtocol {
    
   
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var screen: UIView!
    
    //S1: core Data
    private var models = [User]();
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
    
    func getInformationUser(userInformation: (fullName: String, email: String)) {
        self.createItem(name: userInformation.fullName, email: userInformation.email)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = models[indexPath.row];
        
        guard let item: CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "dataCollectionViewCell", for: indexPath) as? CollectionViewCell
        else
        {
            fatalError("Didn't dequeue");
        }
        
        item.setup(model.fullName!, model.email!);
        
        return item;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true);
        let item = models[indexPath.row]
        let sheet = UIAlertController(title: "Edit", message: nil, preferredStyle: .actionSheet)
        
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: {_ in
            let alert = UIAlertController(title: "Update Information", message: "Enter information of user", preferredStyle: .alert)
            alert.addTextField(configurationHandler: nil)
            alert.textFields?.first?.text = item.fullName
            alert.addTextField(configurationHandler: nil)
            alert.textFields?.last?.text = item.email
            alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: {[weak self] _ in
                guard let name = alert.textFields?.first, let fullName = name.text, !fullName.isEmpty else {
                    return
                }
                guard let email = alert.textFields?.last, let emailUser = email.text, !emailUser.isEmpty else {
                    return
                }
                self?.updateItem(item: item, newFull: fullName, newEmail: emailUser)
            }))
            self.present(alert, animated: true)
        }))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {[weak self] _ in self?.deleteItem(item: item)}))
        
        present(sheet, animated: true)
    }
    
    func setupCollectionView()
    {
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "dataCollectionViewCell")
        collectionView.delegate = self;
        collectionView.dataSource = self;
        title = "user Infor"
        getAllItem();
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    
    @objc private func didTapAdd() {
//Plan A
        let registerViewControl : RegisterViewController = RegisterViewController(nibName: "RegisterViewController", bundle: nil);
        registerViewControl.delegate = self
        navigationController?.pushViewController(registerViewControl, animated: true);
//        self.present(registerViewControl, animated: true);

//        let fullNameFromUD = UserDefaults.standard.object(forKey: "FullNameKay")
//        let emailFromUD = UserDefaults.standard.object(forKey: "EmailKay")
//        print("222222 FullNameKay \(String(describing: fullNameFromUD)) EmailKay \(String(describing: emailFromUD))")
//        self.createItem(name: fullNameFromUD as! String, email: emailFromUD as! String);
        
//Plan B
//        let alert = UIAlertController(title: "Full name", message: "Enter information of user", preferredStyle: .alert)
//        alert.addTextField(configurationHandler: nil)
//        alert.addTextField(configurationHandler: nil)
//        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: {[weak self] _ in
//            guard let name = alert.textFields?.first, let fullName = name.text, !fullName.isEmpty else {
//                return
//            }
//            guard let email = alert.textFields?.last, let emailUser = email.text, !emailUser.isEmpty else {
//                return
//            }
//            self?.createItem(name: fullName, email: emailUser)
//        }))
//        present(alert, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screen.frame.width - 15, height: 100)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "CoreData infor"
        setupCollectionView();
    }
    
    //S2: core Data
    func getAllItem() {
        do {
            models = try context.fetch(User.fetchRequest());
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } catch { }
    }
    
    func createItem(name: String, email: String) {
        let newItem = User(context: context);
        newItem.fullName = name;
        newItem.email = email;
        
        do {
            try context.save();
            getAllItem();
        } catch {}
    }
    
    func deleteItem(item: User) {
        context.delete(item)
        
        do {
            try context.save()
            getAllItem();
        } catch {}
        
    }
    
    func updateItem(item: User, newFull: String, newEmail: String) {
        item.fullName = newFull;
        item.email = newEmail;
        
        do {
            try context.save();
            getAllItem();
        } catch { }
    }
}
    




