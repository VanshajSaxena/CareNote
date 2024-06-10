import UIKit


class OnboardingViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var startButton: UIButton!
    
    var pageViewController: UIPageViewController!
    var images: [UIImage] = [
        UIImage(named: "pg1")!,
        UIImage(named: "pg2")!,
        UIImage(named: "pg3")!
    ]
    var texts: [String] = [
        "Scan medical records, access them at one place.",
        "Get health analysis and insights from your reports.",
        "Explore the timeline of your medical journey, add events and more."
    ]
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup PageViewController
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        if let startingViewController = viewControllerAtIndex(index: 0) {
            let viewControllers = [startingViewController]
            pageViewController.setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)
        }
        
        addChild(pageViewController)
        containerView.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        // Constrain the pageViewController's view to the containerView
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            pageViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        // Setup PageControl
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor(red: 0.0, green: 0.0, blue: 0.545, alpha: 0.5) // Translucent dark blue
        pageControl.currentPageIndicatorTintColor = UIColor(red: 0.0, green: 0.0, blue: 0.545, alpha: 1.0) // Solid dark blue
        pageControl.addTarget(self, action: #selector(pageControlChanged(_:)), for: .valueChanged)
        
        // Adding gradient background
        addGradientBackground()
        
        // Hide the get started button initially
        startButton.isHidden = true
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        // Dismiss the onboarding view controller
//        self.dismiss(animated: true, completion: nil)
    }
    
    func addGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        
        let colour1 = UIColor(red: 0.4, green: 1.0, blue: 1.0, alpha: 1.0)
        let colour2 = UIColor(red: 0.4, green: 0.8, blue: 1.0, alpha: 1.0)
        
        gradientLayer.colors = [colour1.cgColor, colour2.cgColor]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @objc func pageControlChanged(_ sender: UIPageControl) {
        let index = sender.currentPage
        let direction: UIPageViewController.NavigationDirection = index > currentIndex ? .forward : .reverse
        currentIndex = index
        if let viewController = viewControllerAtIndex(index: index) {
            pageViewController.setViewControllers([viewController], direction: direction, animated: true, completion: nil)
        }
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController? {
        if index >= images.count || index < 0 {
            return nil
        }
        
        let contentViewController = storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        contentViewController.image = images[index]
        contentViewController.text = texts[index]
        contentViewController.pageIndex = index
        
        return contentViewController
    }
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? ContentViewController else {
            return nil
        }
        var index = viewController.pageIndex
        index -= 1
        return viewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? ContentViewController else {
            return nil
        }
        var index = viewController.pageIndex
        index += 1
        return viewControllerAtIndex(index: index)
    }
    
    // MARK: - Page View Controller Delegate
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let viewController = pageViewController.viewControllers?.first as? ContentViewController {
                currentIndex = viewController.pageIndex
                pageControl.currentPage = currentIndex
                
                // Show the get started button on the last page
                startButton.isHidden = currentIndex != images.count - 1
            }
        }
    }
}
