import Foundation

enum DataError: Error {
    case invalidData
    case invalidResponse
    case message(_ error: Error?)
}

class CharacterUseCase {
    
    let defaults = UserDefaults.standard

    func fetchData(completion: @escaping (Result<CharacterResponse, DataError>) -> Void) {
        let url = URL(string: "https://rickandmortyapi.com/api/character")
        guard let url = url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data else {
                completion(.failure(.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse, 200 ... 299  ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let characteres = try JSONDecoder().decode(CharacterResponse.self, from: data)
                self.defaults.setValue(characteres.results.count, forKey: "CharacteresCount")
                completion(.success(characteres))
            }
            catch {
                completion(.failure(.message(error)))
            }
        }.resume()
    }
}
