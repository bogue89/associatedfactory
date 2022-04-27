import XCTest
@testable import AssociatedFactory

final class AssociatedFactoryTests: XCTestCase {

    public static var inMemory = true

    func testValue() throws {
        let object = CustomObject()
        object.title = "Title!"
        object.subtitle = "Sub-\(object.title)"
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertNotEqual(object.subtitle, "")
    }

    func testObjectRetention() throws {
        Self.inMemory = false
        let object: CustomObject! = CustomObject()
        object.title = "Title!"
        object.subtitle = "Sub-\(object.title)"

        XCTAssertTrue(Self.inMemory, "Associated object is not in memory")
    }


    func testObjectRelease() throws {
        Self.inMemory = true
        var object: CustomObject! = CustomObject()
        object.title = "Title!"
        object.subtitle = "Sub-\(object.title)"
        object = nil
        XCTAssertFalse(Self.inMemory, "Associated should not be in memory")
    }
}

final class CustomObject {
    var title: String = ""
}

final class CustomPropery {
    var value: String = ""

    init() {
        AssociatedFactoryTests.inMemory = true
    }
    deinit {
        AssociatedFactoryTests.inMemory = false
    }
}

let factory: AssociatedFactory<CustomPropery> = .init()

extension CustomObject {
    // Extensions must not contain stored propertie
    // var subtitle: NSString = ""

    // computed value retrieves associated object
    var associatedObject: CustomPropery! {
        factory.instance(self, initializer: { CustomPropery() }, policy: .OBJC_ASSOCIATION_RETAIN)
    }

    // convenient access to property wrapper class
    var subtitle: String {
        get {
            associatedObject.value
        }
        set {
            associatedObject.value = newValue
        }
    }
}
