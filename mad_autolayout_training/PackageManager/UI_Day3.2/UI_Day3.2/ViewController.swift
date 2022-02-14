//
//  ViewController.swift
//  UI_Day3.2
//
//  Created by DauTT1 on 1/12/22.
//  Copyright © 2022 gammad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var menuCollabView: UIView!
    let url = URL(string:"https://wallpapers-fenix.eu/full/211221/105131534.jpg");
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initializeAttribute();
    }
        
    func initializeAttribute(){
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        var urls = [NSURL]();
        
        urls.append(NSURL(string: "https://wallpapers-fenix.eu/full/211221/105131534.jpg")!);
        
    }


}

extension ViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : TableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as? TableViewCell
        else {
            fatalError("Unable to dequeue")
        }
        
        if(indexPath.row == 0) {
            cell.setURL(urlImg: url);
        }
        else
        {
            cell.setURLwithLib(urlImg: url)
        }
        
        return cell;
    }
}

