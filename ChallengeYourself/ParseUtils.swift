//
//  ParseUtils.swift
//  ChallengeYourself
//
//  Created by Radu Stefan on 21/02/2017.
//  Copyright © 2017 Endava. All rights reserved.
//

import Foundation
import SwiftyJSON

class ParseUtils {
    
    class func parseDisciplinesList(disciplines: [AnyObject]) -> [Discipline]{
        let json = JSON(disciplines)
        print("[ParseUtils] JSON: \(json)")
        
        return []
    }
}
