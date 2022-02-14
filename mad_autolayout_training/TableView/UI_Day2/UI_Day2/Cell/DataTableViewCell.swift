//
//  DataTableViewCell.swift
//  UI_Day2
//
//  Created by DauTT1 on 1/6/22.
//  Copyright © 2022 gammad. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {
    @IBOutlet weak var mainView: UIView!
    
//    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var imgNationFlagView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setImage(_ imageName: String)
    {

        imgNationFlagView.image = UIImage(named: imageName)
//        mainView.backgroundColor = UIColor.red
//        print(imageName);
//        let img = UIImage(named: imageName)
//        let imgView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width:  mainView.frame.size.width, height: mainView.frame.size.height - 10));
//        imgView.image = img;
//        mainView.addSubview(imgView);
//        mainView.insert
        //        mainView.(imgView);
    }
    
}
