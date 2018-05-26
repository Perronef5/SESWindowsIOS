import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var skyScrollView: UIScrollView!
    @IBOutlet weak var segmentedControl: SJFluidSegmentedControl!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var segmentedControlBGView: UIView!
    
    var userScrolled = false
    var segmentSelected = false
 
    var selectedCellIndexPath: IndexPath?
    let screenSize = UIScreen.main.bounds
    var viewAppearedCounter = 0
    var screenWidth: CGFloat = 0.0
    var screenHeight: CGFloat = 0.0
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareLayout()
        if #available(iOS 8.2, *) {
//            segmentedControl.textFont = UIFont.boldSystemFont(ofSize: 12.0)
        } else {
//            segmentedControl.textFont = UIFont.boldSystemFont(ofSize: 12.0)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Uncomment the following line to set the current segment programmatically.

    }
    
    override
    func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if viewAppearedCounter == 0 {
            let slides:[ScreensView] = creatSlides()
            setUpSlideScrollView(slides)
//            segmentedControl.setCurrentSegmentIndex(0, animated: false)
            skyScrollView.setContentOffset(CGPoint(x: 0, y: UIApplication.shared.statusBarFrame.height), animated: false)
            viewAppearedCounter += 1
//            segmentedControl.textColor = UIColor.red
        }
    }
    
}

// MARK: - SJFluidSegmentedControl Data Source Methods

extension HomeViewController: SJFluidSegmentedControlDataSource, UIScrollViewDelegate {
    
    func prepareLayout() {
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        segmentedControl.layer.borderColor = UIColor.clear.cgColor
        segmentedControl.backgroundColor = UIColor.clear
        segmentedControl.layer.borderWidth = 2.0
//        segmentedControl.layer.shadowColor = UIColorFromRGB(rgbValue: 0x31597F).cgColor
//        segmentedControl.layer.shadowOpacity = 0.3
//        segmentedControl.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
//        segmentedControl.layer.shadowRadius = 5.0
//        segmentedControl.layer.masksToBounds = false
        
        segmentedControlBGView.backgroundColor = UIColor.clear
//        segmentedControlBGView.isOpaque = false
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.prominent)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = segmentedControlBGView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.clipsToBounds = true
        segmentedControlBGView.addSubview(blurEffectView)
        
        skyScrollView.delegate = self
        
