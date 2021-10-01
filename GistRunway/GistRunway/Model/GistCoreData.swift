//
//  GistCoreData.swift
//  GistRunway
//
//  Created by Kauê Sales on 30/09/21.
//

import CoreData

@objc(GistsCoreData)
class GistsCoreData: NSManagedObject {
    @NSManaged var id: UUID!
    @NSManaged var ownerName: String!
    @NSManaged var desc: String
    @NSManaged var image: Data!
}
