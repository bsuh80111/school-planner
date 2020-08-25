//
//  ViewController.swift
//  CalendarPersonal
//
//  Created by Brian Suh on 7/16/20.
//  Copyright © 2020 Brian Suh. All rights reserved.
//

import UIKit
import FSCalendar

extension UIViewController {
    func setupToHideKeyboardOnTapOnView()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))

        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}

class CalendarController: UIViewController, eventPasserDelegate {
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var eventTable: UITableView!
    @IBAction func addEvent(_ sender: UIButton) {
    }
    
    var eventManager = EventManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.dataSource = self
        calendar.delegate = self
        eventTable.dataSource = self
        eventTable.delegate = self
        eventTable.register(UINib(nibName: K.tableCellIdentifier, bundle: nil), forCellReuseIdentifier: K.reusableCellIdentifier)
        findEventsWithDate(date: eventManager.getCurrentDate())
    }
    
    func findEventsWithDate(date: Date) {
        let events = eventManager.getAllEvents()
        for e in events {
            let order = Calendar.current.compare(date, to: e.date, toGranularity: .day)
            if(order == .orderedSame) {
                eventManager.addToCurrentEvents(event: e)
            }
        }
    }
    
    func createEvent(event: Event) {
        eventManager.addEvent(event: event)
        eventTable.reloadData()
        calendar.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == K.eventSegueIdentifier) {
            let destination = segue.destination as! CreateEventController
            destination.delegate = self
        }
    }
}

extension CalendarController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        eventManager.clearCurrentEvents()
        findEventsWithDate(date: date)
        eventTable.reloadData()
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        eventManager.clearCurrentEvents()
        eventTable.reloadData()
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let events = eventManager.getAllEvents()
        for e in events {
            if(date == e.date) {
                return 1
            }
        }
        
        return 0
    }
}

extension CalendarController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventManager.numberOfCurrentEvents()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentEvents = eventManager.getCurrentEvents()
        let event = currentEvents[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reusableCellIdentifier, for: indexPath) as! EventTableViewCell
        
        cell.label.text = event.getTitle()
        
        return cell
    }


}

