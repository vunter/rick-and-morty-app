import Foundation

enum HomeTabBarFactory {
    case instance
    
    func build() -> HomeTabBarController {
        let interactor = HomeTabBarInteractor()
        let view = HomeTabBarController(characterCellData: [], interactor: interactor)
        let presenter = HomeTabBarPresenter()
        
        interactor.presenter = presenter
        
        return view
    }
}
