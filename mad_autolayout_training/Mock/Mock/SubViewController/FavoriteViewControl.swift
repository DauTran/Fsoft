//
//  FavoriteViewControl.swift
//  Mock
//
//  Created by DauTT1 on 1/18/22.
//

import Foundation
import UIKit

//protocol FavoriteProtocol {
//    func setInfor(_ title: String, _ description: String, urlIcon: URL?)
//}

class FavoriteViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var favoriteTableView: UITableView!
    
//    var delegate: FavoriteProtocol? // protocol
    
    private var modelCoinFavorite = [Coinlist]();
    let contextCoinlist = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor.brown;
        setupTableView();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchFavorite();
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func removeFavoriteAt(cell: FavoriteTableViewCell) {
       test();
        
        let indexPathTapped = favoriteTableView.indexPath(for: cell)
        
        modelCoinFavorite[indexPathTapped!.row].isFavorite = false
        do {
            try contextCoinlist.save()
        } catch {}
        
        modelCoinFavorite.remove(at: indexPathTapped!.row)
        
        DispatchQueue.main.async { [self] in
            favoriteTableView.reloadData();
        }
        
        test();

    }
    
    func test () {
       do {
        let model : [Coinlist] = try contextCoinlist.fetch(Coinlist.fetchRequest())
            
        print("length \(model.count)   \(model)")
       } catch {}
    }
    
    func setupTableView() {
        
        navigationItem.title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        self.favoriteTableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "favoriteTableViewCell");
        self.favoriteTableView.delegate = self;
        self.favoriteTableView.dataSource = self;
        getAllFavorite();
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelCoinFavorite.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: FavoriteTableViewCell = tableView.dequeueReusableCell(withIdentifier: "favoriteTableViewCell", for: indexPath) as? FavoriteTableViewCell
        else {
            fatalError("Unable to dequeue Cell");
        }
        cell.link = self;
        cell.setFavorite(isFavorite: modelCoinFavorite[indexPath.row].isFavorite)
        cell.setupForCell(modelCoinFavorite[indexPath.row].coin_code!, modelCoinFavorite[indexPath.row].coin_name!, urlIcon: URL(string: modelCoinFavorite[indexPath.row].logo_image!));
        return cell;
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //View controller same storyboard
//        let descriptionViewControlStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = descriptionViewControlStoryboard.instantiateViewController(withIdentifier: "descriptionVC") as? DescriptionViewController
//        let coinNameHeader : String = modelCoinFavorite[indexPath.row].coin_name! + "(" + modelCoinFavorite[indexPath.row].coin_code! + ")";
        
//        vc?.delegate = self;
//        vc?.idCoinDescription = indexPath;
//
//        vc?.detailContent = modelCoinFavorite[indexPath.row].descriptionCoin!
//        vc?.headerTitle = coinNameHeader;
//        vc?.url = modelCoinFavorite[indexPath.row].logo_image!
//        vc?.isFavorite = modelCoinFavorite[indexPath.row].isFavorite
//
//        vc?.modalPresentationStyle = .overFullScreen;
//        self.present(vc!, animated: true);
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favoriteTableView.beginUpdates()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
            favoriteTableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func fetchFavorite() {
        do {
            let temp = try contextCoinlist.fetch(Coinlist.fetchRequest())
            var modelUpdate = [Coinlist]();
            for coin in temp
            {
                if((coin as AnyObject).isFavorite!) {
                    modelUpdate.append(coin as! Coinlist);
                }
            }
            modelCoinFavorite = modelUpdate;
            DispatchQueue.main.async {
                self.favoriteTableView.reloadData();
            }
        } catch {}
    }
    
    func getAllFavorite() {
        do {
            let temp = try contextCoinlist.fetch(Coinlist.fetchRequest())
            for coin in temp
            {
                if((coin as AnyObject).isFavorite!) {
                    modelCoinFavorite.append(coin as! Coinlist);
                }
            }
            DispatchQueue.main.async {
                self.favoriteTableView.reloadData();
            }
        } catch {}
    }
}

//extension FavoriteViewController : DescriptionProtocol {
//    func changeFavoriteState(_ id: IndexPath) {
//        print("i \(id)")
//        removeFavoriteAt(cell: favoriteTableView.cellForRow(at: id) as! FavoriteTableViewCell)
//    }
//}

