//
//  HealthViewCollectionViewController.swift
//  CareNote
//
//  Created by Batch-1 on 29/05/24.
//

import UIKit

class HealthViewCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentVital", for: indexPath)
        
        return cell
    }
    
    
    @IBOutlet var collectionView: UICollectionView!
    //Code to make tab bar icon visible
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        super.tabBarItem.title = "HealthView"
        super.tabBarItem.image = UIImage(systemName: "doc.text.image")
        super.tabBarItem.selectedImage = UIImage(systemName: "doc.text.image.fill")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let currentVitalNib = UINib(nibName: "CurrentVital", bundle: nil)
        
        collectionView.register(currentVitalNib, forCellWithReuseIdentifier: "CurrentVital")
        
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    func generateLayout(){
        
        
        
    }
    


}
