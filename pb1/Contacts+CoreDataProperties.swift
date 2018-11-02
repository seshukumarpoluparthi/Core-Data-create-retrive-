//
//  Contacts+CoreDataProperties.swift
//  pb1
//
//  Created by apple on 11/2/18.
//  Copyright © 2018 apple. All rights reserved.
//
//

import Foundation
import CoreData


extension Contacts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contacts> {
        return NSFetchRequest<Contacts>(entityName: "Contacts")
    }

    @NSManaged public var personName: String?
    @NSManaged public var personNumber: String?

}
