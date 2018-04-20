//
//  ViewController.swift
//  SNews
//
//  Created by Soft Project on 4/20/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class NewsFeedViewController: UIViewController {
  
  // MARK: - Outlets
  @IBOutlet weak private var tableView: UITableView!
  
  // MARK: - Properties
  private var viewModel = NewsFeedViewModel()
  private let disposeBag = DisposeBag()
  private var selectedArticle: Article?
  
  // MARK: - Life cycle events
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareTableView()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Private methods
  private func prepareTableView() {
    
    tableView.tableFooterView = UIView()
    
    let dataSource = viewModel.dataSource
    
    viewModel.networkService?.content
      .bind(to: tableView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
    
    tableView.rx
      .itemSelected
      .map { indexPath in
        return (indexPath, dataSource[indexPath])
      }
      .subscribe(onNext: { [weak self] pair in
        self?.selectedArticle = pair.1
        self?.performSegue(withIdentifier: "newsDetail", sender: self)
      })
      .disposed(by: disposeBag)
    
    tableView.rx
      .setDelegate(self)
      .disposed(by: disposeBag)
    
    tableView.rx
      .contentOffset
      .asDriver()
      .drive(onNext: { [unowned self] point in
        if point.y >= (self.tableView.contentSize.height - self.tableView.frame.size.height) {
          self.viewModel.getNews()
        }
      }).disposed(by: disposeBag)
    
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: self)
    guard let newsDetail = segue.destination as? NewsDetailViewController else { return }
    newsDetail.newsLink = selectedArticle?.newsLink
    newsDetail.title = selectedArticle?.author
  }
}

// MARK: UITableViewDelegate extension
extension NewsFeedViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
    return .none
  }
//  func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//    cell
//  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 0.01
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 16
  }
}
