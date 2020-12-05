//
//  Article+CoreDataClass.swift
//  Pods
//
//  Created by Ivan Levin on 04/12/20.
//
//

import Foundation
import CoreData

@available(iOS 10.0, *)
public class ArticleManager {
    private enum Values {
        static let title = "title"
        static let content = "content"
        static let language = "language"
        static let dateOfCreation = "dateOfCreation"
        static let dateOfModification = "dateOfModification"
        static let image = "image"
        static let article = "Article"
    }
    
    let context:NSManagedObjectContext
    
    public func newArticle(title:String, content:String, language:String, image:NSData?) -> Article {
        let doc = Date()
        let dom = Date()
        let art = Article(context: context)
        art.setValue(title, forKey: ArticleManager.Values.title)
        art.setValue(content, forKey: ArticleManager.Values.content)
        art.setValue(language, forKey: ArticleManager.Values.language)
        art.setValue(doc, forKey: ArticleManager.Values.dateOfCreation)
        art.setValue(dom, forKey: ArticleManager.Values.dateOfModification)
        art.setValue(image, forKey: ArticleManager.Values.image)
        return art
    }
    
    public func getAllArticles() -> [Article] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ArticleManager.Values.article)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            if let results = try context.fetch(fetchRequest) as? [Article] {
                return results
            }
        } catch {
            print ("There was a fetch error!")
        }
        return []
    }
    
    public func getArticles(withLang lang : String) -> [Article] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ArticleManager.Values.article)
        fetchRequest.returnsObjectsAsFaults = false
        var arrayArticle:[Article] = []
        
        do {
            if let results = try context.fetch(fetchRequest) as? [Article] {
                for res in results {
                    if let r = res.language {
                        if (r == lang) {
                            arrayArticle.append(res)
                        }
                    }
                }
                return arrayArticle
            }
        } catch {
            print ("There was a fetch error!")
        }
        return []
    }
    
    public func getArticles(containString str : String) -> [Article] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ArticleManager.Values.article)
        fetchRequest.returnsObjectsAsFaults = false
        var arrayArticle:[Article] = []
        var appended:Bool = false
        
        do {
            if let results = try context.fetch(fetchRequest) as? [Article] {
                let tmpstr = str.lowercased()
                for res in results {
                    appended = false
                    if let title = res.title {
                        if title.lowercased().range(of:tmpstr) != nil {
                            arrayArticle.append(res)
                            appended = true
                        }
                    }
                    if let content = res.content {
                        if content.lowercased().range(of: tmpstr) != nil && appended == false {
                            arrayArticle.append(res)
                        }
                    }
                }
                return arrayArticle
            }
        }
        catch {
            print ("There was a fetch error!")
        }
        return []
    }
    
    public func removeArticle(article : Article) {
        context.delete(article)
    }
    
    public func save() {
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error)")
        }
    }
    
    public init() {
        let myBundle = Bundle(for:Article.self)
        
        let modelURL = myBundle.url(forResource: "article", withExtension: "momd")
        guard let model = NSManagedObjectModel(contentsOf: modelURL!) else { fatalError("model not found") }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        let storeURL = try! FileManager
            .default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("article.sqlite")
        
        try! psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        
        context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = psc
    }
}
