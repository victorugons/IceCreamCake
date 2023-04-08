import UIKit

class StoreSortButton: UIButton {
    private var sortMenuState: SortMenuState = .defaultOrder
    var sortFunction: () -> Void = { }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    convenience init(sortFunction: @escaping () -> Void) {
        self.init()
        self.sortFunction = sortFunction
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getSortMenuState() -> SortMenuState {
        return sortMenuState
    }
    
    func performDefaultSort() {
        switch sortMenuState {
        case .defaultOrder:
            break
        case .alphabeticalOrder:
            toggleAlphabeticalSort()
            menu = getSortMenu()
        case .inverseAlphabeticalOrder:
            toggleInverseAlphabeticalSort()
            menu = getSortMenu()
        case .ratingOrder:
            toggleRatingSort()
            menu = getSortMenu()
        }
    }
    
    private func setupButton() {
        setImage(UIImage(systemName: "arrow.up.arrow.down"), for: .normal)
        tintColor = .darkGray
        showsMenuAsPrimaryAction = true
        menu = getSortMenu()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func getSortMenu() -> UIMenu {
        var alphabeticalOrderAction = UIAction(title: "Alfabética (A-Z)",
                                                         image: UIImage(systemName: "abc"),
                                                         state: .off) {
                            [weak self] (action) in
                            self?.toggleAlphabeticalSort()
                            self?.menu = self?.getSortMenu()
                        }
        var inverseAlphabeticalOrderAction = UIAction(title: "Alfabética (Z-A)",
                                                                                                 image: UIImage(systemName: "abc"),
                                                                                                 state: .off) {
                                                             [weak self] (action) in
                                                             self?.toggleInverseAlphabeticalSort()
                                                             self?.menu = self?.getSortMenu()
                                                         }
        var ratingOrderAction = UIAction(title: "Melhor avaliação",
                                         image: UIImage(systemName: "star.fill"),
                                         state: .off) {
                  [weak self] (action) in
                  self?.toggleRatingSort()
                  self?.menu = self?.getSortMenu()
              }
        
        switch sortMenuState {
        case .defaultOrder:
            break
        case .alphabeticalOrder:
            alphabeticalOrderAction = UIAction(title: "Alfabética (A-Z)",
                                             image: UIImage(systemName: "abc"),
                                             state: .on) {
                [weak self] (action) in
                self?.toggleAlphabeticalSort()
                self?.menu = self?.getSortMenu()
            }
        case .inverseAlphabeticalOrder:
            inverseAlphabeticalOrderAction = UIAction(title: "Alfabética (Z-A)",
                                                    image: UIImage(systemName: "abc"),
                                                    state: .on) {
                [weak self] (action) in
                self?.toggleInverseAlphabeticalSort()
                self?.menu = self?.getSortMenu()
            }
        case .ratingOrder:
            ratingOrderAction = UIAction(title: "Melhor avaliação",
                                       image: UIImage(systemName: "star.fill"),
                                       state: .on) {
                [weak self] (action) in
                self?.toggleRatingSort()
                self?.menu = self?.getSortMenu()
            }
        }
        return UIMenu(title: "Ordenar", children: [alphabeticalOrderAction, inverseAlphabeticalOrderAction, ratingOrderAction])
    }
    
    private func toggleAlphabeticalSort() {
        sortMenuState = sortMenuState == .alphabeticalOrder ? .defaultOrder : .alphabeticalOrder
        sortFunction()
    }
    
    private func toggleInverseAlphabeticalSort() {
        sortMenuState = sortMenuState == .inverseAlphabeticalOrder ? .defaultOrder : .inverseAlphabeticalOrder
        sortFunction()
    }
    
    private func toggleRatingSort() {
        sortMenuState = sortMenuState == .ratingOrder ? .defaultOrder : .ratingOrder
        sortFunction()
    }
}
