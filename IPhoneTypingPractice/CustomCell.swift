//
//  VCCell.swift
//  IPhoneTypingPractice
//
//  Created by ㅇ오ㅇ on 2020/06/22.
//  Copyright © 2020 요한. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {
  static let identifier = "CustomCell"
  
  let titleLabel = UILabel()
  let img = UIImageView()
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
    setupConstraints()
  }
  
  private func setupView() {
    layer.cornerRadius = 10
    [titleLabel, img].forEach { contentView.addSubview($0) }
  }
  
  private func setupConstraints() {
    [titleLabel, img].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      img.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
      img.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      img.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      img.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -70)
    ])
    
    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15)
    ])
  }
  
  func configure(image: UIImage, titletext: String) {
    img.image = image
    titleLabel.text = titletext
  }
}
