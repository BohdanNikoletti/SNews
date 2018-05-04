//
//  NewsDetailViewController.swift
//  SNews
//
//  Created by Soft Project on 4/20/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//  swiftlint:disable implicitly_unwrapped_optional

import UIKit
import WebKit
import RxCocoa
import RxSwift

final class NewsDetailViewController: UIViewController {
  
  // MARK: - Outlets
  @IBOutlet weak var webView: WKWebView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  // MARK: - Properties
  var newsLink: URL?
  
  // MARK: - Lifecycle events
  override func viewDidLoad() {
    super.viewDidLoad()
    webView.navigationDelegate = self
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
  }
  
  // MARK: - Private methods
  private func loadArticle() {
    guard let newsLink = self.newsLink else { return }
    webView.load(URLRequest(url: newsLink))
    webView.allowsBackForwardNavigationGestures = true
  }
}

// MARK: - WKNavigationDelegate
extension NewsDetailViewController: WKNavigationDelegate {
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    UIView.animate(withDuration: 0.35,
                   animations: { [unowned self] in
                    self.webView.alpha = 1
    })
    activityIndicator.stopAnimating()
  }
}
