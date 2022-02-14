//
//  HomeTableViewCell.swift
//  Mock
//
//  Created by DauTT1 on 1/15/22.
//

import UIKit
import SDWebImage

//protocol TableViewCellProtocol {
//    func tapFavorite(cell: UITableViewCell);
//}

class HomeTableViewCell: UITableViewCell {
    //TODO: get the index of cell
    var link: ViewController?
    
    @IBOutlet weak var mainIcon: UIImageView!
    @IBOutlet weak var mainTilte: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var btnFavorite: UIButton!
    var isSelect: Bool!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        print("H \(#function)")
        isSelect = false;
        self.backgroundColor = isSelect ? UIColor.red : UIColor.black

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
    
    func setFavorite(isHidden: Bool, isFavorite: Bool) {
//      TODO: favorite button - get the index of cell
        btnFavorite.setImage(isFavorite ? UIImage(named: "starFill") : UIImage(named: "star"), for: .normal)
        btnFavorite.backgroundColor = UIColor.black
        
        btnFavorite.addTarget(self, action: #selector(handleMarkFavorite), for: .touchUpInside)
//        let startButton = UIButton(type: .system)
//        startButton.isHidden = isHidden;
//        startButton.frame = CGRect(x: 0.0, y: 0.0, width: 39, height: 39)
//        startButton.setImage(isFavorite ? UIImage(named: "starFill") : UIImage(named: "star"), for: .normal)
//        accessoryView = startButton;
//
//        startButton.addTarget(self, action: #selector(handleMarkFavorite), for: .touchUpInside)
        
    }
    
    @objc private func handleMarkFavorite (button: UIButton) {
        link?.tapFavoriteAt(cell: self); //get the index of cell
        
//        MARK: Favorite
        //contextFavorite.addToCoinlists
//        let coin = Favorite(context: contextFavorite)
//        coin.addToCoinlists(modelCoinlists[indexPathTapped!.row]);
//        do {
//            try contextFavorite.save()
//        } catch { print("Can't add to favorite entity") }
    }
    
    func setupForCell(_ title: String, _ detail: String, urlIcon: URL?) {
        mainTilte.text = title;
        mainIcon.sd_setImage(with: urlIcon, completed: nil)
        detailLabel.text = detail;
    }
    
    
    
}
