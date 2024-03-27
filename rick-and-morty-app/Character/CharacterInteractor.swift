import Foundation

protocol CharacterInteractorProtocol {
    func fetch(completion: @escaping () -> Void)
    func returnNumberOfCount() -> Int
}

class CharacterInteractor: CharacterInteractorProtocol {
    
    private var presenter: CharacterPresenterProtocol?
    public var characterCellDataList: [CharacterCellData] = []
    let defaults = UserDefaults.standard
    
    init(presenter: CharacterPresenterProtocol) {
        self.presenter = presenter
    }
    
    func fetch(completion: @escaping () -> Void) {
        let apiManager = CharacterUseCase()
        
        apiManager.fetchData { [weak self] result in
            switch result {
            case .success(let success):
                success.forEach { character in
                    let characterCellData = CharacterCellData(image: character.image, name: character.name)
                    self?.characterCellDataList.append(characterCellData)
                }
                completion()
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
