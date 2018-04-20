//
//  NewsDetailViewController.swift
//  SNews
//
//  Created by Soft Project on 4/20/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import UIKit
import WebKit

final class NewsDetailViewController: UIViewController {
  
  // MARK: - Outlets
  @IBOutlet weak var webView: WKWebView!
  
  // MARK: - Properties
  var newsLink = "https://www.nytimes.com/2018/04/20/business/barclays-james-staley.html"
  // MARK: - Lifecycle events
  override func viewDidLoad() {
    super.viewDidLoad()
    guard let url = URL(string: newsLink) else {
      return
    }
    webView.load(URLRequest(url: url))
    webView.allowsBackForwardNavigationGestures = true
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBar.prefersLargeTitles = false
  }
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.navigationController?.navigationBar.prefersLargeTitles = true

  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
