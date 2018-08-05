//
//  ViewController.swift
//  SNews
//
//  Created by Soft Project on 4/20/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift
import NotificationBannerSwift

final class NewsFeedViewController: UIViewController {
  
  // MARK: - Outlets
  @IBOutlet weak private var tableView: UITableView!
  
  // MARK: - Properties
  private let rowHeight: CGFloat = 80
  private let footerHeight: CGFloat = 32
  private let newsDetailSegueID = "newsDetail"
  private let tableViewInsets = UIEdgeInsets(top: -36, left: 0, bottom: -24, right: 0)
  private var viewModel = NewsFeedViewModel()
  private let disposeBag = DisposeBag()
  private var selectedArticle: Article?
  private let dataSource = RxTableViewSectionedReloadDataSource<NewsSection>(
    configureCell: { (_, tableView, _, element) in
      guard let cell = tableView
        .dequeueReusableCell(withIdentifier: "NewsCell") as? NewsTableViewCell
        else {
          fatalError("Can not cast cell to NewsTableViewCell")
      }
      cell.isUserInteractionEnabled = !element.isTemplateModel
      cell.isLoading = element.isTemplateModel
      if element.isTemplateModel { return cell }
      cell.title = element.title
      cell.subTitle = element.description
      cell.posterURL = element.imageLink
      return cell
  })
  
  // MARK: - Life cycle events
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareTableView()
    subscribeOnErrors()
    subscribeOnNews()
    setTableViewDelegate()
    subscribeOnScroll()
  }

  // MARK: - Private methods
  private func prepareTableView() {
    tableView.backgroundColor = UIColor.white
    tableView.tableFooterView = UIView()
    tableView.contentInset = tableViewInsets
  }
  
  private func subscribeOnErrors() {
    viewModel.errors
      .filter { $0 != nil }.bind { errors in
        let errorBanner = NotificationBanner(title: errors?.title ?? "Error",
                                             subtitle: errors?.localizedDescription, style: .danger)
        errorBanner.show( bannerPosition: BannerPosition.bottom)
      }.disposed(by: disposeBag)
  }
  
  private func subscribeOnNews() {
    
    let dataSource = self.dataSource
    
    viewModel.content
      .bind(to: tableView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
  }
  
  private func setTableViewDelegate() {
    
    let dataSource = self.dataSource

    tableView.rx
      .itemSelected
      .map { indexPath in
        return (indexPath, dataSource[indexPath])
      }
      .subscribe(onNext: { [weak self, newsDetailSegueID] pair in
        self?.selectedArticle = pair.1
        self?.performSegue(withIdentifier: newsDetailSegueID, sender: self)
      })
      .disposed(by: disposeBag)
    
    tableView.rx
      .setDelegate(self)
      .disposed(by: disposeBag)
  }
  
  private func subscribeOnScroll() {
    tableView.rx
      .contentOffset
      .asDriver()
      .drive(onNext: { [unowned self] _ in
        if self.tableView.isBottom {
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

// MARK: - UITableView extension
private extension UITableView {
  var isBottom: Bool {
    return contentOffset.y >= self.contentSize.height - self.frame.size.height
  }
}

// MARK: - UITableViewDelegate extension
extension NewsFeedViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
    return .none
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return rowHeight
  }

  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let footerView = UIView()
    let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    activityView.hidesWhenStopped = true
    activityView.startAnimating()
    footerView.addSubview(activityView)
    activityView.snp.makeConstraints { (make) -> Void in
      make.centerX.equalTo(footerView.snp.centerX)
      make.centerY.equalTo(footerView.snp.centerY)
    }
    return footerView
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return footerHeight
  }
}
