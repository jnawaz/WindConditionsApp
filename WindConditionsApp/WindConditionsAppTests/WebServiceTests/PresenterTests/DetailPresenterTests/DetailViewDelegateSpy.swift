//
// Created by Jamil Nawaz on 09/08/2020.
// Copyright (c) 2020 Jamil Nawaz. All rights reserved.
//

import Foundation
@testable import WindConditionsApp

class DetailViewDelegateSpy: DetailViewDelegate {
    var failToSave = false
    var successfullySave = false

    
    func failedToSave() {
        failToSave = true
    }
    
    func successfullySaved() {
        successfullySave = true
    }

}
