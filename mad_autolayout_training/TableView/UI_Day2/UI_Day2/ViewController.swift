//
//  ViewController.swift
//  UI_Day2
//
//  Created by DauTT1 on 1/6/22.
//  Copyright © 2022 gammad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let flag : [(String, String)] = [("vn", "Viet Nam"), ("ad", "Andora"), ("ae", "United Arab Emirates"), ("af", "Afghanistan"), ("ag", "Antigua & Barbuda"), ("ai", "Anguilla"), ("al", "Albania"), ("am", "Armenia"),  ("ao", "Angola"), ("aq", "Antarctica"), ("ar", "Argentina")]
//    let flag : [String] = ["vn"]
    @IBOutlet weak var dataTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        settingupTableView();
    }
    
    func settingupTableView()
    {
        self.dataTableView.register(UINib(nibName: "DataTableViewCell", bundle: nil), forCellReuseIdentifier: "dataTableViewCell");
        self.dataTableView.delegate = self;
        self.dataTableView.dataSource = self;
    }
    
    //MARK: - UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flag.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: DataTableViewCell = tableView.dequeueReusableCell(withIdentifier: "dataTableViewCell", for: indexPath) as?  DataTableViewCell
        else
        {
            fatalError("Unable to dequeue ReminderCell");
        }
//        let cell : DataTableViewCell = tableView.dequeueReusableCell(withIdentifier: "dataTableViewCell") as! DataTableViewCell
        cell.setImage(flag[indexPath.row].0);

//        cell.setImage("flag[indexPath.row]")
        
           return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row \(indexPath.row)")
//        print("row", "\(indexPath.row) : \(flag[indexPath.row].1)");
        let informationVC : SubViewController = SubViewController  (nibName: "SubViewController", bundle: nil);
//        informationVC.settingupInformation(flag[indexPath.row].0, flag[indexPath.row].1);
        informationVC.nationOfName = flag[indexPath.row].1;
        informationVC.nationOfFlag = flag[indexPath.row].0;
        
//        self.present(informationVC, animated: true, completion: nil);
        navigationController?.pushViewController(informationVC, animated: true)
    }
}

