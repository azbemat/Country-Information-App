//
//  Favourite+CoreDataProperties.swift
//  FinalTest_Anas
//
//  Created by user215592 on 4/21/22.
//
//

import Foundation
import CoreData


extension Favourite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favourite> {
        return NSFetchRequest<Favourite>(entityName: "Favourite")
    }

    @NSManaged public var name: String?
    @NSManaged public var population: Int32

}

extension Favourite : Identifiable {

}
