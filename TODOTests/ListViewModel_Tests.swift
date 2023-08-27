//
//  ListViewModel_Tests.swift
//  TODOTests
//
//  Created by caseycheng on 2023/8/27.
//

import XCTest
@testable import TODO
final class ListViewModel_Tests: XCTestCase {
    var instance:ListViewModel?
    
    override func setUpWithError() throws {
        let vm = ListViewModel()
        vm.clearAll()
        instance = vm
    }

    override func tearDownWithError() throws {
        guard let vm = instance, instance != nil else {
            XCTFail("实例错误")
            return
        }
        vm.clearAll()
        instance = nil
    }
    
    func test_ListViewModel_clearData_shoudBeEmptyData(){
        guard let vm = instance, instance != nil else {
            XCTFail("实例错误")
            return
        }
        vm.clearAll()
        XCTAssertEqual(vm.items.count, 0)
    }



}
