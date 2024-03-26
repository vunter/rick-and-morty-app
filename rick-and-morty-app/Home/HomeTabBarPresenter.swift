import Foundation
import UIKit

protocol HomeTabBarPresenterProtocol {
    func showValues(characterCellData: [CharacterCellData])
    func showError()
}

class HomeTabBarPresenter: HomeTabBarPresenterProtocol {
    
    private var view: CharacterViewProtocol?
    
    func showValues(characterCellData: [CharacterCellData]) {
        characterCellData.forEach { character in
            ImageDownloader.downloadImage(character.image) { _image, urlString in
                self.view?.cellImage = _image ?? UIImage()
                self.view?.cellName = character.name
                self.view?.buildCells()
            }
        }
    }
    
    func showError() {
        print("erro")
    }
    
}

