//
//  CameraViewController.swift
//  InstagramBeta
//
//  Created by Rifluxyss on 27/12/22.
//

import UIKit

class CameraViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
  

    @IBOutlet weak var AddPostCollView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 500
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.AddPostCollView.dequeueReusableCell(withReuseIdentifier: "CollCell", for: indexPath)
        
        return cell
    }
    
}
