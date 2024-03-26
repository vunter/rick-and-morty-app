import Foundation

struct CharacterCellData {
    var image: String
    var name: String
}

protocol HomeTabBarInteractorProtocol {
    func fetch(completion: @escaping (Result<[CharacterCellData], Error>) -> Void)
}

class HomeTabBarInteractor: HomeTabBarInteractorProtocol {
    
    private var presenter: HomeTabBarPresenterProtocol?
    public var characterCellDataList: [CharacterCellData] = []
    let defaults = UserDefaults.standard
    
    init(presenter: HomeTabBarPresenterProtocol?) {
        self.presenter = presenter
    }
    
    func fetch(completion: @escaping (Result<[CharacterCellData], Error>) -> Void) {
        let apiManager = CharacterUseCase()
        
        apiManager.fetchData { [weak self] result in
            switch result {
            case .success(let success):
                success.results.forEach { character in
                    let characterCellData = CharacterCellData(image: character.image, name: character.name)
                    self?.characterCellDataList.append(characterCellData)
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

