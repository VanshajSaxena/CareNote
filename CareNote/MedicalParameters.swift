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
    /// private(set) keyword is used to make properties publicly redable but privately modifiable.
    private(set) var history: [(value: Any, date: Date)]? // history is an array of a tuple that can hold previous values of a parameter.
    
    init(name: String, initialValue: Any? = nil, unitOfMeasure: String, dateOfMeasurement: Date? = nil) {
        self.name = name
        self.unitOfMeasure = unitOfMeasure
        if let initialValue = initialValue, let dateOfMeasurement = dateOfMeasurement {
            self.history = [(value: initialValue, date: dateOfMeasurement)]
        }else {
            self.history = nil
        }
        
    }
    
    func addValue(_ value: Any, date: Date) {
        if history == nil {
            history = [(value: value, date: date)]
        } else {
            history?.append((value: value, date: date))
        }
    }
    
    func displayHistory(){
        guard let history = history else {
            print("No history available for \(name)")
            return
        }
        print("History of parameter: \(name).")
        for entry in history {
            print("Value: \(entry.value) \(unitOfMeasure), Date: \(entry.date).")
        }
    }
    
    func getValues() -> [Any]? {
        return history?.map { $0.value }
    }

    func getDates() -> [Date]? {
        return history?.map { $0.date }
    }

    /// this private enum helps in customising the encode and decode process as
    /// the compiler do not autogenerate the implementation to encode and decode the class's properties.
    private enum CodingKeys: String, CodingKey {
        case name, unitOfMeasure, history
    }
    
    /// Custom encoding and decoding to handle `Any` type in `history`
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(unitOfMeasure, forKey: .unitOfMeasure)
        
        if let history = history {
            let encodedHistory = history.map { entry in
                ["value": AnyCodable(entry.value), "date": AnyCodable(entry.date)]
            }
            try container.encode(encodedHistory, forKey: .history)
        }
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        unitOfMeasure = try container.decode(String.self, forKey: .unitOfMeasure)

        if let decodedHistory = try container.decodeIfPresent([[String: AnyCodable]].self, forKey: .history){
            history = decodedHistory.map {
                entry in let value = entry["value"]!.value
                let date = entry["date"]!.value as! Date
                return (value, date)
            }
        } else {
            history = nil
        }
    }
    
    /// The AnyCodable struct is a custom type used to allow encoding and decoding of properties with the type Any within Swift's Codable framework.
    /// Swift's Codable protocol does not natively support the Any type because it requires specific type information to encode and decode data.
    /// The AnyCodable struct wraps around Any values and implements the Codable protocol, providing the necessary type information at runtime.
    struct AnyCodable: Codable {
        var value: Any

        init(_ value: Any) {
            self.value = value
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()

            if let intValue = try? container.decode(Int.self) {
                value = intValue
            } else if let doubleValue = try? container.decode(Double.self) {
                value = doubleValue
            } else if let stringValue = try? container.decode(String.self) {
                value = stringValue
            } else if let boolValue = try? container.decode(Bool.self) {
                value = boolValue
            } else if let dateValue = try? container.decode(Date.self) {
                value = dateValue
            } else if let arrayValue = try? container.decode([AnyCodable].self) {
                value = arrayValue.map { $0.value }
            } else if let dictionaryValue = try? container.decode([String: AnyCodable].self) {
                value = dictionaryValue.mapValues { $0.value }
            } else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "The container contains nothing serializable")
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()

            if let intValue = value as? Int {
                try container.encode(intValue)
            } else if let doubleValue = value as? Double {
                try container.encode(doubleValue)
            } else if let stringValue = value as? String {
                try container.encode(stringValue)
            } else if let boolValue = value as? Bool {
                try container.encode(boolValue)
            } else if let dateValue = value as? Date {
                try container.encode(dateValue)
            } else if let arrayValue = value as? [Any] {
                let anyCodableArray = arrayValue.map { AnyCodable($0) }
                try container.encode(anyCodableArray)
            } else if let dictionaryValue = value as? [String: Any] {
                let anyCodableDictionary = dictionaryValue.mapValues { AnyCodable($0) }
                try container.encode(anyCodableDictionary)
            } else {
                throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: container.codingPath, debugDescription: "The value cannot be encoded"))
            }
        }
    }

}
