//
//  DatastoreTests.swift
//  
//
//  Created by Arman Arutiunov on 20/08/2023.
//

@testable import Datastore
import XCTest

final class DatastoreTests: XCTestCase {

    // MARK: - Properties

    let decodableObject = MockCodableObject(id: "abcd", value: "Test Object 0")

    // MARK: - Life Cycle

    override func tearDown() {
        Datastore.deleteAll(of: MockCodableObject.self)
        super.tearDown()
    }

    // MARK: - Tests

    func testSaveAndLoad() {
        Datastore.save(decodableObject, key: decodableObject.id)

        let loaded: MockCodableObject? = Datastore.load(key: decodableObject.id)
        XCTAssertTrue(loaded != nil, "Object wasn't saved and loaded from the datastore")

        // Assert saved on disk
        let path = Path<MockCodableObject>().item(decodableObject.id)
        XCTAssertTrue(FileManager.default.fileExists(atPath: path))
    }

    func testSaveAndDelete() {
        Datastore.save(decodableObject, key: decodableObject.id)
        Datastore.delete(key: decodableObject.id, type: MockCodableObject.self)

        let loaded: MockCodableObject? = Datastore.load(key: decodableObject.id)
        XCTAssertTrue(loaded == nil, "Object was not deleted")

        // Assert deleted from disk
        let path = Path<MockCodableObject>().item(decodableObject.id)
        XCTAssertFalse(FileManager.default.fileExists(atPath: path))
    }

    func testDeleteAllByType() {
        let objects = [
            MockCodableObject(id: "123", value: "456"),
            MockCodableObject(id: "456", value: "789")
        ]

        for object in objects {
            Datastore.save(object, key: object.id)
        }
        Datastore.deleteAll(of: MockCodableObject.self)

        for object in objects {
            let loaded: MockCodableObject? = Datastore.load(key: object.id)
            XCTAssertNil(loaded)
        }

        // Assert removed from disk
        let path = Path<MockCodableObject>().folderPath
        let keys = try! FileManager.default.contentsOfDirectory(atPath: path)
        XCTAssertTrue(keys.isEmpty)
    }

    func testDeleteSingleObject() {
        let objects = [
            MockCodableObject(id: "0123", value: "Test Object 1"),
            MockCodableObject(id: "4567", value: "Test Object 2")
        ]

        for object in objects {
            Datastore.save(object, key: object.id)
        }

        Datastore.delete(key: objects[0].id, type: MockCodableObject.self)

        let firstLoaded: MockCodableObject? = Datastore.load(key: objects[0].id)
        XCTAssertNil(firstLoaded)

        let secondLoaded: MockCodableObject? = Datastore.load(key: objects[1].id)
        XCTAssertNotNil(secondLoaded)
        XCTAssertEqual(secondLoaded?.id, "4567")

        // Assert removed from disk
        let path = Path<MockCodableObject>().folderPath
        let keys = try! FileManager.default.contentsOfDirectory(atPath: path)
        XCTAssertEqual(keys.count, 1)
    }

    func testUpdateObject() {
        // Save initial objects
        let key: String = "0123"
        let objects = [
            MockCodableObject(id: key, value: "Foo"),
            MockCodableObject(id: "4567", value: "Foo")
        ]
        for object in objects {
            Datastore.save(objects, key: object.id)
        }

        // Update one of the objects
        let expectedValue = "Bar"
        let updatedObject = MockCodableObject(id: key, value: expectedValue)
        Datastore.save(updatedObject, key: key)

        // Assert changes have been made
        let loaded: MockCodableObject = Datastore.load(key: key)!
        XCTAssertEqual(loaded.value, expectedValue)

        // Assert changes have been made on hard drive
        let path = Path<MockCodableObject>().item(key)
        guard let data = FileManager.default.contents(atPath: path),
              let unarchiver = try? NSKeyedUnarchiver(forReadingFrom: data) else {
            XCTFail("Failed to unarchive object")
            return
        }

        let hardDrive = unarchiver.decodeDecodable(MockCodableObject.self, forKey: key)
        unarchiver.finishDecoding()

        XCTAssertNotNil(hardDrive)
        XCTAssertEqual(hardDrive?.value, expectedValue)
    }
}
