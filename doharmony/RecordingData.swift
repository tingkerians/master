
import CoreData
import UIKit


class RecordingData{
    
    let app:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var context:NSManagedObjectContext!

    init(){
        context = app.managedObjectContext
    }
    
    func insert(entity:String,values:[String:AnyObject]){
        let Entity = NSEntityDescription.entityForName(entity, inManagedObjectContext: context)
        let object = NSManagedObject(entity: Entity!, insertIntoManagedObjectContext: context)
        for data in values{
            //data.0 = key , data.1 = value
            object.setValue(data.1, forKey: data.0)
        }
        commit()
    }
    
    func fetch(entity:String, predicate:NSPredicate?)->[NSManagedObject]{
        var res:[NSManagedObject]!
        do{
            let fetch = NSFetchRequest(entityName: entity)
            if predicate != nil{
                fetch.predicate = predicate
            }
            res = try context.executeFetchRequest(fetch) as! [NSManagedObject]
        }catch{
            NSLog("Er: fetch",entity,"failed")
        }
        return res
    }
    
    func update(entity:String, predicate:NSPredicate, value:AnyObject?, key:String){
        do{
            let fetch = NSFetchRequest(entityName: entity)
            fetch.predicate = predicate
            let result = try context.executeFetchRequest(fetch)[0] as! NSManagedObject
            result.setValue(value, forKey: key)
        }catch{
            NSLog("Er: Update failed")
        }
    }
    
    func delete(entity:String,predicate:NSPredicate){
        do{
            let fetch = NSFetchRequest(entityName: entity)
            fetch.predicate = predicate
            let result = try context.executeFetchRequest(fetch)
            for data in result{
                context.deleteObject(data as! NSManagedObject)
            }
        }catch{
            NSLog("Er: Clear entity failed")
        }
    }
    
    func clear(entity:String){
        let fetch = NSFetchRequest(entityName: entity)
        do{
            let result = try context.executeFetchRequest(fetch)
            for item in result{
                context.deleteObject(item as! NSManagedObject)
            }
        }catch{
            NSLog("Er: Clear entity failed")
        }
        NSLog("\(entity) cleared")
    }
    
    func commit(){
        do{
            try context.save()
        }catch{
            NSLog("Er: Commit failed")
        }
    }
}