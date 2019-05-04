//
//  SignResultViewController.swift
//  SignTest
//
//  Created by 김성남 on 04/05/2019.
//  Copyright © 2019 김성남. All rights reserved.
//

import UIKit

protocol MainViewProtocol {
  func MainViewMove(check: String)
}

class SignResultViewController: extensionViewController {
  @IBOutlet weak var resultImageView: UIImageView!
  @IBOutlet weak var mainButton: UIButton!
  
  var receiveImage: UIImage?
  var delegate: MainViewProtocol?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func initLayout() {
    super.initLayout()
    self.mainButton.setCornerRadius(radius: 10)
  }
  
  override func initRequest() {
    super.initRequest()
    self.resultImageView.image = self.receiveImage
  }
  
  @IBAction func mainButtonTouched(_ sender: UIButton) {
    self.dismiss(animated: false) {
      self.delegate?.MainViewMove(check: "Ok")
    }
  }
}
