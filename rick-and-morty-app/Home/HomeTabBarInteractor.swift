import Foundation

struct CharacterCellData {
    var image: String
    var name: String
}

protocol HomeTabBarInteractorProtocol {
    func fetch(completion: @escaping (Result<[Character], Error>) -> Void)
}

class HomeTabBarInteractor: HomeTabBarInteractorProtocol {
    
    var presenter: HomeTabBarPresenterProtocol?
    public var characterCellDataList: [CharacterCellData] = []
    let defaults = UserDefaults.standard
    
    func fetch(completion: @escaping (Result<[Character], Error>) -> Void) {
        let apiManager = CharacterUseCase()
        
        apiManager.fetchData { [weak self] result in
            switch result {
            case .success(let success):
                success.forEach { character in
                    let characterCellData = CharacterCellData(image: character.image, name: character.name)
                    self?.characterCellDataList.append(characterCellData)
                }
                self?.presenter?.showValues(characterCellData: self?.characterCellDataList ?? [])
                completion(.success(success))
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

