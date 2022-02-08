//
//  UIApplication+Extension.swift
//  ExObservable
//
//  Created by Jake.K on 2022/02/08.
//

import UIKit

// https://stackoverflow.com/questions/36284476/top-most-viewcontroller-under-uialertcontroller
extension UIApplication {
  var rootViewController: UIViewController? {
    self.windows.compactMap(\.rootViewController).first
  }
  class var topViewController: UIViewController? {
    UIApplication.shared.rootViewController
      .flatMap(self.topViewController(base:))
  }
  private class func topViewController(base: UIViewController?) -> UIViewController? {
    if let nav = base as? UINavigationController {
      return topViewController(base: nav.visibleViewController)
    }
    if let tab = base as? UITabBarController {
      if let selected = tab.selectedViewController {
        return topViewController(base: selected)
      }
    }
    if let page = base as? UIPageViewController,
       page.viewControllers?.count == 1 {
      return topViewController(base: page.viewControllers?.first)
    }
    if let alert = base as? UIAlertController {
      if let presenting = alert.presentingViewController {
        return topViewController(base: presenting)
      }
    }
    if let presented = base?.presentedViewController {
      return topViewController(base: presented)
    }
    for subview in base?.view.subviews ?? [] {
      if let childVC = subview.next as? UIViewController {
        return topViewController(base: childVC)
      }
    }
    return base
  }
}
