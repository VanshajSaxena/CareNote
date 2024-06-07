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
    
}
