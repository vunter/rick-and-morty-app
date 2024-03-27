import Foundation

enum CharacterFactory {
    case instance
    
    func build() -> CharacterViewController {
        let view = CharacterViewController()
        let presenter = CharacterPresenter(view: view)
        let interactor = CharacterInteractor(presenter: presenter)
        
        view.interactor = interactor
        
        return view
    }
}
