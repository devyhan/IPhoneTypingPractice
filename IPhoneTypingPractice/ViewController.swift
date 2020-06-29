//
//  ViewController.swift
//  IPhoneTypingPractice
//
//  Created by 요한 on 2020/06/22.
//  Copyright © 2020 요한. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let gameImg = ["flag", "uk", "face", "swift"]
  let gameTitle = ["KOREAN", "ENGLISH", "EMOJI", "Swift"]
  private let flagImageView = UIImageView()
  
  let flowLayout = UICollectionViewFlowLayout()
  lazy var collectionView = UICollectionView(
    frame: view.frame, collectionViewLayout: flowLayout
  )
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let vc = LaunchViewController()
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: false)
    
    navigationController?.setNavigationBarHidden(true, animated: false)
    
    let outView = UIView()
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = view.frame
    gradientLayer.colors = [UIColor(rgb:0xf1e7fe).cgColor, UIColor(rgb: 0xbe90d4).cgColor]
    gradientLayer.locations = [0, 1]
    collectionView.backgroundView = outView
    collectionView.backgroundView?.layer.addSublayer(gradientLayer)
    //    collectionView.isScrollEnabled = false
    Common.toggle = true
    
    setupCollectionView()
  }
  
  private func setupCollectionView() {
    setupFlowLayout()
    
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.identifier)
    collectionView.register(UICollectionViewCell.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
    view.addSubview(collectionView)
  }
  
  private func setupFlowLayout() {
    let width = view.frame.width - 20
    let height = view.frame.height / 3 - 45
    flowLayout.itemSize = CGSize(width: width, height: height)
    flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    flowLayout.headerReferenceSize = CGSize(width: 60, height: 60)
    
    flowLayout.sectionHeadersPinToVisibleBounds = false
    
  }
}

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
    
    let label = UILabel()
    label.text = "너의 손놀림을 알아 보자 🥴"
    label.textAlignment = .center
    label.font = .boldSystemFont(ofSize: 20)
    label.frame = header.frame
    header.addSubview(label)
    return header
  }
  
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
    
    if gameImg[indexPath.item] == "flag" {
      let VC = Common.navigtationViewController(scene: KRTypingViewController())
      Common.buildImageView(
        for: flagImageView,
        width: width,
        imageNmae: "flag",
        where: view
      )
      Common.spreadFlagImage(
        ViewController: VC,
        imageView: flagImageView
      )
      VC.modalPresentationStyle = .fullScreen
      VC.modalTransitionStyle = .crossDissolve
      present(VC, animated: true)
    } else if gameImg[indexPath.item] == "uk" {
      let VC = Common.navigtationViewController(scene: ENTypingViewController())
      Common.buildImageView(
        for: flagImageView,
        width: width,
        imageNmae: "uk",
        where: view
      )
      Common.spreadFlagImage(
        ViewController: VC,
        imageView: flagImageView
      )
      VC.modalPresentationStyle = .fullScreen
      VC.modalTransitionStyle = .crossDissolve
      present(VC, animated: true)
    } else if gameImg[indexPath.item] == "face" {
      let VC = Common.navigtationViewController(scene: EMJTypingViewController())
      Common.buildImageView(
        for: flagImageView,
        width: width,
        imageNmae: "face",
        where: view
      )
      Common.spreadFlagImage(
        ViewController: VC,
        imageView: flagImageView
      )
      VC.modalPresentationStyle = .fullScreen
      VC.modalTransitionStyle = .crossDissolve
      present(VC, animated: true)
    } else if gameImg[indexPath.item] == "swift" {
      let VC = Common.navigtationViewController(scene: SWFTypingViewController())
      Common.buildImageView(
        for: flagImageView,
        width: width,
        imageNmae: "swift",
        where: view)
      Common.spreadFlagImage(
        ViewController: VC,
        imageView: flagImageView
      )
      VC.modalPresentationStyle = .fullScreen
      VC.modalTransitionStyle = .crossDissolve
      present(VC, animated: true)
    }
  }
}
