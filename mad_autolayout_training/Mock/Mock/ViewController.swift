//
//  ViewController.swift
//  Mock
//
//  Created by DauTT1 on 1/13/22.
//

import UIKit
//import SDWebImage
import Alamofire

class ViewController: UIViewController {
    
//    Core data item
    //for category
    private var modelCategories = [Category]();
    let contextCategory = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
    //for coin list
    private var modelCoinlists = [Coinlist]();
    let contextCoinlist = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
    //for favorite
    private var modelFavorites : Favorite?;
    let contextFavorite = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
    
//    the url of API to GET request
    let urlCategory1 = "https://demo5438105.mockable.io/category"
    let urlCategory = "https://demo6862618.mockable.io/dautran"
    
    let urlCoinList1 = "https://demo5438105.mockable.io/coinlist"
    let urlCoinList = "https://demo6862618.mockable.io/dautran2"

    var isExpanded = [Bool]()
    var countRowInsection = [Int]()
    
    let group = DispatchGroup()

    
    @IBOutlet weak var homeTableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Categories"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        activityIndicator.hidesWhenStopped = true;
        activityIndicator.startAnimating();
        
        setupHomeScreen();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAllCoinlist();
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
}

// MARK: - Check coredata exist
extension ViewController {
    func checkCoreDataExist(_ entity: String) {
        
    }
    
}

// MARK:- Category
extension ViewController {

    struct ResponseCategoryCodable: Codable {
        let category: [CategoryCodable]
    }

    struct CategoryCodable: Codable {
        let id: String
        let description: String
    }
    
    //TODO: Core data item for a category
    func createCategories(_ categories: [CategoryCodable]) {
        for category in categories {
            let newCategory = Category(context: contextCategory)
            newCategory.idCategory = category.id;
            newCategory.descriptionCategory = category.description;

            do {
                try contextCategory.save();
            } catch {}
        }
        getAllCategories();
        
    }
    
    func updateCategories(_ categories: [CategoryCodable]) {
        for i in 0..<modelCategories.count {
            modelCategories[i].idCategory = categories[i].id;
            modelCategories[i].descriptionCategory = categories[i].description;

            do {
                try contextCategory.save();
            } catch {}
        }
        getAllCategories();
    }
    
    func initHeaderTableView() {
//      create an expand array and number element of row in section
        if isExpanded.isEmpty
        {
            for i in 0..<modelCategories.count
            {
                if i == 0 {
                    isExpanded.append(true);
                } else {
                    isExpanded.append(false);
                }
                countRowInsection.append(0);
            }
        }
        
    }
    
    func getAllCategories() {
        do {
            modelCategories = try contextCategory.fetch(Category.fetchRequest());
            DispatchQueue.main.async {
                self.homeTableView.reloadData();
            }
        } catch {}
    }
    
    func isCategoryModelEmpty() -> Bool {
        do {
            modelCategories = try contextCategory.fetch(Category.fetchRequest());
        } catch {}
        
        return modelCategories.isEmpty;
    }
    
// TODO: http GET
    private func getCategory(from url: String) {
//        group.enter();
        URLSession(configuration: URLSessionConfiguration.default).dataTask(with: URL(string: url)!) { [self] data, response, error in
            
            //ensure there is data returned from this HTTP response
            guard let data = data else {
                print("No data")
                return
            }
            
            
            
            // have data
            var result: ResponseCategoryCodable?
            do {
                result = try JSONDecoder().decode(ResponseCategoryCodable.self, from: data)
            } catch {
        
                print("fail to convert \(error.localizedDescription)")
                let alert = UIAlertController(title: "Connection Lost", message: "API not found. ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Reload", style: .cancel, handler: {_ in getCategory(from: urlCategory);}))
                if !isCategoryModelEmpty()
                {
                    alert.message = "API not found. Do you want to import an old database? ";
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in getAllCategories();
                    self.getCoinlist(from: urlCoinList);
                }))
                
                }
                DispatchQueue.main.async {
                    present(alert, animated: true, completion: nil)
                }
                print("\(#line)")
                return
            }
            print()
            print("API")
            print()
            
            guard let json = result else {
                return
            }
            if(self.isCategoryModelEmpty())
            {
                print("Empty category")
                self.createCategories(json.category)
                print("\(#line) \(modelCategories.count) \(modelCoinlists.count) \(isExpanded) \(countRowInsection)")

            }
            else {
                print("exist category")
                self.updateCategories(json.category)
                print("\(#line) \(modelCategories.count) \(modelCoinlists.count) \(isExpanded) \(countRowInsection)")

            }
            print("\(#function)")
            print("\(#line) \(Thread.isMainThread) \(Thread.current)")
//            self.getCoinlist(from: urlCoinList);
//            print("\(#line) \(modelCategories.count) \(modelCoinlists.count) \(isExpanded) \(countRowInsection)")
            
            
//            print("1 \(#function) ")
            
        }.resume()
    }

}

// MARK: - Coinlist
extension ViewController {
    struct ResponseCoinlistCodable: Codable {
        let coinlist : [CoinlistCodable]
    }
    
