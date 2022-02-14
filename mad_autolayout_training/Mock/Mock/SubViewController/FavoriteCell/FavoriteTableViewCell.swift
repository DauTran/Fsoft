//
//  FavoriteTableViewCell.swift
//  Mock
//
//  Created by DauTT1 on 1/18/22.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var mainIcon: UIImageView!
    @IBOutlet weak var mainTilte: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    
    var link : FavoriteViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
            contentView.backgroundColor = UIColor.lightGray
            self.backgroundColor = UIColor.lightGray
            btnFavorite.backgroundColor = UIColor.lightGray
            mainIcon.backgroundColor = UIColor.lightGray
            }
        else {
            self.backgroundColor = UIColor.black
            contentView.backgroundColor = UIColor.black
            btnFavorite.backgroundColor = UIColor.black
            mainIcon.backgroundColor = UIColor.black
            }
        
    }
    
    func setFavorite(isFavorite: Bool) {
        
//        TODO: favorite button - get the index of cell
        btnFavorite.setImage(isFavorite ? UIImage(named: "starFill") : UIImage(named: "star"), for: .normal)
        btnFavorite.backgroundColor = UIColor.black
        
        btnFavorite.addTarget(self, action: #selector(handleMarkFavorite), for: .touchUpInside)
        
    }
    
    @objc private func handleMarkFavorite (button: UIButton) {
        print("\(#line)")
        link?.removeFavoriteAt(cell: self)
    }
    
    func setupForCell(_ title: String, _ detail: String, urlIcon: URL?) {
        mainTilte.text = title;
        mainIcon.sd_setImage(with: urlIcon, completed: nil)
        detailLabel.text = detail;
    }
    
    
}
