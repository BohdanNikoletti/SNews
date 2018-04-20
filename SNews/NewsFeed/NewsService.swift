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
  
  func getNews() {
    request?.get()
      .subscribe(onNext: {[weak self] serverResponse in
        if let data = serverResponse.data {
          print(data)
          self?.isSuccess.accept(true)
          self?.isLoading.accept(false)
        } else {
          self?.isLoading.accept(false)
          self?.errorMessage.accept(nil)
        }
        }, onError: self.errohandler(_:))
      .disposed(by: disposeBag)
  }
}
