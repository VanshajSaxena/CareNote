//
//  MedicalParameters.swift
//  CareNote
//
//  Created by Batch-2 on 31/05/24.
//

import Foundation

// This class represents an abstract MedicalParameter that can be used to create more specific
// medical parameters like, bloodPressureSystolic, bloodSugar, eGFR, etc.
class MedicalParameter {
    var name: String
    var unitOfMeasure: String
    // private(set) keyword is used to make properties publicly redable but privately modifiable.
    private(set) var history: [(value: Any, date: Date)]? // history is an array of a tuple that can hold previous values of a parameter.
    
    init(name: String, unitOfMeasure: String, history: [(value: Any, date: Date)]? = nil) {
        self.name = name
        self.unitOfMeasure = unitOfMeasure
        self.history = history
        
    }
    
    func addValue(_ value: Any, date: Date) {
        history?.append((value: value, date: date))
    }
    
    func displayHistory(){
        print("History of parameter: \(name).")
        if let historyExists = history {
            for entry in historyExists {
                print("Value: \(entry.value) \(unitOfMeasure), Date: \(entry.date).")
            }
        }
    }
    
    func getValues() -> [Any]? {
        return history?.map { $0.value }
    }

    func getDates() -> [Date]? {
        return history?.map { $0.date }
    }
    
    
}




