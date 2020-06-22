//
//  ViewController.swift
//  IPhoneTypingPractice
//
//  Created by 요한 on 2020/06/22.
//  Copyright © 2020 요한. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let gameImg = ["english", "kor"]
  
  let flowLayout = UICollectionViewFlowLayout()
  lazy var collectionView = UICollectionView(
    frame: view.frame, collectionViewLayout: flowLayout
  )
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setupCollectionView()
  }
  
  private func setupCollectionView() {
    setupFlowLayout()
    
    collectionView.backgroundColor = .systemBackground
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
    cell.configure(image: UIImage(named: gameImg[0])!, titletext: "영어 자판")
    
    return cell
  }
}

extension ViewController: UICollectionViewDelegate {
  
}

