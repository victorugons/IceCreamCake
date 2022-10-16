import UIKit

final class AppCoordinator: Coordinator {
    var childCoordinators: [BaseCoordinator] = []
    var rootViewController: UITabBarController
    
    init(rootViewController: UITabBarController) {
        self.rootViewController = rootViewController
    }
    func start() {
        let salgadosCoordinator = StoreListCoordinator(of: .salgados)
        salgadosCoordinator.start()
        
        let docesCoordinator = StoreListCoordinator(of: .doces)
        docesCoordinator.start()
        
        let bebidasCoordinator = StoreListCoordinator(of: .bebidas)
        bebidasCoordinator.start()
        
        salgadosCoordinator.rootViewController.tabBarItem = UITabBarItem(
            title: "Salgados",
            image: UIImage(named: ""),
            tag: 0
        )
        
        docesCoordinator.rootViewController.tabBarItem = UITabBarItem(
            title: "Doces",
            image: UIImage(named: ""),
            tag: 1
        )
        
        bebidasCoordinator.rootViewController.tabBarItem = UITabBarItem(
            title: "Bebidas",
            image: UIImage(named: ""),
            tag: 2
        )
        
        rootViewController.viewControllers = [
            salgadosCoordinator.rootViewController,
            docesCoordinator.rootViewController,
            bebidasCoordinator.rootViewController
        ]
    }
    
    
}
