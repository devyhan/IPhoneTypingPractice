//
//  LaunchViewController.swift
//  IPhoneTypingPractice
//
//  Created by ㅇ오ㅇ on 2020/06/24.
//  Copyright © 2020 요한. All rights reserved.
//
import Lottie
import UIKit


class LaunchViewController: UIViewController {

    private let img = UIImageView()
    private let label = UILabel()
  private let animationView: AnimationView = {
    let ani = AnimationView(name: "4052-smoothymon-typing")
    ani.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
    ani.contentMode = .scaleAspectFill
    return ani
  }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
      view.backgroundColor = .systemBackground
      view.addSubview(animationView)
      animationView.center = view.center
      
      animationView.play{ (finish) in
        self.dismiss(animated: true)
        
      }
//        setUI()
    }
//
//  func setUI() {
//    img.image = UIImage(named: "phone")
//    label.text = "안녕하세요!"
//
//
//
//  }



}
