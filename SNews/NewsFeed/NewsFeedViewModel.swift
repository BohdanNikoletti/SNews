//
//  NewsFeedViewModel.swift
//  SNews
//
//  Created by Soft Project on 4/20/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import RxDataSources

struct NewsFeedViewModel {
  
  // MARK: - Properties
  var topHeadLinesResource = TopHeadLinesResource()
  let networkService: NewsService?
  
  let dataSource = RxTableViewSectionedReloadDataSource<NewsSection>(
      configureCell: { (_, tableView, _, element) in
        guard let cell = tableView
          .dequeueReusableCell(withIdentifier: "NewsCell") as? NewsTableViewCell
          else {
            fatalError("can not cast cell to NewsTableViewCell")
        }
        cell.isUserInteractionEnabled = !element.isTemplateModel
        cell.isLoading = element.isTemplateModel
        if element.isTemplateModel { return cell }
        cell.title = element.title
        cell.subTitle = element.description
  
  //      if let imageURLString = element.imageURLString,
  //        let imageUrl = URL(string: imageURLString),
  //        let data = try? Data(contentsOf: imageUrl) {
  //        cell.icon = UIImage(data: data)
  //      }
        return cell
    })
  
  // MARK: - Initializers
  init() {
    networkService = NewsService(resource: topHeadLinesResource)
  }
  
  // MARK: - Methods
  func getNews() {
    networkService?.getNews()
  }
}
