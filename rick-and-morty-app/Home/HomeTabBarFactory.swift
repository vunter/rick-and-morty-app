import Foundation

enum HomeTabBarFactory {
    case instance
    
    func build() -> HomeTabBarController {
        let interactor = HomeTabBarInteractor()
        let view = HomeTabBarController()
        let presenter = HomeTabBarPresenter(view: view)
        
        view.interactor = interactor
        
        return view
    }
}
