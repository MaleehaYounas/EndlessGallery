import Foundation
@MainActor
class BaseViewModel<T: Decodable>: ObservableObject {
    @Published var data: T?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetch(from endpoint: EndPoints) {
        isLoading = true
        Task {
            do {
                let result: T = try await APIService.shared.fetchData(urlString: endpoint.getEndPoint())
                DispatchQueue.main.async {
                    self.data = result
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
}
