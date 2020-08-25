//
//  Event.swift
//  CalendarPersonal
//
//  Created by Brian Suh on 8/21/20.
//  Copyright © 2020 Brian Suh. All rights reserved.
//

import Foundation

struct Event {
    let title: String
    let date: Date
    let info: String
    let formatter = DateFormatter()
   
    
    init(title: String, date: String, info: String) {
        self.title = title
        self.info = info
        formatter.dateFormat = "yyyy-MM-dd"
        
        self.date = formatter.date(from: date)!
    }
    
    func getTitle() -> String {
        return self.title
    }
    
    
}
