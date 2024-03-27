import Foundation
import UIKit

protocol HomeTabBarPresenterProtocol {
    func showValues(characterCellData: [CharacterCellData])
    func showError()
}

class HomeTabBarPresenter: HomeTabBarPresenterProtocol {
    
    private var view: TabBarViewProtocol?
    
    init(view: TabBarViewProtocol?) {
        self.view = view
    }
    
    func showValues(characterCellData: [CharacterCellData]) {
        characterCellData.forEach { character in
            ImageDownloader.downloadImage(character.image) { _image, urlString in
                let cell = CharacterCell(image: _image ?? UIImage(), name: character.name)
                self.view?.addSomeTabItems(characterCell: cell)
            }
        }
    }
    
    func showError() {
        print("erro")
    }
    
}

