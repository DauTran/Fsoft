//
//  CollectionViewCell.swift
//  SwiftUI_Day3_1
//
//  Created by DauTT1 on 1/10/22.
//  Copyright © 2022 gammad. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var emailID: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(_ fullOfName : String, _ email : String)
    {
        fullName.text = fullOfName;
        emailID.text = email;
    }

}
