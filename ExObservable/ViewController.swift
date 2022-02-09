//
//  ViewController.swift
//  ExObservable
//
//  Created by Jake.K on 2022/02/08.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var startButton: UIButton!
  @IBOutlet weak var cancelButton: UIButton!
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  @IBAction func didTapStartButton(_ sender: Any) {
    MyPopup.startTask()
  }
  @IBAction func didTapCancelButton(_ sender: Any) {
    MyPopup.cancelTask()
  }
}
