import Foundation

struct CharacterCellData {
    var image: String
    var name: String
}

protocol HomeTabBarInteractorProtocol {
    func fetch(completion: @escaping (Result<[CharacterCellData], Error>) -> Void)
}

class HomeTabBarInteractor: HomeTabBarInteractorProtocol {
    
    var presenter: HomeTabBarPresenterProtocol?
    public var characterCellDataList: [CharacterCellData] = []
    let defaults = UserDefaults.standard
    
    func fetch(completion: @escaping (Result<[CharacterCellData], Error>) -> Void) {
        let apiManager = CharacterUseCase()
        
        apiManager.fetchData { [weak self] result in
            switch result {
            case .success(let success):
                success.results.forEach { character in
                    completion(.success(self?.characterCellDataList ?? []))
                    self?.presenter?.showValues(characterCellData: self?.characterCellDataList ?? [])
                }
            case .failure(_):
                self?.presenter?.showError()
            }
        }
    }
    
    func returnNumberOfCount() -> Int {
        let savedCount = defaults.object(forKey: "CharacteresCount") as? Int ?? 1
        return savedCount
    }
}

