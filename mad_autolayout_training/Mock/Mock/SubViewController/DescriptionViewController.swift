//
//  DescriptionViewController.swift
//  Mock
//
//  Created by DauTT1 on 1/18/22.
//

import Foundation
import UIKit

protocol DescriptionProtocol {
    func changeFavoriteState(_ id: IndexPath)
}

class DescriptionViewController: UIViewController {

    
    @IBOutlet weak var headerIcon: UIImageView!
    @IBOutlet weak var btnClose: UIButton!
    
    @IBOutlet weak var mainTilte: UIButton!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    
    
    
    var detailContent : String = "";
    var headerTitle : String = "";
    var url : String = "";
    var isFavorite : Bool?
    
    var idCoinDescription : IndexPath?
    var delegate : DescriptionProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailLabel.text = detailContent;
        headerIcon.sd_setImage(with: URL(string: url), completed: nil)
        mainTilte.setTitle(headerTitle, for: .normal);
        btnFavorite.setImage(isFavorite! ? UIImage(named: "starFill") : UIImage(named: "star"), for: .normal)
        reloadFavorite()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func reloadFavorite() {
        btnFavorite.setImage(isFavorite! ? UIImage(named: "starFill") : UIImage(named: "star"), for: .normal)
    }
    
    func setInfor(_ title: String, _ description: String, urlIcon: URL?) {
        mainTilte.setTitle(title, for: .normal);
        headerIcon.sd_setImage(with: urlIcon, completed: nil)
        detailLabel.text = description;
    }
    
    @IBAction func closeDescriptionController(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func reverseFavorite(_ sender: Any) {
        isFavorite = !(isFavorite!)
        reloadFavorite()
        delegate?.changeFavoriteState(idCoinDescription!)
    }
}
