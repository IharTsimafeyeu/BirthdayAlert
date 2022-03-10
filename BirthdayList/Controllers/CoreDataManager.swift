import CoreData
import UIKit

final class CoreDataManager {
    static let instance = CoreDataManager()
    func saveBirthday(_ user: User) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ModelEntity", in: managedContext)!
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        person.setValue(user.name, forKey: "name")
        person.setValue(user.surname, forKey: "surname")
        person.setValue(user.date, forKey: "date")
        do {
            try managedContext.save()
            print("Saved")
        } catch let error as NSError {
            print("Error - \(error)")
        }
    }
    func getBirthday() -> [User]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ModelEntity")
        do {
            let objects = try managedContext.fetch(fetchRequest)
            var users = [User]()
            for object in objects {
                guard let name = object.value(forKey: "name") as? String,
                      let surname = object.value(forKey: "surname") as? String,
                      let date = object.value(forKey: "date") as? String
                else { return nil }
                let user = User(name: name, surname: surname, date: date)
                users.append(user)
            }
            return users
        } catch let error as NSError {
            print("Error - \(error)")
        }
        return nil
    }
    private init() {}
}

