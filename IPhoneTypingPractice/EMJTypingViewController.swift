//
//  EMJViewController.swift
//  IPhoneTypingPractice
//
//  Created by 요한 on 2020/06/26.
//  Copyright © 2020 요한. All rights reserved.
//

import UIKit

class EMJTypingViewController: UIViewController {
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
      keyboardType: .default,
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
        let enWordData = Word.emoji[0...].randomElement()
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
      tenLimitAnimation()
    }

    if counter <= 5 {
      fiveLimitAnimation()
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

extension EMJTypingViewController: UITextFieldDelegate {
  
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
      let engWordData = Word.emoji[0...].randomElement()
      wordQuestion.text = engWordData
      wordQuestion.textColor = .black
      wordTextField.text = ""
      score += 1
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
        self.wordTextField.center.x += 8
      })
      UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3, animations: {
        self.wordQuestion.center.x += 16
        self.wordTextField.center.x -= 16
      })
      UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3, animations: {
        self.wordQuestion.center.x -= 16
        self.wordTextField.center.x += 16
        
      })
      UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
        self.wordQuestion.center.x += 8
        self.wordTextField.center.x -= 8
      })
    })
  }
  
  private func fiveLimitAnimation() {
    UIView.animateKeyframes(withDuration: 0.25, delay: 0, animations: {
      UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
        self.limitCountLabel.transform = self.limitCountLabel.transform.scaledBy(x: 3, y: 3)
      })
      UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3, animations: {
        self.limitCountLabel.transform = .identity
      })
      UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3, animations: {
        self.limitCountLabel.transform = self.limitCountLabel.transform.scaledBy(x: 5, y: 5)
      })
      UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
        self.limitCountLabel.transform = .identity
      })
    })
  }
  
  private func tenLimitAnimation() {
  UIView.animateKeyframes(withDuration: 0.25, delay: 0, animations: {
    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
      self.limitCountLabel.transform = self.limitCountLabel.transform.scaledBy(x: 1, y: 1)
    })
    UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3, animations: {
      self.limitCountLabel.transform = .identity
    })
    UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3, animations: {
      self.limitCountLabel.transform = self.limitCountLabel.transform.scaledBy(x: 3, y: 3)
    })
    UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
      self.limitCountLabel.transform = .identity
    })
  })
  }
  
}
