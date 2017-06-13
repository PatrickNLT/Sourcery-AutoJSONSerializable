import Foundation

struct ArrayProperty: AutoJSONDeserializable, AutoJSONSerializable {
    let array: [MultiTypesProperties]
}

struct DateArrayProperty: AutoJSONDeserializable, AutoJSONSerializable {
    let dateArray: [Date]
}

struct BasicTypesArrayProperty: AutoJSONDeserializable, AutoJSONSerializable {
    let doubleArray: [Double]
    let integerArray: [Int]
    let stringArray: [String]
}