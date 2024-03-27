import Foundation

protocol CharacterInteractorProtocol {
    func returnNumberOfCount() -> Int
}

class CharacterInteractor: CharacterInteractorProtocol {
    
    private var presenter: CharacterPresenterProtocol?
    public var characterCellDataList: [CharacterCellData] = []
    let defaults = UserDefaults.standard
    
    func returnNumberOfCount() -> Int {
        let savedCount = defaults.object(forKey: "CharacteresCount") as? Int ?? 1
        return savedCount
    }
}
