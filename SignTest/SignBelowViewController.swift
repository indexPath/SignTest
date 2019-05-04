//
//  SignBelowViewController.swift
//  SignTest
//
//  Created by 김성남 on 13/04/2019.
//  Copyright © 2019 김성남. All rights reserved.
//

import UIKit

class SignBelowViewController: extensionViewController {
//-------------------------------------------------------------------------------------------
// MARK: - IBOutlets
//-------------------------------------------------------------------------------------------
  @IBOutlet weak var signView: UIView!
  @IBOutlet weak var signImageView: UIImageView!
  @IBOutlet weak var resetButton: UIButton!
  
    
//-------------------------------------------------------------------------------------------
// MARK: - Local Variables
//-------------------------------------------------------------------------------------------
  var lastPoint: CGPoint!     //바로 전에 터치하거나 이동한 위치
  var lineSize: CGFloat = 10.0 // 선의 두께
  var lineColor = UIColor.black.cgColor // 선의 색상
  var touchCheck = false
    
//-------------------------------------------------------------------------------------------
// MARK: - override method
//-------------------------------------------------------------------------------------------
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
      self.signView.setCornerRadius(radius: 10)
      self.resetButton.setCornerRadius(radius: 10)
  }
  
  override func initRequest() {
      super.initRequest()
    
  }
  
  //=========================================================================
  // Sign Action
  //=========================================================================
  
  /*
   * 터치 시작
   func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
   
   * 터치 이동
   func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
   
   * 터치 종료
   func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
   
   * 터치 취소(뷰 사라지기, 전화, 등)
   func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?)
  */
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      let touch = touches.first! as UITouch
      lastPoint = touch.location(in: self.signImageView)
  }
    
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.touchCheck = true
    
      UIGraphicsBeginImageContext(self.signImageView.frame.size)
      UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
      UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round) // 라인의 끝모양을 라운드로 설정
      UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
    
      let touch = touches.first! as UITouch   //현재발생한 터치 이벤트를 가지고 온다.
      let currPoint = touch.location(in: self.signImageView) //터치된 위치를 currPoint로 가지고 온다.
      //현재 이미지 뷰에 있는 이미지를 이미지 뷰의 크기로 그린다.
      self.signImageView.image?.draw(in: CGRect(x:0, y:0, width: self.signImageView.frame.size.width, height:self.signImageView.frame.size.height))
      //이전에 이동위치인 lastPoint로 시작 위치를 이동시킨다.
      UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
      //lastPoint에서 현재 위치인 currPoint까지 선을 추가한다.
      UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x:currPoint.x, y:currPoint.y))
      UIGraphicsGetCurrentContext()?.strokePath()
      self.signImageView.image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      //현재 터치된 위치를 lastPoint라는 변수에 할당
      lastPoint = currPoint
    
  }
    
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      UIGraphicsBeginImageContext(self.signImageView.frame.size)
      UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
      UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round) // 라인의 끝모양을 라운드로 설정
      UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
    
      //현재 이미지 뷰에 있는 이미지를 이미지 뷰의 크기로 그린다.
      self.signImageView.image?.draw(in: CGRect(x:0, y:0, width: self.signImageView.frame.size.width, height:self.signImageView.frame.size.height))
    
      //이전에 이동위치인 lastPoint로 시작 위치를 이동시킨다.
      UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
      UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x:lastPoint.x, y:lastPoint.y))
      UIGraphicsGetCurrentContext()?.strokePath()
      self.signImageView.image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
    
  }
  //=========================================================================
  
  func alert(title: String, message: String) {
    //alert
    let alertController = UIAlertController(
      title: title,
      message: message,
      preferredStyle: UIAlertController.Style.alert
    )
    let confirmAction = UIAlertAction(
    title: "OK", style: UIAlertAction.Style.default) { (action) in
    }
    alertController.addAction(confirmAction)
    present(alertController, animated: true, completion: nil)
  }
    
  @IBAction func resetButtonTouched(_ sender: UIButton) {
        self.signImageView.image = nil
  }
  
  
  @IBAction func nextPageButtonTouched(_ sender: UIButton) {
    if self.signImageView.image == nil {
      self.alert(title: "", message: "사인을 해주세요.")
      return
    }
    
    let viewMove = SignResultViewController.instantiate(storyboard: "Main")
      viewMove.receiveImage = self.signImageView.image
    viewMove.delegate = self
    self.present(viewMove, animated: true, completion: nil)
  }
}

// Main 으로 이동하는 delegate
extension SignBelowViewController: MainViewProtocol {
  func MainViewMove(check: String) {
    if check == "Ok" {
      self.dismiss(animated: false, completion: nil)
    }
  }
}
