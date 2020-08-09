//
// Created by Jamil Nawaz on 09/08/2020.
// Copyright (c) 2020 Jamil Nawaz. All rights reserved.
//

import Foundation
import CoreData

class DetailPresenter: NSObject {
    weak var viewDelegate: DetailViewDelegate?
    var managedObjectContext: NSManagedObjectContext?
    
    init(viewDelegate: DetailViewDelegate,
         managedObjectContext: NSManagedObjectContext) {
        super.init()
        self.viewDelegate = viewDelegate
        self.managedObjectContext = managedObjectContext
    }
}