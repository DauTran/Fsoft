//
//  SubViewController.swift
//  UI_Day2
//
//  Created by DauTT1 on 1/6/22.
//  Copyright © 2022 gammad. All rights reserved.
//

import UIKit

class SubViewController: UIViewController {

    @IBOutlet weak var nationalFlag: UIImageView!
    @IBOutlet weak var nationalName: UILabel!
    
    var nationOfName : String = "";
    var nationOfFlag : String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nationalName.text = nationOfName;
        let img = UIImage(named: nationOfFlag)
        nationalFlag.image = img;
        // Do any additional setup after loading the view.
    }
    
//    nationalName.text = nationalName;
    
    func settingupInformation(_ nationalOfFlag : String, _ nationalOfName: String)
    {
        print("1, ", nationalOfName);
//        let img = UIImage(named: nationalOfFlag)
//        nationalFlag.image = img!;
//        nationalName.text = nationalOfName;
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
