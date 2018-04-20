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
  
  // MARK: Properties
  private let viewModel = NewsFeedViewModel()
  private let disposeBag = DisposeBag()
  
  // MARK: Life cycle events
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareTableView()
    viewModel.getNews()
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
      .subscribe(onNext: { pair in
        print("Tapped `\(pair.1)` @ \(pair.0)")
      })
      .disposed(by: disposeBag)
    
    tableView.rx
      .setDelegate(self)
      .disposed(by: disposeBag)
    
  }
}

// MARK: UITableViewDelegate extension
extension NewsFeedViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
    return .none
  }
  
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
