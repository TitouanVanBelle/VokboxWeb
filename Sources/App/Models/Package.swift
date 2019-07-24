import FluentPostgreSQL
import Vapor

/// A single entry of a Package list.
final class Package: PostgreSQLModel
{
    var id: Int?
    var name: String
    var words: [String]?
    var readyForProcessing: Bool?

    var isValid: Bool {
        guard let words = words else {
            return false
        }

        for word in words {
            if word.isEmpty {
                return false
            }
        }

        return true
    }

    init(id: Int? = nil, name: String, words: [String]? = nil, readyForProcessing: Bool = false)
    {
        self.id = id
        self.name = name
        self.words = words
        self.readyForProcessing = readyForProcessing
    }
}

extension Package
{
    var translationsLists: Children<Package, TranslationsList> {
        return children(\.packageId)
    }
}

/// Allows `Package` to be used as a dynamic migration.
extension Package: Migration { }

/// Allows `Package` to be encoded to and decoded from HTTP messages.
extension Package: Content { }

/// Allows `Package` to be used as a dynamic parameter in route definitions.
extension Package: Parameter { }
