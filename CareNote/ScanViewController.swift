//
//  ScanViewController.swift
//  CareNote
//
//  Created by Batch-2 on 06/06/24.
//

import UIKit
import Vision
import VisionKit

struct TextInImage: Comparable, CustomStringConvertible {
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


let parameterList = ["Hemoglobin", "RBC", "Packed Cell Volume", "Mean Corpuscular Volume", "MCH", "MCHC", "RDW", "WBC", "Neutrophils", "lymphocyte", "eosinophil", "monocyte", "basophil", "platelet"]
let parameterListSplitted = ["Packed", "Cell", "Volume", "Mean", "Corpuscular", "Volume"]

struct Parameter: CustomStringConvertible {
    var name: String
    var value: Float
    
    var description: String {
        "\(name) \(value)"
    }
}

var parametersInImage: [TextInImage] = []
var textsInImage: [TextInImage] = []
var ySortedTextsInImage: [TextInImage] = []

var parameters: [Parameter] = []

var neighbours: [TextInImage] = []



class ScanViewController: UIViewController {

    
    
    @IBOutlet var imageView: UIImageView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        copyCSVToDocuments(fileName: "ParametersCSV")
        processCSVFile()
        guard let image = UIImage(named: "image3") else { return }
        imageView.image = image
        getText(from: image )
    }

    func getText(from image: UIImage) {
        guard let cgImage = image.cgImage else { return }
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)
        
        let request = VNRecognizeTextRequest()
        
        //request.recognitionLevel = .accurate
        
        do {
            try requestHandler.perform([request])
        } catch {
            print("Error")
        }
        
        guard let observations = request.results as? [VNRecognizedTextObservation] else {
            return
        }
        
        var boundingBoxes: [CGRect] = []
        var recognizedStrings: [String?] = []
        
        for observation in observations {
            let normalizedBoundingBox = observation.boundingBox
            let boundingBox = VNImageRectForNormalizedRect(normalizedBoundingBox, Int(image.size.width), Int(image.size.height))
            boundingBoxes.append(boundingBox)
            recognizedStrings.append(observation.topCandidates(1).first?.string)
        }
        
//        let recognizedStrings = observations.compactMap { observation in return observation.topCandidates(1).first?.string
//        }
        
        for i in 0..<boundingBoxes.count {
            textsInImage.append(TextInImage(xPosition: Int(boundingBoxes[i].origin.x), yPosition: Int(boundingBoxes[i].origin.y), text: recognizedStrings[i]!))
            print("Box \(i)")
            print(boundingBoxes[i])
            print(boundingBoxes[i].origin.y)
            print(recognizedStrings[i]!)
        }
       
        ySortedTextsInImage = textsInImage.sorted()
        
        for i in ySortedTextsInImage {
            print(i)
        }
      
        findParameter()

    }
    
    func findParameter() {
        for i in textsInImage {
            let subTexts = i.text
           print(subTexts)
                if let score = dictionary[subTexts] {
                    parametersInImage.append(i)
                    print(score)
                } else if parameterListSplitted.contains(String(subTexts).lowercased()) {
                    parametersInImage.append(i)
                    break
                }
            
        }
        print("\n\n\n")
        for parameter in parametersInImage {
            print(parameter)
//            print(dictionary)
        }
        findParameterValue()
    }
                                      
    func findParameterValue() {
        for parameter in parametersInImage {
            for i in textsInImage {
                if abs(parameter.yPosition - i.yPosition) <= 10 && parameter.text != i.text {
                    if let value = Float(i.text) {
                        parameters.append(Parameter(name: parameter.text, value: value))
                    }
                }
            }
        }
        
        print("\n\n\n")
        for parameter in parameters {
            print(parameter)
        }
    }
                                      
                                      
                                      
    
}
