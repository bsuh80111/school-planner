//
//  EventManager.swift
//  CalendarPersonal
//
//  Created by Brian Suh on 8/23/20.
//  Copyright © 2020 Brian Suh. All rights reserved.
//

import Foundation

struct EventManager {
    
    var events = [Event(title: "Event 1", date: "2020-08-11", info: "")]
    var currentDate = Date()
    var currentEvents: [Event] = []
    
    func getAllEvents() -> [Event] {
        return self.events
    }
    
    mutating func addEvent(event: Event) {
        events.append(event)
    }
    
    func getCurrentDate() -> Date {
        return self.currentDate
    }
    
    func getCurrentEvents() -> [Event] {
        return self.currentEvents
    }
    
    mutating func addToCurrentEvents(event: Event) {
        currentEvents.append(event)
    }
    
    mutating func clearCurrentEvents() {
        currentEvents = []
    }
    
    func numberOfCurrentEvents() -> Int {
        return currentEvents.count
    }
}
