//
//  MedicalParameter.swift
//  CareNote
//
//  Created by Batch-2 on 05/06/24.
//
import UIKit
import Vision
import VisionKit

var DoctorName : String = ""
var DateVisit : String = ""
var MedicineName : String = ""
var Diago : String = ""

var docParameters: [docParameter] = []
struct docParameter: CustomStringConvertible {
    var name: String
    var value: Float
    
    var description: String {
        "\(name) \(value)"
    }
}

var Nextappoint : String = ""

// MARK: - Struct and Enums

private struct TextInImage: Comparable, CustomStringConvertible {
    var xPosition: Int
    var yPosition: Int
    var text: String
    
    var description: String {
        return "X: \(xPosition) Y: \(yPosition) Text: \(text)"
    }
    
    static func < (lhs: TextInImage, rhs: TextInImage) -> Bool {
        lhs.yPosition > rhs.yPosition
    }
    
}

// MARK: - Global Variables

private let parameterListSplitted = ["Packed", "Cell", "Volume", "Mean", "Corpuscular", "Volume"]
private var parametersInImage: [TextInImage] = []
private var textsInImage: [TextInImage] = []
private var ySortedTextsInImage: [TextInImage] = []

// MARK: - Functions

func getText(from image: UIImage) {
    guard let cgImage = image.cgImage else { return }
    
    let requestHandler = VNImageRequestHandler(cgImage: cgImage)
    let request = VNRecognizeTextRequest { request, error in
        if let error = error {
            print("Error recognizing text: \(error)")
            return
        }
        guard let observations = request.results as? [VNRecognizedTextObservation] else {
            print("No text found")
            return
        }
        processObservations(observations, in: image)
    }
    
    do {
        try requestHandler.perform([request])
    } catch {
        print("Error performing text recognition: \(error)")
    }
}
    
private func processObservations(_ observations: [VNRecognizedTextObservation],in image: UIImage){
    
    var boundingBoxes: [CGRect] = []
    var recognizedStrings: [String?] = []
    
    for observation in observations {
        let normalizedBoundingBox = observation.boundingBox
        let boundingBox = VNImageRectForNormalizedRect(normalizedBoundingBox, Int(image.size.width), Int(image.size.height))
        boundingBoxes.append(boundingBox)
        recognizedStrings.append(observation.topCandidates(1).first?.string)
    }
    
    for i in 0..<boundingBoxes.count {
        textsInImage.append(TextInImage(xPosition: Int(boundingBoxes[i].origin.x), yPosition: Int(boundingBoxes[i].origin.y), text: recognizedStrings[i]!))
        /*
        print("Box \(i)")
        print(boundingBoxes[i])
        print(boundingBoxes[i].origin.y)
        print(recognizedStrings[i]!)
        */
    }
    
    ySortedTextsInImage = textsInImage.sorted()
    /*
    for i in ySortedTextsInImage {
        print(i)
    }
    */
    if documentTypeSelected == "Doctor Visit" {
        print("Doc selected")
        doctorVisitScan()
        
    }
    else if documentTypeSelected == "Lab Report" {
        print("Lab Report")
        findParameter()
    }
    else{
        print("Document type Not Selected")
    }
    
    //findParameter()
}

var subTexts : String = ""
var count = 0
func doctorVisitScan() {
    for i in textsInImage {
        subTexts = i.text
        count = count + 1
        print("\(count) + \(subTexts)")// by sameer

        /*
        if let value = dictionary[subTexts] {
        parametersInImage.append(i)
        } else if parameterListSplitted.contains(String(subTexts).lowercased()) {
        parametersInImage.append(i)
        break
        }
        */
         
        if let doctorName = detectStringStartingWith(subTexts, phrase: "Dr."  ){
            DoctorName = doctorName
            print(doctorName)
        }

        if let date = detectStringStartingWith(subTexts, phrase: "Date:"){
            DateVisit = date
            print(date)
        }
        if let medcineName = detectStringStartingWith(subTexts, phrase: "TAB."){
            MedicineName = medcineName
            print(medcineName)
        }
        
        
        if let diago = detectStringStartingWith(i.text, phrase: "Diagnosis:"){
            let nextpart = count
            Diago = textsInImage[nextpart].text
            print(Diago)
        }
        if let nextappointmentdate = detectStringStartingWith(i.text, phrase: "Follow Up:"){
            
            Nextappoint = nextappointmentdate
            print(nextappointmentdate)
        }

    }
    print("\n\n\n")
    doctorVisitValue()
}

