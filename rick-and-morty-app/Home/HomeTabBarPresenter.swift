import Foundation
import UIKit

protocol HomeTabBarPresenterProtocol {
    func showValues(characterCellData: [CharacterCellData])
    func showError()
}

class HomeTabBarPresenter: HomeTabBarPresenterProtocol {
    
    private var view = HomeTabBarController()
    
    func showValues(characterCellData: [CharacterCellData]) {
        characterCellData.forEach { character in
            ImageDownloader.downloadImage(character.image) { _image, urlString in
                let cell = CharacterCell(image: _image ?? UIImage(), name: character.name)
                self.view.addSomeTabItems()
            }
        }
    }
    
    func showError() {
        print("erro")
    }
    
}

