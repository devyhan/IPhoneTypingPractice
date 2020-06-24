//
//  ViewController.swift
//  IPhoneTypingPractice
//
//  Created by 요한 on 2020/06/22.
//  Copyright © 2020 요한. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let gameImg = ["kor", "eng"]
  let gameTitle = ["KOR Keyboard", "ENG Keyboard"]
  
  let flowLayout = UICollectionViewFlowLayout()
  lazy var collectionView = UICollectionView(
    frame: view.frame, collectionViewLayout: flowLayout
  )
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.setNavigationBarHidden(true, animated: false)
    let outView = UIView()
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = view.frame
    gradientLayer.colors = [UIColor.systemTeal.cgColor, UIColor.systemBlue.cgColor]
    gradientLayer.locations = [0, 1]
    collectionView.backgroundView = outView
    collectionView.backgroundView?.layer.addSublayer(gradientLayer)
    
    setupCollectionView()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  
  }
  
  private func setupCollectionView() {
    setupFlowLayout()
    
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.identifier)
     view.addSubview(collectionView)
    
  }
  
  private func setupFlowLayout() {
    let width = view.frame.width - 20
    flowLayout.itemSize = CGSize(width: width, height: width)
    flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
  }
}

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return gameImg.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
    cell.configure(image: UIImage(named: gameImg[indexPath.item])!, titletext: gameTitle[indexPath.item])
    
    cell.backgroundColor = .systemBackground
    cell.layer.shadowColor = UIColor.black.cgColor
    cell.layer.shadowOffset = CGSize(width: 1, height: 1)
    cell.layer.shadowOpacity = 0.5
    cell.layer.shadowRadius = 5

    return cell
  }
}

extension ViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if gameImg[indexPath.item] == "kor" {
      let vc = KRTypingViewController()
      vc.modalPresentationStyle = .fullScreen
      present(vc, animated: true)
    }
  }
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
