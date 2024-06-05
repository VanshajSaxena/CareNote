import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    let headerLabel = UILabel()
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
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        iconButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(headerLabel)
        addSubview(iconButton)
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: iconButton.leadingAnchor, constant: -16),
            headerLabel.topAnchor.constraint(equalTo: self.topAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            iconButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            iconButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconButton.widthAnchor.constraint(equalToConstant: 30),
            iconButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 13, weight: .black)
        let chevronImage = UIImage(systemName: "chevron.right", withConfiguration: configuration)
        iconButton.setImage(chevronImage, for: .normal)
        iconButton.tintColor = UIColor.systemGray
    
        headerLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        iconButton.addTarget(self, action: #selector(iconButtonTapped), for: .touchUpInside)
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
