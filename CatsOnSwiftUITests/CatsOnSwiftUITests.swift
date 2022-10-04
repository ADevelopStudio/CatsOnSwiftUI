//
//  CatsOnSwiftUITests.swift
//  CatsOnSwiftUITests
//
//  Created by Dmitrii Zverev on 2/10/2022.
//

import XCTest
@testable import CatsOnSwiftUI

final class CatsOnSwiftUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - Testing Mocks

    func testMocks() throws {
        let _ = Breed.example
        let _ = BreedImage.examples
        let _ = BreedImage.examples.first!
    }
    
    // MARK: - Testing APIs
    
    func testApi() async {
        let service: NetworkService = ConnectionManager.shared
        let promiseValidDataBreeds = expectation(description: "Data from API is correct")
        let promiseValidDataImages = expectation(description: "Object from API is correct")
        do {
            let _ = try await service.fetchBreeds(parameters: GetBreedsRequest(page: 1))
            promiseValidDataBreeds.fulfill()
        } catch {
            print("Error:", error)
            XCTFail(error.localizedDescription)
        }
        
        do {
            let _ = try await service.fetchImages(parameters: GetCatImagesRequest())
            promiseValidDataImages.fulfill()
        } catch {
            print("Error:", error)
            XCTFail(error.localizedDescription)
        }
        wait(for: [promiseValidDataBreeds, promiseValidDataImages], timeout: 10)
    }
    
    
    // MARK: - Testing GalleryViewModel
    
    func testGalleryViewModelGoodAPI() async {
        // Good network
        let vm: any GalleryViewModel = GalleryViewModelImpl(breed: .example)
        XCTAssertTrue(vm.breed.id == Breed.example.id)
        XCTAssertTrue(vm.images.isEmpty)
        XCTAssertTrue(vm.loadingState == .loading)
        XCTAssertFalse(vm.isBreedListFull)
        
        await vm.fetchImages()
        XCTAssertTrue(vm.loadingState == .idle)
        XCTAssertFalse(vm.images.isEmpty)
        
        await vm.loadNextPage()
        XCTAssertTrue(vm.loadingState == .idle)
    }
    
    func testGalleryViewModelErrorAPI() async {
        // Error in network call
        let error: Error = ServiceError.generalFailure
        let vm: any GalleryViewModel = GalleryViewModelImpl(breed: .example, service: FailingConnectionManager(error: error))
        XCTAssertTrue(vm.breed.id == Breed.example.id)
        XCTAssertTrue(vm.images.isEmpty)
        XCTAssertTrue(vm.loadingState == .loading)
        XCTAssertFalse(vm.isBreedListFull)
        
        await vm.fetchImages()
        XCTAssertTrue(vm.loadingState == .failed(error))
        XCTAssertTrue(vm.images.isEmpty)
        XCTAssertTrue(vm.isBreedListFull)
        
        await vm.loadNextPage()
        XCTAssertTrue(vm.loadingState == .failed(error))
        XCTAssertTrue(vm.images.isEmpty)
        XCTAssertTrue(vm.isBreedListFull)
    }
    
    // MARK: - Testing BreedsViewModel
    
    func testBreedsViewModelGoodAPI() async {
        // Good network
        let vm: any BreedsViewModel = BreedsViewModelImpl()
        XCTAssertTrue(vm.breeds.isEmpty)
        XCTAssertTrue(vm.loadingState == .idle)
        XCTAssertFalse(vm.isBreedListFull)
        
        await vm.startFetching()
        XCTAssertTrue(vm.loadingState == .idle)
        XCTAssertFalse(vm.breeds.isEmpty)
        
        await vm.loadNextPage()
        XCTAssertTrue(vm.loadingState == .idle)
        XCTAssertFalse(vm.breeds.isEmpty)
    }
    
    func testBreedsViewModelErrorAPI() async {
        // Error in network call
        let error: Error = ServiceError.invalidUrl
        let vm: any BreedsViewModel = BreedsViewModelImpl(service: FailingConnectionManager(error: error))
        XCTAssertTrue(vm.breeds.isEmpty)
        XCTAssertTrue(vm.loadingState == .idle)
        XCTAssertFalse(vm.isBreedListFull)
        
        await vm.startFetching()
        XCTAssertTrue(vm.loadingState == .failed(error))
        XCTAssertTrue(vm.breeds.isEmpty)
        XCTAssertTrue(vm.isBreedListFull)

        await vm.loadNextPage()
        XCTAssertTrue(vm.loadingState == .failed(error))
        XCTAssertTrue(vm.breeds.isEmpty)
        XCTAssertTrue(vm.isBreedListFull)
    }
    
    
    // MARK: - Testing BreedDelailsViewModel
    
    func testBreedDelailsViewModelGoodAPI() async {
        // Good network
        let vm: any BreedDelailsViewModel = BreedDelailsViewModelImpl(breed: .example)
        
        XCTAssertTrue(vm.breed.id == Breed.example.id)
        XCTAssertTrue(vm.loadingState == .loading)
        XCTAssertTrue(vm.images.isEmpty)
        
        await vm.fetchImages()
        XCTAssertTrue(vm.loadingState == .idle)
        XCTAssertFalse(vm.images.isEmpty)
    }
    
    func testBreedDelailsViewModelErrorAPI() async {
        // Error in network call
        let error: Error = ServiceError.invalidStatus
        let vm: any BreedDelailsViewModel = BreedDelailsViewModelImpl(breed: .example, service: FailingConnectionManager(error: error))
        
        XCTAssertTrue(vm.breed.id == Breed.example.id)
        XCTAssertTrue(vm.loadingState == .loading)
        XCTAssertTrue(vm.images.isEmpty)
        
        await vm.fetchImages()
        XCTAssertTrue(vm.loadingState == .failed(error))
        XCTAssertTrue(vm.images.isEmpty)
    }
    
    // MARK: - Testing Localisation
    func testLocalisation() throws {
        BreedsViewStrings.allCases.testLocalisation()
        CarouselViewStrings.allCases.testLocalisation()
        BreedDelailsViewStrings.allCases.testLocalisation()
        BreedStrings.allCases.testLocalisation()
        ServiceErrorStrings.allCases.testLocalisation()
    }
}



extension Array where Element: RawRepresentable<String> {
    func testLocalisation() {
        self.forEach { $0.testLocalisation() }
    }
}

extension RawRepresentable where RawValue == String {
    fileprivate func testLocalisation() {
        XCTAssertTrue(localised != rawValue, "localised: \(localised) rawValue: \(rawValue)")
        XCTAssertTrue(rawValue.localised != rawValue, "rawValue.localised: \(rawValue.localised) rawValue: \(rawValue)")
        XCTAssertTrue(rawValue.localised == localised, "rawValue.localised: \(rawValue.localised) localised: \(localised)")
    }
}
