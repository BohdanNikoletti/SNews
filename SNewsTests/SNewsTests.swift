//
//  SNewsTests.swift
//  SNewsTests
//
//  Created by Soft Project on 4/20/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import XCTest
import Quick
import Nimble
import RxSwift
import RxTest
import RxCocoa
import RxBlocking
import Alamofire
import RxAlamofire

@testable import SNews

final class AuthorizationSpec: QuickSpec {
  override func spec() {
    describe("News Feed") {
      var networkService: NetworkService<TopHeadLinesResource>!

      describe("Default settings") {
        it("with correct data") {
          let topHeadLinesResource = TopHeadLinesResource(category: TopHeadLinesResource.Category.business)
          networkService = NewsService(resource: topHeadLinesResource)
          do {
            let networkResponse = try networkService.request?.get()
              .toBlocking()
              .first()
            expect(networkResponse).toNot(beNil())
            expect(networkResponse?.data).toNot(beNil())
            expect(networkResponse?.data?.count == 20).to(beTrue())
          } catch {
            fail(error.localizedDescription)
          }
          
        }
        it("with wrong data") {
          let topHeadLinesResource = TopHeadLinesResource(category: TopHeadLinesResource.Category.mock)
          networkService = NewsService(resource: topHeadLinesResource)
          do {
            let networkResponse = try networkService.request?.get()
              .toBlocking()
              .first()
            expect(networkResponse).toNot(beNil())
            expect(networkResponse?.data).to(beNil())
          } catch {
            fail(error.localizedDescription)
          }
        }
      }
    }
  }
}