    struct CoinlistCodable: Codable {
        let id : String
        let category_ids: String
        let coin_code: String
        let coin_name: String
        let logo_image: String
        let description: String
    }

    func createCoinlist(_ coinlists: [CoinlistCodable]) {
//  TODO: Core data item for coinlist
        for coin in coinlists {
            let newCoin = Coinlist(context: contextCoinlist)
            newCoin.idCoin = coin.id;
            newCoin.category_ids = coin.category_ids;
            newCoin.coin_code = coin.coin_code;
            newCoin.coin_name = coin.coin_name
            newCoin.logo_image = coin.logo_image;
            newCoin.descriptionCoin = coin.description;
            newCoin.isFavorite = false;
            do {
                try contextCoinlist.save();
                do {
                    modelCoinlists = try contextCoinlist.fetch(Coinlist.fetchRequest())
                } catch {}

            } catch {}
        }
        countForSection();
        print("\(#line) \(modelCategories.count) \(modelCoinlists.count) \(isExpanded) \(countRowInsection)")
    }
    
    
    func updateCoinlist(_ coinlist: [CoinlistCodable]) {
        for i in 0..<coinlist.count
        {
            modelCoinlists[i].idCoin = coinlist[i].id;
            modelCoinlists[i].category_ids = coinlist[i].category_ids;
            modelCoinlists[i].coin_code = coinlist[i].coin_code;
            modelCoinlists[i].coin_name = coinlist[i].coin_name
            modelCoinlists[i].logo_image = coinlist[i].logo_image;
            modelCoinlists[i].descriptionCoin = coinlist[i].description;
            do {
                try contextCoinlist.save()
                do {
                    modelCoinlists = try contextCoinlist.fetch(Coinlist.fetchRequest())
                } catch {}
            } catch {}
        }
        countForSection();
    }
    
    func reverseFavorite(_ favoriteCoin: Coinlist)
    {
        favoriteCoin.isFavorite = !favoriteCoin.isFavorite;
        
        do {
            try contextCoinlist.save()
            getAllCoinlist();
        } catch {}
    }
    
    func getAllCoinlist() {
        do {
            
            modelCoinlists = try contextCoinlist.fetch(Coinlist.fetchRequest())
            DispatchQueue.main.async {
                self.homeTableView.reloadData();
            }
        } catch {}
//        DispatchQueue.main.async {
//            self.activityIndicator.stopAnimating();
//        }
    }
    
    func isCoinlistModelEmpty() -> Bool {
        do {
            modelCoinlists = try contextCoinlist.fetch(Coinlist.fetchRequest())
        } catch {}
        
        return modelCoinlists.isEmpty;
    }
    
    func countForSection() {
        for coin in modelCoinlists {
            let temp : Int = Int(coin.category_ids!)!;
            countRowInsection[temp] = countRowInsection[temp] + 1;
        }
    }
    
    // TODO: http GET
    private func getCoinlist(from url: String) {

        URLSession(configuration: URLSessionConfiguration.default).dataTask(with: URL(string: url)!) { [self] data, response, error in
            //ensure there is data returned from this HTTP response
            guard let data = data else {
                print("No data")
                return
            }
            
            // have data
            var result: ResponseCoinlistCodable?
            do {
                result = try JSONDecoder().decode(ResponseCoinlistCodable.self, from: data)
            }
            catch {
                print("fail to convert coin list \(error.localizedDescription)")
                getAllCoinlist();
                countForSection();
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating();
                }
                return;
            }
            
            guard let json = result else {
                return
            }
//            FIXME: - Check if the coredata exists
            if(self.isCoinlistModelEmpty())
            {
                print("Empty coinr")
                createCoinlist(json.coinlist);
                print("\(#line) \(modelCategories.count) \(modelCoinlists.count) \(isExpanded) \(countRowInsection)")

            }
            else {
                print("coin data")
                updateCoinlist(json.coinlist);
                print("\(#line) \(modelCategories.count) \(modelCoinlists.count) \(isExpanded) \(countRowInsection)")
            }
            DispatchQueue.main.async {
                homeTableView.reloadData();
                activityIndicator.stopAnimating();
            }
            print("\(#function)")
            print("\(#line) \(Thread.isMainThread) \(Thread.current)")
        }.resume()
    }
    
}

// MARK: 1 setup Tableview

extension ViewController : UITableViewDelegate, UITableViewDataSource {

