//
//  CheckIn.swift
//  BasicLocation
//
//  Created by jeffrey lullen on 5/12/26.
//

import Foundation
import Combine

struct CheckIn: Identifiable{
    let id:UUID
    let latitude: Double
    let longitude:Double
    let timeStamp:Date
    
    init(latitude: Double, longitude: Double, timeStamp: Date){
        
        self.id = UUID()
        self.latitude = latitude
        self.longitude = longitude
        self.timeStamp = timeStamp
    }
}
