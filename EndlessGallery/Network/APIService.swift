import Foundation

enum APIServiceError: Error, LocalizedError {
    case badURL
    case badStatus(code: Int)
    case emptyData

    var errorDescription: String? {
        switch self {
        case .badURL: return "Invalid URL"
        case .badStatus(let code): return "Server responded with status \(code)"
        case .emptyData: return "Empty response"
        }
    }
}

class APIService {
    static let shared = APIService()
    private init() {}

    func fetchData<T: Decodable>(urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw APIServiceError.badURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let http = response as? HTTPURLResponse,
              (200...299).contains(http.statusCode) else {
            throw APIServiceError.badStatus(code: (response as? HTTPURLResponse)?.statusCode ?? -1)
        }

        guard !data.isEmpty else {
            throw APIServiceError.emptyData
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
}
