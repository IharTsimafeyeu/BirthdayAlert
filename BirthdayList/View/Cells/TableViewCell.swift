import UIKit

final class TableViewCell: UITableViewCell {

    // MARK: - Properties
    static let identifier = "TableViewCell"
    
    // MARK: Private
    // MARK: - Outlets
    private let mainView = UIView()
    private let nameLabel = UILabel()
    private let surnameLabel = UILabel()
    private let dateLabel = UILabel()
    
    private let mainStackView = UIStackView()
    private let nameSurnameStackView = UIStackView()
   
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        addConstraints()
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private
    // MARK: - Setups
    private func addSubviews() {
        contentView.addSubview(mainView)
        mainView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(nameSurnameStackView)
        mainStackView.addArrangedSubview(dateLabel)
        nameSurnameStackView.addArrangedSubview(nameLabel)
        nameSurnameStackView.addArrangedSubview(surnameLabel)
    }
    
    private func addConstraints() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
    }
    
    private func setupUI() {
        setupUIforMainView()
        setupMainStackView()
        setupNameLabel()
        setupSurnameLabel()
    }
    
    private func setupUIforMainView() {
        contentView.backgroundColor = .systemGray5
        mainView.backgroundColor = .white
        mainView.layer.cornerRadius = 10
        mainView.clipsToBounds = true
    }
    
    private func setupMainStackView() {
        mainStackView.axis = .horizontal
        mainStackView.alignment = .fill
        mainStackView.distribution = .fillEqually
        
        nameSurnameStackView.axis = .vertical
        nameSurnameStackView.alignment = .center
        nameSurnameStackView.distribution = .fillEqually
    }
    
    private func setupNameLabel() {
        nameLabel.textAlignment = .left
        nameLabel.font = .systemFont(ofSize: 20, weight: .medium)
        nameLabel.textColor = .black
    }
    
    private func setupSurnameLabel() {
        surnameLabel.textAlignment = .left
        surnameLabel.font = .systemFont(ofSize: 20, weight: .medium)
        surnameLabel.textColor = .black
    }
    
    private func setupDateLabel() {
        dateLabel.textAlignment = .center
        dateLabel.font = .systemFont(ofSize: 15, weight: .medium)
    }
    
    //MARK: Private
    //MARK: API
    func setupUserData(params: User) {
        nameLabel.text = params.name
        surnameLabel.text = params.surname
        dateLabel.text = params.date
    }
}
