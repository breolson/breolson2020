//
//  Article+CoreDataClass.swift
//  Pods
//
//  Created by Ivan Levin on 04/12/20.
//
//

import Foundation
import CoreData

extension Article {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var content: String?
    @NSManaged public var dateOfCreation: NSDate?
    @NSManaged public var dateOfModification: NSDate?
    @NSManaged public var image: NSData?
    @NSManaged public var language: String?
    @NSManaged public var title: String?
    
    override public var description: String {
        return ("title: \(String(describing: title ?? ""))\ncontent: \(String(describing: content ?? ""))\nlanguage: \(String(describing: language ?? ""))\ndate of creation: \(String(describing: dateOfCreation ?? Date() as NSDate))\ndate of modification: \(String(describing: dateOfModification ?? Date() as NSDate))\nimage: \(String(describing: image ?? nil))\n\n")
    }
}
