//
//  ViewController.swift
//  IPhoneTypingPractice
//
//  Created by 요한 on 2020/06/22.
//  Copyright © 2020 요한. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let gameImg = ["flag", "uk"]
  let gameTitle = ["KOR", "ENG"]
  
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
    gradientLayer.colors = [UIColor(rgb:0xf1e7fe).cgColor, UIColor(rgb: 0xbe90d4).cgColor]
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
    let width = view.frame.width - 60
    flowLayout.itemSize = CGSize(width: width, height: width)
    flowLayout.sectionInset = UIEdgeInsets(top:  40, left: 40, bottom: 40, right: 40)
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
    let width = view.frame.width / 2
    let img = UIImageView()
    img.frame = CGRect(x: 0, y: 0, width: width, height: width)
    img.center = view.center
    if gameImg[indexPath.item] == "flag" {
      img.image = UIImage(named: "flag")
      view.addSubview(img)
      UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
        img.transform = CGAffineTransform(scaleX: 15, y: 15)
      }) { (true) in
        let vc = KRTypingViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
      }
    } else if gameImg[indexPath.item] == "uk" {
      img.image = UIImage(named: "uk")
      view.addSubview(img)
      UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
        img.transform = CGAffineTransform(scaleX: 15, y: 15)
      }) { (true) in
        let vc = ENTypingViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
      }
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
