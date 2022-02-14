//
//  HomeHeaderTableViewCell.swift
//  Mock
//
//  Created by DauTT1 on 1/25/22.
//

import UIKit

//protocol HomeHeaderProtocol {
//    func expandCloseHeader();
//}

class HomeHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var btnHeader: UIButton!
    @IBOutlet weak var imgExpanded: UIImageView!
    var sectionHeader : Int!
//    var delegate : HomeHeaderProtocol?
    var link : ViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupForHeaderCell(_ headerName : String, _ isExpanded: Bool, _ section: Int) {
        imgExpanded.image = isExpanded ? UIImage(named: "chevronDown") : UIImage(named: "chevronRight")
        btnHeader.setTitle(headerName, for: .normal)
        sectionHeader = section;
    }
    @IBAction func handleExpandClose(_ sender: Any) {
        link?.handleExpandClose(sectionHeader)
    }
    
}
