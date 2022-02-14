//
//  User+CoreDataProperties.swift
//  SwiftUI_Day3_1
//
//  Created by DauTT1 on 1/10/22.
//  Copyright © 2022 gammad. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var fullName: String?

}
