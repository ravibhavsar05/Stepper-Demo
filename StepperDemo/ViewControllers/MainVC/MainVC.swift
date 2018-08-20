//
//  MainVC.swift
//  StepperDemo
//

import UIKit
import CoreSpotlight
import MobileCoreServices

class MainVC: UIViewController {

    //------------------------------------------------------------------------------
    // MARK:-
    // MARK:- Outlets
    //------------------------------------------------------------------------------
    
    @IBOutlet weak var cvStepper                    : UICollectionView!
    @IBOutlet weak var svStepper                    : UIScrollView!
    @IBOutlet weak var contentView                  : UIView!
    
    
    //------------------------------------------------------------------------------
    // MARK:-
    // MARK:- Variables
    //------------------------------------------------------------------------------
    
    // Create array for collection view title
    var arrHeaders = [
        "VC1",
        "VC2",
        "VC3",
        "VC4",
        "VC5",
        "VC6",
        "VC7",
        "VC8",
        "VC9",
    ]
    
    var screenPageNumber                            = 0
    var screenWidth                                 : Int!
    
    // References for view controllers
    var vc1Ref                                      : VC1?
    var vc2Ref                                      : VC2?
    var vc3Ref                                      : VC3?
    var vc4Ref                                      : VC4?
    var vc5Ref                                      : VC5?
    var vc6Ref                                      : VC6?
    var vc7Ref                                      : VC7?
    var vc8Ref                                      : VC8?
    var vc9Ref                                      : VC9?
    
    
    //------------------------------------------------------------------------------
    // MARK:-
    // MARK:- Memory Management Methods
    //------------------------------------------------------------------------------
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //------------------------------------------------------------------------------
    // MARK:-
    // MARK:- Abstract Method
    //------------------------------------------------------------------------------
    
    class func viewController() -> MainVC {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainVC") as! MainVC
    }
    
    
    //------------------------------------------------------------------------------
    // MARK:-
    // MARK:- Action Methods
    //------------------------------------------------------------------------------
    
    
    
    
    //------------------------------------------------------------------------------
    // MARK:-
    // MARK:- Custom Methods
    //------------------------------------------------------------------------------
    
    func setupView() {
        
        // Get width of screen
        screenWidth = Int(UIScreen.main.bounds.size.width)
        
        // Setup CollectionView Appereance
        self.cvStepper.layer.borderColor = UIColor.blue.withAlphaComponent(0.5).cgColor
        self.cvStepper.layer.borderWidth = 1.0
    }
    
    //------------------------------------------------------------------------------
    
    func scrollToPosition(_ withPosition: Int) {
        if withPosition >= 0 {
            if withPosition != Int(self.svStepper.contentOffset.x) {
                self.svStepper.setContentOffset(CGPoint(x: withPosition, y: 0), animated: true)
            }
        }
    }
    
    
    //------------------------------------------------------------------------------
    // MARK:-
    // MARK:- Segue Methods
    //------------------------------------------------------------------------------
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
            
        case "VC1":
            
            if let destinationVC = segue.destination as? VC1 {
                self.vc1Ref = destinationVC
            }
            
            break
            
        case "VC2":
            
            if let destinationVC = segue.destination as? VC2 {
                self.vc2Ref = destinationVC
            }
            
            break
            
        case "VC3":
            
            if let destinationVC = segue.destination as? VC3 {
                self.vc3Ref = destinationVC
            }
            
            break
            
        case "VC4":
            
            if let destinationVC = segue.destination as? VC4 {
                self.vc4Ref = destinationVC
            }
            
            break
            
        case "VC5":
            
            if let destinationVC = segue.destination as? VC5 {
                self.vc5Ref = destinationVC
            }
            
            break
            
        case "VC6":
            
            if let destinationVC = segue.destination as? VC6 {
                self.vc6Ref = destinationVC
            }
            
            break
            
        case "VC7":
            
            if let destinationVC = segue.destination as? VC7 {
                self.vc7Ref = destinationVC
            }
            
            break
            
        case "VC8":
            
            if let destinationVC = segue.destination as? VC8 {
                self.vc8Ref = destinationVC
            }
            
            break
            
        case "VC9":
            
            if let destinationVC = segue.destination as? VC9 {
                self.vc9Ref = destinationVC
            }
            
            break
            
        default:
            
            break
        }
    }
    
    //------------------------------------------------------------------------------
    // MARK:-
    // MARK:- View Life Cycle Methods
    //------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    //------------------------------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let currentPage = UserDefaults.standard.value(forKey: "CurrentPage") as? Int {
            
            if currentPage < self.arrHeaders.count {
                let width = screenWidth * currentPage
                scrollToPosition(width)
                UserDefaults.standard.set(currentPage, forKey: "CurrentPage")
            } else {
                scrollToPosition(screenWidth * 0)
                UserDefaults.standard.set(0, forKey: "CurrentPage")
            }
        }
    }
}


//------------------------------------------------------------------------------
// MARK:-
// MARK:- Extension - UICollectionViewDataSource Methods
//------------------------------------------------------------------------------

extension MainVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrHeaders.count
    }
    
    //------------------------------------------------------------------------------
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCell", for: indexPath) as! HeaderCVC
        
        cell.lblTitle.text = self.arrHeaders[indexPath.item]
        
        if screenPageNumber == indexPath.item {
            
            cell.bottomView.backgroundColor = .blue
            cell.layer.borderColor = UIColor.orange.cgColor
            cell.backgroundColor = UIColor(red: 0/255.0, green: 128.0/255.0, blue: 0/255.0, alpha: 1.0)
            cell.lblTitle.textColor = .white
            cell.layer.borderWidth = 3.0
            
        } else {
            
            cell.bottomView.backgroundColor = .clear
            cell.layer.borderColor = UIColor.clear.cgColor
            cell.backgroundColor = UIColor.clear
            cell.lblTitle.textColor = .black
            cell.layer.borderWidth = 0.0
            
        }
        
        return cell
    }
}


//------------------------------------------------------------------------------
// MARK:-
// MARK:- Extension - UICollectionViewDelegate Methods
//------------------------------------------------------------------------------

extension MainVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        screenPageNumber = indexPath.item
        let width = screenWidth * screenPageNumber
        scrollToPosition(width)
    }
}


//------------------------------------------------------------------------------
// MARK:-
// MARK:- Extension - UICollectionViewDelegateFlowLayout Methods
//------------------------------------------------------------------------------

extension MainVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (UIScreen.main.bounds.size.width / 3)
        return CGSize(width: cellWidth, height: 50.0)
    }
}



//------------------------------------------------------------------------------
// MARK:-
// MARK:- Extension - UIScrollViewDelegate Methods
//------------------------------------------------------------------------------


extension MainVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == svStepper {
            
            let pageWidth = scrollView.frame.size.width
            let page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1
            screenPageNumber = Int(page)
            
            UserDefaults.standard.set(screenPageNumber, forKey: "CurrentPage")
            
            // Scroll to center position selected cell
            self.cvStepper.scrollToItem(at: IndexPath(item: Int(page), section: 0), at: .centeredHorizontally, animated: true)
            
            // Reload to change view of selected cell
            self.cvStepper.reloadData()
        }
    }
    
    //------------------------------------------------------------------------------
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView == svStepper {
            let pageWidth = scrollView.frame.size.width
            let page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1
            screenPageNumber = Int(page)
        }
    }
}

