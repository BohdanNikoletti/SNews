//
//  AppDelegate.swift
//  SNews
//
//  Created by Soft Project on 4/20/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import UIKit
import FTLinearActivityIndicator
import Reachability
import NotificationBannerSwift
#if DEBUG
  import RxSwift
#endif

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  private var isFirstLaunch = true
  private let reachability = Reachability()
  private lazy var networkUnReachableBanner: StatusBarNotificationBanner = {
    let banner = StatusBarNotificationBanner(title: "You are offline", style: .danger)
    banner.autoDismiss = false
    banner.dismissOnSwipeUp = false
    return banner
  }()
  private lazy var networkReachableBanner: StatusBarNotificationBanner = {
    let banner = StatusBarNotificationBanner(title: "You are back online", style: .success)
    banner.autoDismiss = true
    banner.dismissOnSwipeUp = true
    return banner
  }()
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    UIApplication.configureLinearNetworkActivityIndicatorIfNeeded()
    settingUpDebugLogForRX()
    reachabilityhandler()
    return true
  }
  
  deinit { reachability?.stopNotifier() }
  
}
private extension AppDelegate {
  
  func settingUpDebugLogForRX() {
    #if DEBUG
    _ = Observable<Int>
      .interval(1, scheduler: MainScheduler.instance)
      .subscribe { _ in
        print("RxSwift Resource count: \(RxSwift.Resources.total).")
    }
    #endif
  }
  
  func reachabilityhandler() {
    reachability?.whenReachable = {
      [unowned self] _ in
      if !self.isFirstLaunch {
        self.networkUnReachableBanner.dismiss()
        self.networkReachableBanner.show()
      }
      self.isFirstLaunch = false
    }
    reachability?.whenUnreachable = {
      [unowned self] _ in
      self.isFirstLaunch = false
      self.networkReachableBanner.dismiss()
      self.networkUnReachableBanner.show()
    }
    do {
      try reachability?.startNotifier()
    } catch {
      print(error.localizedDescription)
    }
  }
  
}
