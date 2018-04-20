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
  
  let content = BehaviorRelay<[NewsSection]>(value: [NewsSection(header: "",
                                                                 items: [Article]
                                                                  .init(repeating: Article.template, count: 10))])
  var articles: [Article] = []
  
  func getNews() {
    isLoading.accept(true)
    let page = articles.count / 20 + 1 // - 20 is standart page size, +1 gives start not from 0 page
    request?.get(page: page)
      .subscribe(onNext: {[unowned self] serverResponse in
        if let data = serverResponse.data {
          self.articles.append(contentsOf: data)
          self.content.accept([NewsSection(header: "", items: self.articles)])
          self.isSuccess.accept(true)
          self.isLoading.accept(false)
        } else {
          self.isLoading.accept(false)
          self.errorMessage.accept(nil)
        }
        }, onError: self.errohandler(_:))
      .disposed(by: disposeBag)
  }
}
