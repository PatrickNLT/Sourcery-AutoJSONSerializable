enum IntEnumUsingStringSerde: Int, JSONSerializable, JSONDeserializable {
    case one = 0
    case two
    case six = 6

    init(JSONObject: Any) throws {
        guard let stringValue = JSONObject as? String,
            let intValue = Int(stringValue),
            let enumValue = IntEnumUsingStringSerde(rawValue: intValue) else {
            throw AutoJSONDeserializableError.typeMismatchError(String.self)
        }
        self = enumValue
    }

    func toJSONObject() -> Any {
        return "\(rawValue)"
    }
}

enum CustomSerdeEnum: JSONSerializable, JSONDeserializable {
    case chair
    case human(firstName: String, lastName: String)

    init(JSONObject: Any) throws {
        guard let stringValue = JSONObject as? String else {
            throw AutoJSONDeserializableError.typeMismatchError(String.self)
        }
        var components = stringValue.components(separatedBy: "|")
        guard let type = components.first else { throw Error.contentError(stringValue) }
        components.removeFirst()
        switch type {
        case "chair": self = .chair
        case "human":
            guard let firstName = components.first, let lastName = components.last else {
                throw Error.contentError(stringValue)
            }
            self = .human(firstName: firstName, lastName: lastName)
        default: throw Error.contentError(stringValue)
        }
    }

    func toJSONObject() -> Any {
        switch self {
        case .chair: return "chair"
        case let .human(firstName, lastName): return "human|\(firstName)|\(lastName)"
        }
    }

    enum Error: Swift.Error {
        case contentError(String)
    }
}

extension CustomSerdeEnum: Equatable {
    public static func == (lhs: CustomSerdeEnum, rhs: CustomSerdeEnum) -> Bool {
        switch (lhs, rhs) {
        case (.chair, .chair): return true
        case let (.human(lhsFirstName, lhsLastName), .human(rhsFirstName, rhsLastName)):
            return lhsFirstName == rhsFirstName && lhsLastName == rhsLastName
        default: return false
        }
    }
}

// sourcery: AutoJSONDeserializable, AutoJSONSerializable
struct EnumWithCustomSerdeProperties {
    let intEnumUsingStringSerde: IntEnumUsingStringSerde
    let customSerdeEnum: CustomSerdeEnum
    let optionalCustomSerdeEnum: CustomSerdeEnum?
}
