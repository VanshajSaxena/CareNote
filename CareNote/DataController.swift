//
//  DataController.swift
//  CareNote
//
//  Created by Batch-2 on 30/05/24.
//

import Foundation

class DataController {

    private var user: User?
    private var doctors: [Doctor] = []
    private var consultations: [Consultation] = []
    private var medicalParameters : [MedicalParameter] = []
    private var medicines: [Medicine] = []

    private var _parametersDict = ["Blood Pressure": "mmHg", "Blood Sugar": "mg/dL", "Heart Rate": "bpm", "eGFR": "mL/min", "Creatinine": "mg/dL"]

    static let shared = DataController()

    init(user: User? = nil, doctors: [Doctor]? = nil, consultations: [Consultation]? = nil, medicines: [Medicine]? = nil) {
        self.user = user
        self.doctors = doctors ?? []
        self.consultations = consultations ?? []
        self.medicines = medicines ?? [] // this makes medicines array always available for appending.
        self.medicalParameters = _parametersDict.map {MedicalParameter(name: $0.key, unitOfMeasure: $0.value)}
    }

    // MARK: - User Methods
    func getUser() -> User? {
        return user
    }

    func setUser(newUser: User) {
        user = newUser
    }

    // MARK: - Doctor Methods
    func getDoctor(name: String) -> Doctor? {
        guard let doctor = doctors.first(where: {$0.name == name}) else { return nil }
        return doctor
    }

    func getDoctors() -> [Doctor] {
        return doctors
    }

    func addDoctor(name: String, speciality: String? = nil, contactNumber: Int? = nil) {
        let newDoctor = Doctor(id: UUID(), name: name, speciality: speciality, contactNumber: contactNumber)
        doctors.append(newDoctor)
    }

    func updateDoctor(id: UUID, name: String? = nil, speciality: String? = nil, contactNumber: Int? = nil){
        if let index = doctors.firstIndex(where: {$0.id == id}) {
            if let name = name {
                doctors[index].name = name
            }
            if let speciality = speciality {
                doctors[index].speciality = speciality
            }
            if let contactNumber = contactNumber {
                doctors[index].contactNumber = contactNumber
            }
        }
    }

    func removeDoctor(id: UUID) {
        doctors.removeAll(where: { $0.id == id })
    }

    // MARK: - Consultation Methods
    func getMostRecentConsultation() -> Consultation? {
        return consultations.first
    }

    func getConsultations() -> [Consultation] {
        return consultations
    }

    func addConsultation(title: String, dateOfConsultation: Date, user: User, doctor: Doctor, consultationDocuments: [ConsultationDocument]? = nil){
        let newConsultation = Consultation(id: UUID(), dateOfConsultation: dateOfConsultation, title: title, user: user, doctor: doctor, consultationDocuments: consultationDocuments)
        consultations.append(newConsultation)
    }

    func updateConsultation(id: UUID, newConsultation: Consultation) {
        if let index = consultations.firstIndex(where: { $0.id == id }) {
            consultations[index] = newConsultation
        }
    }

    func removeConsultation(id: UUID) {
        consultations.removeAll { $0.id == id }
    }

    // MARK: - Medical Parameter Methods
    func getMedicalParameter(name: String) -> MedicalParameter? {
        return medicalParameters.first { $0.getName() == name }
    }

    func getMedicalParameters() -> [MedicalParameter] {
        return medicalParameters
    }

    func addMedicalParameter(name: String, unitOfMeasure: String) {
        let newMedicalParameter = MedicalParameter(name: name, unitOfMeasure: unitOfMeasure)
        medicalParameters.append(newMedicalParameter)
    }

    func recordMedicalParameter(name: String, value: Double, date: Date = Date()) {
        guard let parameter = getMedicalParameter(name: name) else {
            print("Medical parameter \(name) does not exists")
            return
        }
        parameter.addHistoryEntry(value, date: date)
    }

    func removeMedicalParameter(name: String) {
        medicalParameters.removeAll { $0.getName() == name }
    }

    // MARK: - Medicine Methods
    func getMedicines() -> [Medicine] {
        return medicines
    }

    func getMedicine(name: String) -> Medicine? {
        return medicines.first {$0.name == name}
    }

    func addMedicine(newMedicine: Medicine){
        medicines.append(newMedicine)
    }

    func removeMedicine(id: UUID){
        medicines.removeAll { $0.id == id }
    }

    func getRecentParameterValues(name: String, count: Int = 5) -> [String] {
        guard let parameter = getMedicalParameter(name: name) else {
            print("Parameter list is empty")
            return []
        }
        return Array(parameter.history.suffix(count).map{ $0.value.formatted() })
    }

    func getUnitOfParameter(parameterName parameter: String) -> String {
        guard let parameter = _parametersDict[parameter] else {
            print("\(parameter) does not exists")
            return ""
        }
        return parameter
    }

    // MARK: - Persistence Methods

    func saveData() {
        let encoder = JSONEncoder()

        do {
            if let user = user {
                let userData = try encoder.encode(user)
                saveToFile(data: userData, fileName: "user.json")
            }

            let doctorsData = try encoder.encode(doctors)
            saveToFile(data: doctorsData, fileName: "doctors.json")

            let consultationsData = try encoder.encode(consultations)
            saveToFile(data: consultationsData, fileName: "consultations.json")

            let medicinesData = try encoder.encode(medicines)
            saveToFile(data: medicinesData, fileName: "medicines.json")

            let medicalParametersData = try encoder.encode(medicalParameters)
            saveToFile(data: medicalParametersData, fileName: "medicalParameters.json")

        } catch let error {
            print("Failed to encode data: \(error.localizedDescription)")
        }
    }

    func loadData() {
        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .iso8601

        if let userData = loadFromFile(fileName: "user.json") {
            do {
                user = try decoder.decode(User.self, from: userData)
            } catch let error {
                print("Failed to decode user data: \(error.localizedDescription)")
            }
        }

        if let doctorsData = loadFromFile(fileName: "doctors.json") {
            do {
                doctors = try decoder.decode([Doctor].self, from: doctorsData)
            } catch let error {
                print("Failed to decode doctors data: \(error.localizedDescription)")
            }
        }

        if let consultationsData = loadFromFile(fileName: "consultations.json") {
            do {
                consultations = try decoder.decode([Consultation].self, from: consultationsData)
            } catch let error {
                print("Failed to decode consultations data: \(error.localizedDescription)")
            }
        }

        if let medicinesData = loadFromFile(fileName: "medicines.json") {
            do {
                medicines = try decoder.decode([Medicine].self, from: medicinesData)
            } catch let error {
                print("Failed to decode consultations data: \(error.localizedDescription)")
            }
        }

        if let medicalParametersData = loadFromFile(fileName: "medicalParameters.json") {
            do {
                medicalParameters = try decoder.decode([MedicalParameter].self, from: medicalParametersData)
            } catch let error {
                print("Failed to decode medical parameters data: \(error.localizedDescription)")
            }
        }
    }

    private func saveToFile(data: Data, fileName: String) {
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)

        do {
            try data.write(to: fileURL)
            print("Data successfully saved to \(fileURL)")
        } catch let error {
            print("Failed to save data to file: \(fileURL): \(error.localizedDescription)")
        }
    }

    private func loadFromFile(fileName: String) -> Data? {
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)

        do {
            let data = try Data(contentsOf: fileURL)
            print("Data successfully loaded from \(fileURL)")
            return data
        } catch let error {
            print("Failed to load data from file: \(fileURL): \(error.localizedDescription)")
            return nil
        }
    }

    private func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

}
