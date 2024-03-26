import Foundation

enum HomeTabBarFactory {
    case instance
    
    func build() -> HomeTabBarController {
        let view = HomeTabBarController()
        let presenter = HomeTabBarPresenter()
        let interactor = HomeTabBarInteractor(presenter: presenter)
        
        view.interactor = interactor
        
        return view
    }
}