        skyScrollView.showsHorizontalScrollIndicator = false
            
    }
    
    func creatSlides() -> [ScreensView] {
        
        
        let slide1:ScreensView = Bundle.main.loadNibNamed("HomeView", owner: self, options: nil)!.first as! ScreensView
        
        
        let slide2:ScreensView = Bundle.main.loadNibNamed("ServicesView", owner: self, options: nil)!.first as! ScreensView
        slide2.inDetailButtom.layer.borderWidth = 2.0
        slide2.inDetailButtom.layer.borderColor = UIColorFromRGB(rgbValue: 0x313131).cgColor
        slide2.inDetailButtom.backgroundColor = UIColor.clear
        
        let slide3:ScreensView = Bundle.main.loadNibNamed("DemoView", owner: self, options: nil)!.first as! ScreensView
        
        let slide4:ScreensView = Bundle.main.loadNibNamed("AboutView", owner: self, options: nil)!.first as! ScreensView
        
        
        let slide5:ScreensView = Bundle.main.loadNibNamed("ContactView", owner: self, options: nil)!.first as! ScreensView
        slide5.submitButton.backgroundColor = UIColor.clear
        slide5.nameTextField.layer.borderWidth = 2.0
        slide5.nameTextField.layer.borderColor = UIColorFromRGB(rgbValue: 0x313131).cgColor
        slide5.nameTextField.attributedPlaceholder = NSAttributedString(string: "  Name",
                                                                  attributes: [NSAttributedStringKey.foregroundColor: UIColorFromRGB(rgbValue: 0x313131).withAlphaComponent(0.7)])
        slide5.nameTextField.textColor = UIColorFromRGB(rgbValue: 0x313131)
        slide5.emailTextField.layer.borderWidth = 2.0
        slide5.emailTextField.layer.borderColor = UIColorFromRGB(rgbValue: 0x313131).cgColor
        slide5.emailTextField.attributedPlaceholder = NSAttributedString(string: "  Email",
                                                                        attributes: [NSAttributedStringKey.foregroundColor: UIColorFromRGB(rgbValue: 0x313131).withAlphaComponent(0.7)])
        slide5.emailTextField.textColor = UIColorFromRGB(rgbValue: 0x313131)
        slide5.subjectTextField.layer.borderWidth = 2.0
        slide5.subjectTextField.layer.borderColor = UIColorFromRGB(rgbValue: 0x313131).cgColor
        slide5.subjectTextField.attributedPlaceholder = NSAttributedString(string: "  Subject",
                                                                         attributes: [NSAttributedStringKey.foregroundColor: UIColorFromRGB(rgbValue: 0x313131).withAlphaComponent(0.7)])
        slide5.subjectTextField.textColor = UIColorFromRGB(rgbValue: 0x313131)
        slide5.messageTextField.layer.borderWidth = 2.0
        slide5.messageTextField.layer.borderColor = UIColorFromRGB(rgbValue: 0x313131).cgColor
        slide5.messageTextField.text = "  Message"
        slide5.messageTextField.textColor = UIColorFromRGB(rgbValue: 0x313131, alpha: 0.7)
        slide5.submitButton.layer.borderWidth = 2.0
        slide5.submitButton.layer.borderColor = UIColorFromRGB(rgbValue: 0x313131).cgColor
        
        return[slide1,slide2,slide3, slide4, slide5]
        
    }
    
    func setUpSlideScrollView(_ slides: [ScreensView]) {
        
        //        skyScrollView.frame = CGRect(x: 0, y: 50, width: self.view.frame.width, height: self.view.frame.height - 320)
        skyScrollView.contentSize = CGSize(width: screenWidth , height: self.view.frame.height  * CGFloat(slides.count))
        skyScrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: 0, y: screenHeight * CGFloat(i), width: screenWidth, height: skyScrollView.frame.height)
            skyScrollView.addSubview(slides[i])
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(!segmentSelected && scrollView == skyScrollView) {
            userScrolled = true
            let pageIndex = round(scrollView.contentOffset.y/(self.view.frame.height))
            segmentedControl.setCurrentSegmentIndex(Int(pageIndex), animated: false)
            userScrolled = false
        }
    }
    
    
    func numberOfSegmentsInSegmentedControl(_ segmentedControl: SJFluidSegmentedControl) -> Int {
        return 5
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                          titleForSegmentAtIndex index: Int) -> String? {
        if index == 0 {
            return "HOME".uppercased()
        } else if index == 1 {
            return "SERVICES".uppercased()
        } else if index == 2 {
            return "DEMO".uppercased()
        } else if index == 3 {
            return "ABOUT".uppercased()
        } else {
            return "CONTACT".uppercased()
        }
    }
    
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                          gradientColorsForSelectedSegmentAtIndex index: Int) -> [UIColor] {
        switch index {
        case 0:
            return [UIColor.clear]
        case 1:
            return [UIColor.clear]
        case 2:
            return [UIColor.clear]
        case 3:
            return [UIColor.clear]
        case 4:
            return [UIColor.clear]
        default:
            break
        }
        return [.clear]
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                          gradientColorsForBounce bounce: SJFluidSegmentedControlBounce) -> [UIColor] {
        switch bounce {
        case .left:
            return [UIColor.clear]
        case .right:
            return [UIColor.clear]
        }
    }
    
}

// MARK: - SJFluidSegmentedControl Delegate Methods

extension HomeViewController: SJFluidSegmentedControlDelegate {
 
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, didChangeFromSegmentAtIndex fromIndex: Int, toSegmentAtIndex toIndex: Int) {
        if(!userScrolled) {
            let offset = view.frame.height * CGFloat(toIndex)
            segmentSelected = true
            skyScrollView.setContentOffset(CGPoint(x: skyScrollView.contentOffset.x, y: offset), animated: false)
            segmentSelected = false
        }
    }
    
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, didScrollWithXOffset offset: CGFloat) {
        _ = segmentedControl.frame.width / CGFloat(segmentedControl.segmentsCount * (segmentedControl.segmentsCount - 1))
        var width = view.frame.width * 0.2
        //        var leftDistance = (backgroundScrollView.contentSize.width - width) * 0.2
        //        var rightDistance = (backgroundScrollView.contentSize.width - width) * 0.8
        //        let backgroundScrollViewOffset = leftDistance + ((offset / maxOffset) * (backgroundScrollView.contentSize.width - rightDistance - leftDistance))
        width = view.frame.width
        //        leftDistance = -width * 0.0001 + 10
        //        rightDistance = width * 0.8
        //        let skyScrollViewOffset = leftDistance + ((offset / maxOffset) * (skyScrollView.contentSize.width - rightDistance - leftDistance))
        //        skyScrollView.contentOffset = CGPoint(x: skyScrollViewOffset, y: 0)
        //        backgroundScrollView.contentOffset = CGPoint(x: backgroundScrollViewOffset, y: 0)
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func UIColorFromRGB(rgbValue: UInt, alpha: CGFloat) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, resposne, error) in completion(data, resposne, error)
            }.resume()
        
    }
    
    func downloadImage(url: URL, image: UIImageView) {
        print("Download Started")
        getDataFromUrl(url: url) {
            (data, response, error) in guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in image.image = UIImage(data: data)
            }
        }
    }
    
}

