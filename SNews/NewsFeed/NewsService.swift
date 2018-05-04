//
//  NewsService.swift
//  SNews
//
//  Created by Soft Project on 4/20/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import RxAlamofire
import RxCocoa
import RxSwift
import Alamofire

final class NewsService: NetworkService<TopHeadLinesResource> {
  // MARK: - Properties
  private let pageSize = 20
  private var page: Int {
    return articles.count / pageSize + 1
  }
  
  let content = BehaviorRelay<[NewsSection]>(value: [NewsSection(header: "",
                                                                 items: [Article]
                                                                  .init(repeating: Article.template, count: 10))])
  private var articles: [Article] = []
  
  // MARK: - Methods
  func getNews() {
    isLoading.accept(true)
    request?.get(page: page)
      .subscribe(onNext: {[unowned self] serverResponse in
        if let data = serverResponse.data {
          self.articles.append(contentsOf: data)
          self.content.accept([NewsSection(header: "", items: self.articles)])
          self.isSuccess.accept(true)
          self.isLoading.accept(false)
        } else {
          self.isLoading.accept(false)
          self.errorMessage.accept(serverResponse.erros)
        }
        }, onError: self.errohandler(_:))
      .disposed(by: disposeBag)
  }
}
