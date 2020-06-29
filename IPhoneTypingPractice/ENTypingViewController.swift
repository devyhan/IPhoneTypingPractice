//
//  ENTypingViewController.swift
//  IPhoneTypingPractice
//
//  Created by 요한 on 2020/06/24.
//  Copyright © 2020 요한. All rights reserved.
//

import UIKit

class ENTypingViewController: UIViewController {
  
  private let contentsWrapView = UIView()
  private let wordTextField = UITextField()
  private let startCountLabel = UILabel()
  private let limitLabel = UILabel()
  private let limitCountLabel = UILabel()
  private let startAnimationLabel = UILabel()
  
  private let wordQuestion = UILabel()
  
  private var timer: Timer?
  private var uiChangeConstraint: NSLayoutConstraint?
  
  private var score = 0
  
  var count = 4 {
    didSet { startCountLabel.text = "\(count)" }
  }
  var counter = 33
  
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
    navigationController?.navigationBar.tintColor = .black

  }
  
  override func viewWillAppear(_ animated: Bool) {
    wordTextField.text = ""
    wordQuestion.isHidden = true
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    print("disappear")
    
    timer?.invalidate()
    timer = nil
    counter = 33
    limitCountLabel.text = "30"
    wordTextField.text = ""
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
      for: contentsWrapView,
      where: view
    )
    // Layout
    contentsWrapView.autoLayout
      .top()
      .leading()
      .trailing()
    
    // Attribute
    Common.contantsLabel(
      for: limitLabel,
      title: "제한시간",
      fontColor: .black,
      fontMultiplier: 1,
      textAlignment: .center,
      where: contentsWrapView
    )
    // Layout
    limitLabel.autoLayout
      .top()
      .leading()
      .trailing()
    
    // Attribute
    Common.contantsLabel(
      for: limitCountLabel,
      title: "30",
      fontColor: .black,
      fontMultiplier: 1,
      textAlignment: .center,
      where: contentsWrapView
    )
    // Layout
    limitCountLabel.autoLayout
      .top(equalTo: limitLabel.bottomAnchor)
      .leading()
      .trailing()
    
    // Attribute
    Common.defaultTextField(
      for: wordTextField,
      placeholder: "시작하려면 이곳을 눌러주세요",
      textAlignment: .center,
      keyboardType: .alphabet,
      where: view
    )
    wordTextField.autocorrectionType = .yes
    // Layout
    wordTextField.autoLayout
      .top(equalTo: contentsWrapView.bottomAnchor, constant: Common.margin)
      .leading()
      .trailing()
    
    // Attribute
    Common.titleLabel(
      for: startCountLabel,
      title: "3",
      fontColor: .black,
      textAlignment: .center,
      where: contentsWrapView
    )
    startCountLabel.isHidden = true
    // Layout
    startCountLabel.autoLayout
      .top(equalTo: limitCountLabel.bottomAnchor)
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
      where: contentsWrapView
    )
    
    wordQuestion.adjustsFontSizeToFitWidth = true

    // Layout
    wordQuestion.autoLayout
      .centerY()
      .leading()
      .trailing()
    
    uiChangeConstraint = wordTextField.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
    uiChangeConstraint?.isActive = true
    
    setKeyboardEvent()
    wordTextField.delegate = self
  }
  
  func countDown() {
    UIView.transition(
      with: self.startCountLabel,
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
        self.startCountLabel.isHidden = true
        let enWordData = Word.engWord[0...].randomElement()
        self.wordQuestion.isHidden = false
        self.wordQuestion.text = enWordData
        self.count = 4
      }
    }
  }
  
  // MARK: - Action
  
  @objc func keyboardWillAppear(_ sender: NotificationCenter) {
    wordTextField.placeholder = "위 단어를 적으세요."
    uiChangeConstraint?.constant = -300
    print("시작")
  }
  
  @objc func keyboardWillDisappear(_ sender: NotificationCenter) {
    wordTextField.placeholder = "시작하려면 이곳을 눌러주세요"
    wordQuestion.textColor = .black
    uiChangeConstraint?.constant = 0
  }
  
  @objc func setTimer() {
    print("timer")
    counter -= 1
    if counter <= 30 {
      limitCountLabel.text = "\(counter)"
    }
    
    if counter == 0 {
      timer?.invalidate()
      timer = nil
      counter = 33
      limitCountLabel.text = "30"
      wordTextField.text = ""
      wordQuestion.isHidden = true
      self.view.endEditing(true)
      
      let wordScore = score * 2
      
      let alert = UIAlertController(title: "점수", message: "\(wordScore)WPM", preferredStyle: .alert)
      let okAction = UIAlertAction(title: "확인", style: .default) { (UIAlertAction) in
        self.score = 0
      }
      
      alert.addAction(okAction)
    
      self.limitCountLabel.textColor = .black
      return present(alert, animated: true)
    }
    
    if counter <= 10 {
      self.limitCountLabel.textColor = .red
      Common.hartBeatAnimation(targetLabel: limitCountLabel)
    }

    if counter <= 5 {
      Common.twiceHartBeatAnimation(targetLabel: limitCountLabel)
    }
    
  } // end setTimer
  
  @objc func buttonPressed(_ sender: Any) {
    if let button = sender as? UIBarButtonItem {
      switch button.tag {
      case 1:
        self.view.window?.rootViewController?.dismiss(animated: false, completion: {
          let VC = ViewController()
            VC.modalPresentationStyle = .fullScreen
            self.present(VC, animated: true)
        })
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
    self.startCountLabel.isHidden = false
    countDown()
    
    return true
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    if textField.text == wordQuestion.text {
      let engWordData = Word.engWord[0...].randomElement()
      wordQuestion.text = engWordData
      wordQuestion.textColor = .black
      wordTextField.text = ""
      score += 1
    } else if textField.text != wordQuestion.text {
      wordQuestion.textColor = .red
      Common.shakeAnimagtion(targetLabel: wordQuestion, reverseTargetLabel: wordTextField)
    }
    return true
  }
}
