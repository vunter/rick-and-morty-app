import Foundation
import UIKit

protocol CharacterPresenterProtocol {
    func showValues(characterCellData: [CharacterCellData])
    func showError()
}

class CharacterPresenter: CharacterPresenterProtocol {
    
    private var view: CharacterViewProtocol?
    
    init(view: CharacterViewProtocol) {
        self.view = view
    }
    
    func showValues(characterCellData: [CharacterCellData]) {
        characterCellData.forEach { character in
            ImageDownloader.downloadImage(character.image) { _image, urlString in
                let cell = CharacterCell(image: _image ?? UIImage(), name: character.name)
                self.view?.buildCells(characterCellData: cell)
            }
        }
    }
    
    func showError() {
        print("erro")
    }
    
}
