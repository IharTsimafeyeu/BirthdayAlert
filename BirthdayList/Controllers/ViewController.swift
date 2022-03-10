import UIKit

final class ViewController: UIViewController {
    // MARK: Private
    // MARK: - Properties
    var dataSource: [User] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    // MARK: Private
    // MARK: - Outlets
    private let tableView = UITableView()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        setupTableView()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let birthdays = CoreDataManager.instance.getBirthday() else { return }
        dataSource = birthdays
    }
    // MARK: Private
    // MARK: - Setups
    private func addSubviews() {
        view.addSubview(tableView)
    }
    private func setupUI() {
        view.backgroundColor = .systemGray5
        setupNavigationUI()
        tableView.backgroundColor = .clear
    }
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.rowHeight = 150
    }
    private func setupNavigationUI() {
        title = "Birthday List"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(selectBirthdayController))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteBirthday))
    }
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    // MARK: Private
    // MARK: - Actions
    @objc private func selectBirthdayController() {
        let selectBirthdayController = SelectBirthdayController()
        navigationController?.pushViewController(selectBirthdayController, animated: true)
    }
    
    @objc private func deleteBirthday() {
    }
}
//MARK: TableViewDelegate, TableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell {
            cell.setupUserData(params: dataSource[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
