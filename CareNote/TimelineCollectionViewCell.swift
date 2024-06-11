//
//  TimelineCollectionViewCell.swift
//  CareNote
//
//  Created by Batch-2 on 07/06/24.
//

import UIKit

class TimelineCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var timelineMonthLabel: UILabel!
    @IBOutlet var timelineDateLabel: UILabel!
    @IBOutlet var timelineVisitToDoctorLabel: UILabel!
    @IBOutlet var timelineDescriptionLabel: UILabel!
    @IBOutlet var timelineNotesLabel: UILabel!
    @IBOutlet var timelineNextAppointmentLabel: UILabel!
    @IBOutlet var timelineNextAppointmentDateLabel: UILabel!
    @IBOutlet var timelineDateView: UIView!
    @IBOutlet var consultationview: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        makeCircular(view: timelineDateView)
        
    }
    
    func makeCircular(view: UIView) {
        let radius = min(view.frame.width, view.frame.height) / 2
        view.layer.cornerRadius = radius
        view.clipsToBounds = true
    }
    
    func configureCell(date: String, month: String, title: String, description: String, notes: String, nextAppointmentDate: String) {
        self.timelineMonthLabel.text = month
        self.timelineDateLabel.text = date
        self.timelineVisitToDoctorLabel.text = "Visit to \(title)"
        self.timelineDescriptionLabel.text = description
        self.timelineNotesLabel.text = notes
        self.timelineNextAppointmentDateLabel.text = nextAppointmentDate
    }
    
    var onConsultationPressed: ((UIViewController) -> Void)?
    
    @IBAction func consultationChevronPressed(_ sender: UIButton) {
        // Get a reference to the storyboard
        let storyboard = UIStoryboard(name: "HealthLogStoryboard", bundle: nil)
        
        // Instantiate the view controller from the storyboard
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "ConsultationViewController")
        // Present the view controller (choose your preferred presentation style)
//        self.navigationController?.pushViewController(secondViewController, animated: true)
        
        // Call the closure if set, passing the view controller
            onConsultationPressed?(secondViewController)
        }
    
//    @objc private func consultationview() {
//        var responder: UIResponder? = self
//        while let nextResponder = responder?.next {
//            if let viewController = nextResponder as? UIViewController {
//                let storyboard = UIStoryboard(name: "HealthLogStoryboard", bundle: nil)
//                if let currentVitalsVC = storyboard.instantiateViewController(withIdentifier: "ConsultationViewController") as? CurrentVitalsSegmentedViewController {
//                    viewController.navigationController?.pushViewController(currentVitalsVC, animated: true)
//                    return
//                }
//            }
//            responder = nextResponder
//        }
//    }
    
    
}
