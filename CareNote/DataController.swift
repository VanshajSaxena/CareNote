//
//  DataController.swift
//  CareNote
//
//  Created by Batch-2 on 30/05/24.
//

import Foundation

class DataController {

    private var user: User?
    private var doctors: [Doctor]?
    private var consultations: [Consultation]?
    private var _parametersDict = ["Blood Pressure": "mmHg", "Blood Sugar": "mg/dL", "Heart Rate": "bpm", "eGFR": "mL/min", "Creatinine": "mg/dL"]
    
    var medicines: [Medicine] = []
    var medicalParameters : [MedicalParameter] = []
    
    static let shared = DataController()
    
    init(user: User? = nil, doctors: [Doctor]? = nil, consultations: [Consultation]? = nil, medicines: [Medicine]? = nil) {
        self.user = user
        self.doctors = doctors
        self.consultations = consultations
        self.medicines = medicines ?? [] // this makes medicines array always available for appending.

        for (param, unit) in _parametersDict {
            let medicalParameter = MedicalParameter(name: param, unitOfMeasure: unit)
            medicalParameters.append(medicalParameter)
        }
    }

    func getMedicalParameter(name: String) -> MedicalParameter? {
        return medicalParameters.first { $0.name == name }
    }

    func getDoctor(name: String) -> Doctor? {
        return doctors?.first { $0.name == name }
    }

    func getMedicine(name: String) -> Medicine? {
        return medicines.first {$0.name == name}
    }

    // MARK: - Persistence Methods

    func saveData() {
        let encoder = JSONEncoder()

        do {
            if let user = user {
                let userData = try encoder.encode(user)
                saveToFile(data: userData, fileName: "user.json")
            }

            if let doctors = doctors {
                let doctorsData = try encoder.encode(doctors)
                saveToFile(data: doctorsData, fileName: "doctors.json")
            }

            if let consultations = consultations {
                let consultationsData = try encoder.encode(consultations)
                saveToFile(data: consultationsData, fileName: "consultations.json")
            }

            let medicinesData = try encoder.encode(medicines)
            saveToFile(data: medicinesData, fileName: "medicines.json")

            let medicalParametersData = try encoder.encode(medicalParameters)
            saveToFile(data: medicalParametersData, fileName: "medicalParameters.json")

        } catch {
            print("Failed to encode data: \(error)")
        }
    }

    func loadData() {
        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .iso8601

        if let userData = loadFromFile(fileName: "user.json") {
            do {
                user = try decoder.decode(User.self, from: userData)
            } catch {
                print("Failed to decode user data: \(error)")
            }
        }

        if let doctorsData = loadFromFile(fileName: "doctors.json") {
            do {
                doctors = try decoder.decode([Doctor].self, from: doctorsData)
            } catch {
                print("Failed to decode doctors data: \(error)")
            }
        }

        if let consultationsData = loadFromFile(fileName: "consultations.json") {
            do {
                consultations = try decoder.decode([Consultation].self, from: consultationsData)
            } catch {
                print("Failed to decode consultations data: \(error)")
            }
        }

        if let medicinesData = loadFromFile(fileName: "medicines.json") {
            do {
                medicines = try decoder.decode([Medicine].self, from: medicinesData)
            } catch {
                print("Failed to decode consultations data: \(error)")
            }
        }

        if let medicalParametersData = loadFromFile(fileName: "medicalParameters.json") {
            do {
                medicalParameters = try decoder.decode([MedicalParameter].self, from: medicalParametersData)
            } catch {
                print("Failed to decode medical parameters data: \(error)")
            }
        }
    }

    private func saveToFile(data: Data, fileName: String) {
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)

        do {
            try data.write(to: fileURL)
            print("Data successfully saved to \(fileURL)")
        } catch {
            print("Failed to save data to file: \(error)")
        }
    }

    private func loadFromFile(fileName: String) -> Data? {
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)

        do {
            let data = try Data(contentsOf: fileURL)
            print("Data successfully loaded from \(fileURL)")
            return data
        } catch {
            print("Failed to load data from file: \(error)")
            return nil


        }
    }

    private func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

}
