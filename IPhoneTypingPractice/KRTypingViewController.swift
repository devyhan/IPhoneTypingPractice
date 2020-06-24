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
    //        self.someTextField.becomeFirstResponder()
    view.reloadInputViews()
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
     
    Common.defaultTextField(
      for: someTextField,
      placeholder: "Touch Start",
      textAlignment: .center,
      keyboardType: .default,
      where: view
    )
    
    // Layout
    someView
      .autoLayout
      .top()
      .leading()
      .trailing()
    
    // Layout
    someTextField
      .autoLayout
      .top(equalTo: someView.bottomAnchor, constant: Common.margin)
      .leading()
      .trailing()
    
    Common.titleLabel(for: countLabel, title: "3", fontColor: .black, textAlignment: .center, where: someView)
    countLabel.autoLayout
      .top(equalTo: someView.topAnchor, constant: Common.margin)
      .leading(equalTo: someView.leadingAnchor, constant: Common.margin)
      .trailing(equalTo: someView.trailingAnchor, constant: -Common.margin)
      .bottom(equalTo: someView.bottomAnchor, constant: -Common.margin)
    
    Common.contantsLabel(for: contentsLabel, title: "none", fontColor: .black, fontMultiplier: 1, textAlignment: .center, where: someView)
    contentsLabel.autoLayout
      .top(equalTo: someView.topAnchor, constant: -Common.margin * 2)
      .leading(equalTo: someView.leadingAnchor)
      .trailing(equalTo: someView.trailingAnchor)
    
    uiChangeConstraint = someTextField.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
    uiChangeConstraint?.isActive = true
    
    setKeyboardEvent()
    
    someTextField.delegate = self
    
  }
  
  // MARK: - Action
  
  @objc func keyboardWillAppear(_ sender: NotificationCenter) {
    someTextField.placeholder = "위 단어를 적으세요."
    uiChangeConstraint?.constant = -310
    
    let korWordData = Word.korWord[0...].randomElement()
    countLabel.text = korWordData
  }
  
  @objc func keyboardWillDisappear(_ sender: NotificationCenter) {
    someTextField.placeholder = "Touch Start"
    uiChangeConstraint?.constant = 0
    countLabel.text = ""
    
  }
  
  @objc func setTimer() {

  } // end setTimer
  
}

extension KRTypingViewController: UITextFieldDelegate {
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
    self.view.endEditing(true)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField.text == countLabel.text {
      
      let korWordData = Word.korWord[0...].randomElement()
      countLabel.text = korWordData
      countLabel.textColor = .black
      someTextField.text = ""
    } else if textField.text != countLabel.text {
      countLabel.textColor = .red
      shakeAnimation()
    }
    return true
  }
  
  private func shakeAnimation() {
    UIView.animateKeyframes(withDuration: 0.25, delay: 0, animations: {
      UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
        self.countLabel.center.x -= 8
        self.someTextField.center.x -= 8
      })
      UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3, animations: {
        self.countLabel.center.x += 16
        self.someTextField.center.x += 16
      })
      UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3, animations: {
        self.countLabel.center.x -= 16
        self.someTextField.center.x -= 16

      })
      UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
        self.countLabel.center.x += 8
        self.someTextField.center.x += 8

      })
    })
  }
  
  func setKeyboardEvent() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
}

