//
//  CreateEventController.swift
//  CalendarPersonal
//
//  Created by Brian Suh on 8/23/20.
//  Copyright © 2020 Brian Suh. All rights reserved.
//

import UIKit

protocol eventPasserDelegate {
    func createEvent(event: Event)
}

class CreateEventController: UIViewController {
    
    var delegate: eventPasserDelegate?
    
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var infoTextField: UITextField!
    @IBOutlet weak var dateSelector: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        eventNameTextField.text = ""
        eventNameTextField.delegate = self
        infoTextField.delegate = self
        self.setupToHideKeyboardOnTapOnView()
    }
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addEventPressed(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = K.dateFormatterString
        let dateString = dateFormatter.string(from: dateSelector.date)
        if let text = eventNameTextField.text, let info = infoTextField.text, let d = delegate {
            if text != "" {
                let event = Event(title: text, date: dateString, info: info)
                d.createEvent(event: event)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension CreateEventController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
