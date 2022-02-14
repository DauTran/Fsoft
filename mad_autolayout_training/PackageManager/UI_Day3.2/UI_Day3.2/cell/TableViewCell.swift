//
//  TableViewCell.swift
//  UI_Day3.2
//
//  Created by DauTT1 on 1/12/22.
//  Copyright © 2022 gammad. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire

class TableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imageCell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension TableViewCell {
    func setURL(urlImg : URL?) {
        let queue = DispatchQueue(label: "queue");
        queue.async {
            do{
                let imgdata = try Data(contentsOf: urlImg!)
                DispatchQueue.main.async {
                    self.imageCell.image = UIImage(data: imgdata);
                }
            }catch{
                print("Didn't get!")}
            }
    }
    
    func setURLwithLib(urlImg: URL?) {
        imageCell.sd_setImage(with: urlImg, completed: nil)
        
        let url = "https://api.openweathermap.org/data/2.5/weather?q=Danang&appid=0959c6d4cdd363a547258af5795e4558"
        // let url2 = "https://api.coinmarketcap.com/v1/ticker/bitcoin/?convert=AUD"
        
        AF.request(url).response {response in debugPrint(response)
            print("#function \(#line)", response)
        }
    }
}
