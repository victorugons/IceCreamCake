import UIKit

protocol BaseCoordinator {
    func start()
}
protocol Coordinator: BaseCoordinator {
    associatedtype UIViewControllerType = UIViewController
    
    var childCoordinators: [BaseCoordinator] { get set }
    var rootViewController: UIViewControllerType { get set }
}
