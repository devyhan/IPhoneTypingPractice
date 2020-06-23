//
//  KRTypingViewController.swift
//  IPhoneTypingPractice
//
//  Created by 요한 on 2020/06/22.
//  Copyright © 2020 요한. All rights reserved.
//

import UIKit

final class KRTypingViewController: UIViewController {
  private let someView = UIView()
  private let someTextField = UITextField()
  private var uiChangeConstraint: NSLayoutConstraint?
  private var timer: Timer?
  private let countLabel = UILabel()
  private let contentsLabel = UILabel()
  var counter: Int = 3
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    //    self.someTextField.becomeFirstResponder()
  }
  
  // MARK: - UI
  
  func setupUI() {
    view.backgroundColor = .white
    navigationController?.navigationBar.barTintColor = .white
    navigationController?.navigationBar.shadowImage = UIImage()
    // Attribute
    Common.defaultView(
      for: someView,
      where: view
    )
    // Layout
    someView
      .autoLayout
      .top()
      .leading()
      .trailing()
    
    // Attribute
    Common.defaultTextField(
      for: someTextField,
      placeholder: "TextField",
      textAlignment: .center,
      keyboardType: .default,
      where: view
    )
    // Layout
    someTextField.autoLayout
      .top(equalTo: someView.bottomAnchor, constant: Common.margin)
      .leading()
      .trailing()
    
    Common.titleLabel(for: countLabel, title: "3", fontColor: .black, textAlignment: .center, where: someView)
    countLabel.autoLayout
      .top(equalTo: someView.topAnchor, constant: Common.margin)
      .leading(equalTo: someView.leadingAnchor, constant: Common.margin)
      .trailing(equalTo: someView.trailingAnchor, constant: -Common.margin)
      .bottom(equalTo: someView.bottomAnchor, constant: -Common.margin)
    
    Common.contantsLabel(for: contentsLabel, title: "none", fontColor: .black, textAlignment: .center, where: someView)
    contentsLabel.autoLayout
      .top(equalTo: someView.topAnchor, constant: -Common.margin * 2)
      .leading(equalTo: someView.leadingAnchor)
      .trailing(equalTo: someView.trailingAnchor)
    
    uiChangeConstraint = someTextField.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
    uiChangeConstraint?.isActive = true
    
    setKeyboardEvent()
    
  }
  
  // MARK: - Action
  
  @objc func keyboardWillAppear(_ sender: NotificationCenter) {
    uiChangeConstraint?.constant = -270
    print("시작")
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(setTimer), userInfo: nil, repeats: true)
  }
  
  @objc func keyboardWillDisappear(_ sender: NotificationCenter) {
    uiChangeConstraint?.constant = 0
  }
  
  @objc func setTimer() {
    
    
  } // end setTimer
  
}

extension KRTypingViewController: UITextFieldDelegate {
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
    self.view.endEditing(true)
  }
  
  func setKeyboardEvent() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
}
