//
//  Favorite+CoreDataProperties.swift
//  
//
//  Created by DauTT1 on 1/17/22.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var coinlists: NSSet?

}

// MARK: Generated accessors for coinlists
extension Favorite {

    @objc(addCoinlistsObject:)
    @NSManaged public func addToCoinlists(_ value: Coinlist)

    @objc(removeCoinlistsObject:)
    @NSManaged public func removeFromCoinlists(_ value: Coinlist)

    @objc(addCoinlists:)
    @NSManaged public func addToCoinlists(_ values: NSSet)

    @objc(removeCoinlists:)
    @NSManaged public func removeFromCoinlists(_ values: NSSet)

}
