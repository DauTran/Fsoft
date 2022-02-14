//
//  Coinlist+CoreDataProperties.swift
//  
//
//  Created by DauTT1 on 1/18/22.
//
//

import Foundation
import CoreData


extension Coinlist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Coinlist> {
        return NSFetchRequest<Coinlist>(entityName: "Coinlist")
    }

    @NSManaged public var category_ids: String?
    @NSManaged public var coin_code: String?
    @NSManaged public var coin_name: String?
    @NSManaged public var descriptionCoin: String?
    @NSManaged public var idCoin: String?
    @NSManaged public var logo_image: String?
    @NSManaged public var isFavorite: Bool

}
