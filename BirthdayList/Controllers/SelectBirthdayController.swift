import UIKit

enum PossibleErrors: Error {
    case overLimit
    case emptyField
}

final class SelectBirthdayController: UIViewController {
    // MARK: Private
    // MARK: - Outlets
    private let infoLabel = UILabel()
    private let nameTextField = UITextField()
    private let surnameTextField = UITextField()
    private let saveButton = UIButton()
    private let datePicker = UIDatePicker()
    private let mainStackView = UIStackView()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        addSubviews()
        addConstraints()
        setupUI()
    }
    // MARK: Private
    // MARK: - Setups
    private func addSubviews() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(infoLabel)
        mainStackView.addArrangedSubview(nameTextField)
        mainStackView.addArrangedSubview(surnameTextField)
        view.addSubview(datePicker)
        view.addSubview(saveButton)
    }
    private func addConstraints() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: datePicker.topAnchor, constant: -20).isActive = true
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 150).isActive = true
    
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
    private func setupUI() {
        title = "New Info"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupMainStackView()
        setupInfoLabel()
        setupDatePickerUI()
        setupTextFieldsUI()
        setupSaveButtonUI()
        setupInfoLabel()
    }
    private func setupTextFieldsUI() {
        nameTextField.placeholder = "Name"
        surnameTextField.placeholder = "Surname"
        
        nameTextField.textAlignment = .center
        surnameTextField.textAlignment = .center
        
        nameTextField.backgroundColor = .white
        surnameTextField.backgroundColor = .white
        
        nameTextField.font = .systemFont(ofSize: 25, weight: .medium)
        surnameTextField.font = .systemFont(ofSize: 25, weight: .medium)
        
        nameTextField.layer.cornerRadius = 10
        surnameTextField.layer.cornerRadius = 10
    }
    private func setupMainStackView() {
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 10
    }
    private func setupDatePickerUI() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
    }
    private func setupSaveButtonUI() {
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        saveButton.backgroundColor = .white
        saveButton.layer.cornerRadius = 10
    }
    private func setupInfoLabel() {
        infoLabel.text = "Enter some information below:"
        infoLabel.textAlignment = .center
    }
    private func alertForFilmName(_ msg: String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.nameTextField.setUnderLine(.red)
            self.surnameTextField.setUnderLine(.red)
        }))
        present(alert, animated: true, completion: nil)
    }
    //MARK: Private
    //MARK: - Helpers
    private func checkText() throws {
        if nameTextField.text?.isEmpty == true || surnameTextField.text?.isEmpty == true {
            throw PossibleErrors.emptyField
        }
        if let text = nameTextField.text?.count, let text2 = surnameTextField.text?.count {
            if (text >= 15) || (text2 >= 15) {
                throw PossibleErrors.overLimit
            }
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        let user = User(name: nameTextField.text ?? "",
                        surname: surnameTextField.text ?? "",
                        date: formatter.string(from: datePicker.date))
        CoreDataManager.instance.saveBirthday(user)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: Private
    // MARK: - Actions
    @objc private func saveAction() {
        do {
            try checkText()
        } catch PossibleErrors.emptyField {
            alertForFilmName("Please fill movie name")
        } catch PossibleErrors.overLimit {
            alertForFilmName("It's incorrect text")
        } catch {
            print("Unexpected error")
        }
    }
}
