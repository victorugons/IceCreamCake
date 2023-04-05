import UIKit

class FilterViewController: UIViewController {
    
    var viewModel: FilterViewModelProtocol
    var delegate: FilterDelegate?
    
    private lazy var filterTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var removeFilterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 0.7025669643)
        button.setTitle("Remover filtro", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.titleLabel?.tintColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(removeFilter), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(viewModel: FilterViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Filtrar por categoria"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        view.addSubview(filterTableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        setupFilterTableViewConstraints()
        if (viewModel.state) != nil {
            setupRemoveFilterButtonConstraints()
            NSLayoutConstraint.activate([
                removeFilterButton.topAnchor.constraint(equalTo: filterTableView.bottomAnchor, constant: 16)
            ])
        }
        else {
            NSLayoutConstraint.activate([
                filterTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
            ])
        }
    }
    
    private func setupFilterTableViewConstraints() {
        NSLayoutConstraint.activate([
            filterTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            filterTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            filterTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64)
        ])
    }
    
    private func setupRemoveFilterButtonConstraints() {
        view.addSubview(removeFilterButton)
        NSLayoutConstraint.activate([
            removeFilterButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            removeFilterButton.heightAnchor.constraint(equalToConstant: 40),
            removeFilterButton.widthAnchor.constraint(equalToConstant: 200),
            removeFilterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc
    private func removeFilter() {
        viewModel.state = nil
        delegate?.removeFilter()
        dismiss(animated: true)
    }
}
