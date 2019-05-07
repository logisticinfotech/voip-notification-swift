//
//  Notifications+CoreDataProperties.swift
//  VoIPDemo
//
//  Created by Jayesh on 26/01/19.
//  Copyright © 2019 Logistic Infotech Pvt. Ltd. All rights reserved.
//
//

import Foundation
import CoreData


extension Notifications {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notifications> {
        return NSFetchRequest<Notifications>(entityName: "Notifications")
    }

    @NSManaged public var createdTime: NSDate?
    @NSManaged public var payload: NSObject?

}
