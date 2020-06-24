//
//  CustomCellCollectionViewCell.swift
//  IPhoneTypingPractice
//
//  Created by 요한 on 2020/06/23.
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
    titleLabel.font = .boldSystemFont(ofSize: 40)
    layer.cornerRadius = 10
    [titleLabel, img].forEach { contentView.addSubview($0) }
  }
  
  private func setupConstraints() {

    [titleLabel, img].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let width = contentView.frame.width / 2
    NSLayoutConstraint.activate([
      img.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      img.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      img.widthAnchor.constraint(equalToConstant: width),
      img.heightAnchor.constraint(equalToConstant: width)
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
