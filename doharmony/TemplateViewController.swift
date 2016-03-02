
import UIKit
import CoreData

protocol TemplateViewControllerDelegate{
    func useTemplate()
}

class TemplateViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet var LayoutSelectionView: UIView!
    @IBOutlet weak var TemplateScrollView: UIScrollView!
    
    @IBOutlet weak var defaultTemplate: UIView!
    
    var Template:UIView!
    var Frames = [UIView]()
    
    var delegate:TemplateViewControllerDelegate?
    var pageMenu:CAPSPageMenu?
    let db = RecordingData()
    
    let app:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var context:NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = app.managedObjectContext
        
        addTemplateTapAction()
        //let tap = UITapGestureRecognizer(target: self, action: nil)
        //tap.delegate = self
        //LayoutSelectionView.addGestureRecognizer(tap)
    }
    
    func addTemplateTapAction(){
        for temp:UIView in TemplateScrollView.subviews{
            let tap = UITapGestureRecognizer(target: self, action: Selector("next:"))
            temp.addGestureRecognizer(tap)
        }
    }
    
    func next(sender: UITapGestureRecognizer){
        db.clear("Layout")
        Template = sender.view
        insertTemplate(Template, isSubview: false)
        for subview:UIView in Template.subviews{
            insertTemplate(subview, isSubview: true)
        }
        
        delegate!.useTemplate()
        pageMenu!.moveToPage(1)
    }
    
    func insertTemplate(view:UIView, isSubview:Bool){
        let height = view.frame.height
        let width = view.frame.width
        let x = view.frame.origin.x
        let y = view.frame.origin.y
        let layout:[String:AnyObject] = ["x":x , "y":y, "width":width, "height":height, "isSubview":isSubview]
        db.insert("Layout", values: layout)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

}
