//
//  MyPopup.swift
//  ExObservable
//
//  Created by Jake.K on 2022/02/08.
//

import UIKit
import RxSwift
import RxCocoa

protocol MyPopupType {
  static func startTask()
  static func stopTask()
}

class MyPopup: MyPopupType {
  static private var disposeBag = DisposeBag()
  static private var countDown = 5
  
  static func startTask() {
    self.disposeBag = DisposeBag()
    self.countDown = 5
    
    let sampleLabel = UILabel()
    sampleLabel.backgroundColor = .systemOrange
    sampleLabel.textColor = .white
    sampleLabel.layer.cornerRadius = 10
    
    guard let superview = UIApplication.topViewController?.view else { return }
    superview.addSubview(sampleLabel)
    
    sampleLabel.translatesAutoresizingMaskIntoConstraints = false
    sampleLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
    sampleLabel.heightAnchor.constraint(equalToConstant: 300).isActive = true
    sampleLabel.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
    sampleLabel.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
    
    Observable<Void>
      .create { [weak sampleLabel] observer in
        Observable<Int>.timer(.seconds(0), period: .seconds(1), scheduler: MainScheduler.instance)
          .take(Self.countDown + 1)
          .subscribe(onNext: { timePassed in
            let count = Self.countDown - timePassed
            sampleLabel?.text = "\(count)"
          }, onCompleted: {
            sampleLabel?.removeFromSuperview()
            observer.onCompleted()
          })
          .disposed(by: Self.disposeBag)
        
        return Disposables.create { sampleLabel?.removeFromSuperview() }
      }
      .subscribe()
      .disposed(by: self.disposeBag)
  }
  
  static func stopTask() {
    self.disposeBag = DisposeBag()
  }
}