    func setupHomeScreen() {

        let group = DispatchGroup();
        
        group.enter()
        getCategory(from: urlCategory);
        print("Hi 1")
        print()
        group.leave()
        
        group.enter()
        getCoinlist(from: urlCoinList)
        print("Hi 2")
        group.leave()
        
        group.notify(queue: .main) { [self] in
            homeTableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "homeTableViewCell")
            homeTableView.register(UINib(nibName: "HomeHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "homeHeaderTableViewCell")
            homeTableView.delegate = self; // Calling the first function is viewForHeaderInSection section of the tableView
            homeTableView.dataSource = self; // Calling the first function(an objc) is numberOfSections
            
            print("\(#function)")
            print("\(#line) \(Thread.isMainThread) \(Thread.current)")
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(!isExpanded.isEmpty && isExpanded[section]) {
            return countRowInsection[section];
        }
        return 0

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "homeTableViewCell", for: indexPath) as? HomeTableViewCell
        else {
            fatalError("Unable to dequeue Cell");
        }
        
        if(indexPath.section == 0)
        {
            cell.setupForCell(modelCoinlists[indexPath.row].coin_code!,  modelCoinlists[indexPath.row].coin_name!, urlIcon: URL(string: modelCoinlists[indexPath.row].logo_image!))
            cell.link = self; //favorite button - get the index of cell
            cell.setFavorite(isHidden: false, isFavorite: modelCoinlists[indexPath.row].isFavorite);
        }
        else
        {
            // to find the begin of row in the section
            var countBegin = 0;
            for i in 0..<indexPath.section
            {
//                print("i+ \(i)")
                countBegin += countRowInsection[i];
            }
            let index = indexPath.row + countBegin;
            
            cell.setupForCell(modelCoinlists[index].coin_code!,  modelCoinlists[index].coin_name!, urlIcon: URL(string: modelCoinlists[index].logo_image!))
            cell.link = self; //favorite button - get the index of cell
            cell.setFavorite(isHidden: false, isFavorite: modelCoinlists[index].isFavorite);
        }

        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 61.5;
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.backgroundColor = UIColor.red
//        cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        print("Row \(indexPath.row) section \(indexPath.section)")
        
        //find the index of coin
        var index = 0;
        if(indexPath.section == 0) {
            index = indexPath.row
        }
        else
        {
            // to find the begin of row in the section
            var countBegin = 0;
            for i in 0..<indexPath.section
                {
                    countBegin += countRowInsection[i];
                }
                index = indexPath.row + countBegin;
        }
        
        let descriptionViewControlStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = descriptionViewControlStoryboard.instantiateViewController(withIdentifier: "descriptionVC") as? DescriptionViewController
        let coinNameHeader : String = modelCoinlists[index].coin_name! + "(" + modelCoinlists[index].coin_code! + ")";

        vc?.delegate = self
        vc?.idCoinDescription = indexPath
        
        vc?.detailContent = modelCoinlists[index].descriptionCoin!
        vc?.headerTitle = coinNameHeader;
        vc?.url = modelCoinlists[index].logo_image!
        vc?.isFavorite = modelCoinlists[index].isFavorite
        
        vc?.modalPresentationStyle = .overFullScreen;
        self.present(vc!, animated: true);
    }
    
// MARK: - 1.1 TableView section
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        print("\(#line) \(modelCategories.count) \(modelCoinlists.count) \(isExpanded) \(countRowInsection)")
        initHeaderTableView();
        
//        let button = UIButton(type: .system);
//        button.setTitle(modelCategories[section].descriptionCategory, for: .normal)
//        button.setTitleColor(UIColor.white, for: .normal);
//        button.backgroundColor = UIColor.black;
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
//        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
//        button.contentHorizontalAlignment = .left;
//        button.tag = section;
//
//        button.imageView?.contentMode = .scaleAspectFit
//        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 5)
//        button.semanticContentAttribute = .forceRightToLeft;
//
//
//
//        if isExpanded.indices.contains(section) {
//            button.setImage(isExpanded[section] ? UIImage(named: "chevronDown") : UIImage(named: "chevronRight"), for: .normal)
//        } else {
//            print("Out of range Expanded")
//        }
//        return button;
        
        guard let headerCell: HomeHeaderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "homeHeaderTableViewCell") as? HomeHeaderTableViewCell
        else {
            fatalError("Unable to dequeue Cell");
        }
        headerCell.link = self
        headerCell.setupForHeaderCell(modelCategories[section].descriptionCategory!, isExpanded[section], section)
        
        return headerCell;
    }
    
    func handleExpandClose(_ section : Int) {
        // TODO: Expand/collapsible section
        isExpanded[section] = !(isExpanded[section]);
        getAllCategories();
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //TODO: Set status of section button header
         return modelCategories.count;
    }
    
    func tapFavoriteAt(cell: UITableViewCell) {
        //TODO: favorite button - get the index of cell
        //TODO: add into favorite
        let indexPathTapped = homeTableView.indexPath(for: cell);
        var index = 0;
        if(indexPathTapped?.section == 0) {
            index = indexPathTapped!.row
        }
        else
        {
            // to find the begin of row in the section
            var countBegin = 0;
            for i in 0..<indexPathTapped!.section
                {
    //                print("i+ \(i)")
                    countBegin += countRowInsection[i];
                }
                index = indexPathTapped!.row + countBegin;
        }
        reverseFavorite(modelCoinlists[index]);
    }

}

extension ViewController : DescriptionProtocol {
    func changeFavoriteState(_ id: IndexPath) {
        print("i \(id)")
        tapFavoriteAt(cell: homeTableView.cellForRow(at: id) as! HomeTableViewCell)
       
    }
    

}



