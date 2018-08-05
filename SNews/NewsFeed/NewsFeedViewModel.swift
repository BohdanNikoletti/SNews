//
//  NewsFeedViewModel.swift
//  SNews
//
//  Created by Soft Project on 4/20/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import RxSwift
import RxCocoa

struct NewsFeedViewModel {
  
  // MARK: - Properties
  var errors: Observable<AppError?> { return networkService.errorMessage.asObservable() }
  var content: BehaviorRelay<[NewsSection]> { return networkService.content }
  private let topHeadLinesResource: TopHeadLinesResource
  private let networkService: NewsService

  // MARK: - Initializers
  init() {
    topHeadLinesResource = TopHeadLinesResource(category: .business)
    self.networkService = NewsService(resource: topHeadLinesResource)
  }
  
  // MARK: - Methods
  func getNews() {
    if networkService.isLoading.value { return }
    networkService.getNews()
  }

}
