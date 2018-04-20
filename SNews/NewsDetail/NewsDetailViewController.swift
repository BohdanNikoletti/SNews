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
  var newsLink: URL?
  
  // MARK: - Lifecycle events
  override func viewDidLoad() {
    super.viewDidLoad()
    loadArticle()
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
  
  // MARK: - Private methods
  private func loadArticle() {
    guard let newsLink = self.newsLink else { return }
    webView.load(URLRequest(url: newsLink))
    webView.allowsBackForwardNavigationGestures = true
  }
}
