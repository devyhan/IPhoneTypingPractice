//
//  ENTypingViewController.swift
//  IPhoneTypingPractice
//
//  Created by 요한 on 2020/06/24.
//  Copyright © 2020 요한. All rights reserved.
//

import UIKit

class ENTypingViewController: UIViewController {
  private let someView = UIView()
  private let someTextField = UITextField()
  private var uiChangeConstraint: NSLayoutConstraint?
  private var timer: Timer?
  private let countLabel = UILabel()
  private let contentsLabel = UILabel()
  private let startAnimationLabel = UILabel()
  private let limitLabel = UILabel()
  private let wordQuestion = UILabel()
 
  
  var count = 4 {
    didSet { countLabel.text = "\(count)" }
  }
  var counter = 63
  
  lazy var leftButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      barButtonSystemItem: .stop,
      target: self,
      action: #selector(buttonPressed(_:))
    )
    button.tag = 1
    return button
  }()
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    someTextField.text = ""
    wordQuestion.isHidden = true
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    print("disappear")
    
    timer?.invalidate()
    timer = nil
    counter = 63
    contentsLabel.text = "60"
    someTextField.text = ""
    wordQuestion.isHidden = true
    self.view.endEditing(true)
  }
  
  // MARK: - UI
  
  func setupUI() {
    view.backgroundColor = .white
    navigationItem.leftBarButtonItem = self.leftButton
    navigationController?.navigationBar.barTintColor = .white
    navigationController?.navigationBar.shadowImage = UIImage()
    
    
    // Attribute
    Common.defaultView(
      for: someView,
      where: view
    )
    // Layout
    someView.autoLayout.top().leading().trailing()
    
    // Attribute
    Common.contantsLabel(
      for: limitLabel,
      title: "제한시간",
      fontColor: .black,
      fontMultiplier: 1,
      textAlignment: .center,
      where: someView
    )
    // Layout
    limitLabel.autoLayout
      .top()
      .leading()
      .trailing()
  
    
    // Attribute
    Common.contantsLabel(
      for: contentsLabel,
      title: "60",
      fontColor: .black,
      fontMultiplier: 1,
      textAlignment: .center,
      where: someView
    )
    // Layout
    contentsLabel.autoLayout
      .top(equalTo: limitLabel.bottomAnchor)
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
    someTextField.autocorrectionType = .yes
    // Layout
    someTextField.autoLayout
      .top(equalTo: someView.bottomAnchor, constant: Common.margin)
      .leading()
      .trailing()
    
    // Attribute
    Common.titleLabel(
      for: countLabel,
      title: "3",
      fontColor: .black,
      textAlignment: .center,
      where: someView
    )
    countLabel.isHidden = true
    // Layout
    countLabel.autoLayout
      .top(equalTo: contentsLabel.bottomAnchor)
      .leading()
      .trailing()
      .bottom()
    
    // Attribute
    Common.contantsLabel(
      for: wordQuestion,
      title: "",
      fontColor: .black,
      fontMultiplier: 3,
      textAlignment: .center,
      where: someView
    )
    // Layout
    wordQuestion.autoLayout
      .centerY()
      .leading()
      .trailing()
    
    uiChangeConstraint = someTextField.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
    uiChangeConstraint?.isActive = true
    
    setKeyboardEvent()
    someTextField.delegate = self

  }
  
  func countDown() {
    UIView.transition(
      with: self.countLabel,
      duration: 0.5, // 전환 애니메이션 지속 시간
      options: [.transitionCrossDissolve],
      animations: {
        self.count -= 1
    }) { _ in
      // 다음 카운트로 넘어갈 때까지 대기 시간
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        guard self.count == 1 else {
          return self.countDown()
        }
        self.countLabel.isHidden = true
        let enWordData = Word.engWord[0...].randomElement()
        self.wordQuestion.isHidden = false
        self.wordQuestion.text = enWordData
        self.count = 4
      }
    }
  }
  
  // MARK: - Action
  
  @objc func keyboardWillAppear(_ sender: NotificationCenter) {
    uiChangeConstraint?.constant = -300
    print("시작")
    
//    self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.setTimer), userInfo: nil, repeats: true)
//
//    self.countLabel.isHidden = false
//    countDown()
  }
  
  @objc func keyboardWillDisappear(_ sender: NotificationCenter) {
    uiChangeConstraint?.constant = 0
  }
  
  @objc func setTimer() {
    print("timer")
    counter -= 1
    if counter <= 60 {
      contentsLabel.text = "\(counter)"
    }
    
    if counter == 0 {
      timer?.invalidate()
      timer = nil
      counter = 63
      contentsLabel.text = "60"
      someTextField.text = ""
      wordQuestion.isHidden = true
      self.view.endEditing(true)
    }
    
  } // end setTimer
  
  @objc func buttonPressed(_ sender: Any) {
    if let button = sender as? UIBarButtonItem {
      switch button.tag {
      case 1:
        dismiss(animated: true)
      default: print("error")
      }
    }
  }

}

extension ENTypingViewController: UITextFieldDelegate {
  
  func setKeyboardEvent() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.setTimer), userInfo: nil, repeats: true)
    self.countLabel.isHidden = false
    countDown()
    
    return true
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    if textField.text == wordQuestion.text {
      let korWordData = Word.engWord[0...].randomElement()
      wordQuestion.text = korWordData
      wordQuestion.textColor = .black
      someTextField.text = ""
    } else if textField.text != wordQuestion.text {
      wordQuestion.textColor = .red
      shakeAnimation()
    }
    return true
  }
  
  private func shakeAnimation() {
    UIView.animateKeyframes(withDuration: 0.25, delay: 0, animations: {
      UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
        self.wordQuestion.center.x -= 8
        self.someTextField.center.x += 8
      })
      UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3, animations: {
        self.wordQuestion.center.x += 16
        self.someTextField.center.x -= 16
      })
      UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3, animations: {
        self.wordQuestion.center.x -= 16
        self.someTextField.center.x += 16
        
      })
      UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
        self.wordQuestion.center.x += 8
        self.someTextField.center.x -= 8
      })
    })
  }
  
}
