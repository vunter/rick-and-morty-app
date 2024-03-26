import Foundation
import UIKit

protocol HomeTabBarPresenterProtocol {
    func showValues(characterCellData: [CharacterCellData])
    func showError()
}

class HomeTabBarPresenter: HomeTabBarPresenterProtocol {
    
    private var view: TabBarViewProtocol?
    
    func showValues(characterCellData: [CharacterCellData]) {
        characterCellData.forEach { character in
            ImageDownloader.downloadImage(character.image) { _image, urlString in
                let characterCellData = CharacterCellData(image: character.image, name: character.name)
                self.view?.characterCellData.append(characterCellData)
            }
        }
    }
    
    func showError() {
        print("erro")
    }
    
}

