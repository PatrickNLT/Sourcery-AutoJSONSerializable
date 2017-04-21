import XCTest
@testable import AutoJSONDeserializable

class AutoJSONDeserializableTests: XCTestCase {
    func test_singlePropertyDeserialization() {
        let jsonObject: [String: Any] = ["name": "value"]

        guard let object = SinglePropertyNoAnnotation(JSONObject: jsonObject) else {
            XCTFail()
            return
        }
        XCTAssertEqual(object.name, "value")
    }

    func test_singleAnnotatedPropertyDeserialization() {
        let jsonObject: [String: Any] = ["label": "value"]

        guard let object = SinglePropertyWithKeyPathAnnotation(JSONObject: jsonObject) else {
            XCTFail()
            return
        }
        XCTAssertEqual(object.name, "value")
    }

    func test_MultiTypesPropertiesDeserialization() {
        let jsonObject: [String: Any] = [
          "string": "value",
          "integer": 42,
          "double": 66.6
        ]

        guard let object = MultiTypesProperties(JSONObject: jsonObject) else {
            XCTFail()
            return
        }
        XCTAssertEqual(object.string, "value")
        XCTAssertEqual(object.integer, 42)
        XCTAssertEqual(object.double, 66.6)
    }

    func test_OptionalPropertyDeserialization() {
        let jsonObject: [String: Any] = ["name": NSNull()]

        guard let object = OptionalProperty(JSONObject: jsonObject) else {
            XCTFail()
            return
        }
        XCTAssertNil(object.name)
    }

    func test_JSONDeserializablePropertyDeserialization() {
        let jsonObject: [String: Any] = [
          "entity": ["name": "value"],
          "optionalEntity": ["name": "optionalValue"],
          "annotated_entity": ["name": "annotatedValue"],
          "optional_annotated_entity": ["name": "optionalAnnotatedValue"]
        ]

        guard let object = JSONDeserializableProperty(JSONObject: jsonObject) else {
            XCTFail()
            return
        }
        XCTAssertEqual(object.entity.name, "value")
        XCTAssertEqual(object.optionalEntity?.name, "optionalValue")
        XCTAssertEqual(object.annotatedEntity.name, "annotatedValue")
        XCTAssertEqual(object.optionalAnnotatedEntity?.name, "optionalAnnotatedValue")
        XCTAssertNil(object.nilEntity)
    }
}
