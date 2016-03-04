
import CoreData

class localRecordings{

    var paths:[String] = []
    let db = RecordingData()

    init(){
        paths = fetch()
    }
    
    func fetch()->[String]{
        let fetch = db.fetch("Recordings", predicate: nil)
        var result:[String] = []
        if fetch.count>0{
            for data in fetch as [NSManagedObject]{
                let path = data.valueForKey("path") as! String
                result.append(path)
            }
        }
        return result
    }




}