private func findParameter() {
    for i in textsInImage {
        let subTexts = i.text
        //print(subTexts)
        if let score = dictionary[subTexts] {
            print(score)
            parametersInImage.append(i)
        } else if parameterListSplitted.contains(String(subTexts).lowercased()) {
            parametersInImage.append(i)
            break
        }
        
    }
    print("\n\n\n")
    for parameter in parametersInImage {
        print(parameter)
    }
    findParameterValue()
}

//Doctor Visit Saving Function calling
func doctorVisitValue() {
    for parameter in parametersInImage {
        for i in textsInImage {
            if abs(parameter.yPosition - i.yPosition) <= 10 && parameter.text != i.text {
                if let value = Float(i.text) {
                    docParameters.append(docParameter(name: parameter.text, value: value))
                }
            }
        }
    }
    
    print("\n\n\n")
    for parameter in docParameters {
        print(parameter)
    }
}

private func findParameterValue() {
    for parameter in parametersInImage {
        for i in textsInImage {
            if abs(parameter.yPosition - i.yPosition) <= 10 && parameter.text != i.text {
                if let value = Double(i.text) {
                    dataController.recordNewMedicalParameter(name: dictionary[parameter.text]!, value: value, date: Date())
                }
            }
        }
    }
    print("\n\n\n")
    for parameter in dataController.getMedicalParameters() {
        print(parameter.getRecentValue())
    }
}

// MARK: - CSV Functions

func copyCSVToDocuments(fileName: String) {
    let fileManager = FileManager.default
    
    if let bundlePath = Bundle.main.path(forResource: fileName, ofType: "csv") {
        print("File found in bundle at path: \(bundlePath)")
        let documentsPath = getDocumentsDirectory().appendingPathComponent("\(fileName).csv")
        
        if !fileManager.fileExists(atPath: documentsPath.path) {
            do {
                try fileManager.copyItem(atPath: bundlePath, toPath: documentsPath.path)
                print("CSV file copied to documents directory")
            } catch {
                print("Error copying file: \(error.localizedDescription)")
            }
        } else {
            print("CSV file already exists in documents directory")
        }
    } else {
        print("CSV file not found in bundle")
    }
}

// Function to get the path to the Documents directory
func getDocumentsDirectory() -> URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
}

// Function to read the content of the CSV file from the Documents directory
func readCSV(fileName: String) -> String? {
    let filePath = getDocumentsDirectory().appendingPathComponent("\(fileName).csv")
    do {
        let contents = try String(contentsOf: filePath, encoding: .utf8)
        return contents
    } catch {
        print("Failed to read the CSV file: \(error.localizedDescription)")
        return nil
    }
}

var dictionary: [String: String] = [:]
// Function to convert CSV content to a dictionary
func csvToDictionary(csvContent: String) -> [String: String] {
   
    let lines = csvContent.components(separatedBy: .newlines)
    
    for line in lines {
        let columns = line.components(separatedBy: ",")
        if columns.count == 2 {
            let key = columns[0].trimmingCharacters(in: .whitespacesAndNewlines)
            let value = columns[1].trimmingCharacters(in: .whitespacesAndNewlines)
            if !key.isEmpty && !value.isEmpty {
                dictionary[key] = value
            }
        }
    }
    return dictionary
}

func detectStringStartingWith(_ string: String, phrase: String) -> String? {
            let phraseWords = phrase.lowercased().split(separator: " ")
            let stringWords = string.lowercased().split(separator: " ")
            return stringWords.starts(with: phraseWords) ? string : nil
        }
// Function to read CSV and convert to dictionary, then print it
func processCSVFile() {
    if let csvContent = readCSV(fileName: "ParametersCSV") {
        let dictionary = csvToDictionary(csvContent: csvContent)
        print(dictionary)
    }
}
