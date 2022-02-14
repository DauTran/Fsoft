//
//  Category+CoreDataProperties.swift
//  
//
//  Created by DauTT1 on 1/14/22.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var descriptionCategory: String?
    @NSManaged public var idCategory: String?

}
