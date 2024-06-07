import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    let headerLabel = UILabel()
    let subtitleLabel = UILabel()  // Add a subtitle label
    let iconButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeader()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHeader()
    }
    
    private func setupHeader() {
        // Configure the headerLabel
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)

        // Configure the subtitleLabel
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        subtitleLabel.textColor = UIColor.systemGray

        // Configure the iconButton
        iconButton.translatesAutoresizingMaskIntoConstraints = false
        let configuration = UIImage.SymbolConfiguration(pointSize: 13, weight: .black)
        let chevronImage = UIImage(systemName: "chevron.right", withConfiguration: configuration)
        iconButton.setImage(chevronImage, for: .normal)
        iconButton.tintColor = UIColor.systemGray
        iconButton.addTarget(self, action: #selector(iconButtonTapped), for: .touchUpInside)
        
        // Add subviews to the collection reusable view
        addSubview(headerLabel)
        addSubview(subtitleLabel)
        addSubview(iconButton)
        
        // Constraints for headerLabel
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: iconButton.leadingAnchor, constant: -16),
            headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant:  4),
        ])

        // Constraints for subtitleLabel
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            subtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            subtitleLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 4),
            subtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        // Constraints for iconButton
        NSLayoutConstraint.activate([
            iconButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            iconButton.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            iconButton.widthAnchor.constraint(equalToConstant: 30),
            iconButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc private func iconButtonTapped() {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            if let viewController = nextResponder as? UIViewController {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let currentVitalsVC = storyboard.instantiateViewController(withIdentifier: "CurrentVitalsSegmentedViewController") as? CurrentVitalsSegmentedViewController {
                    viewController.navigationController?.pushViewController(currentVitalsVC, animated: true)
                    return
                }
            }
            responder = nextResponder
        }
    }
}
