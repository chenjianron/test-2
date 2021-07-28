//
//  EditViewController.swift
//  考核二
//
//  Created by GC on 2021/7/26.
//
import UIKit


class EditViewController: UIViewController {
    
    let fullSize = UIScreen.main.bounds.size
    var delegate:ViewControllerDelegate?
    var isEditStatus: Bool = false
    
    lazy var textView:UITextView = {
        let textView = UITextView(frame: CGRect(x:0,y:0,width: 300,height: fullSize.height / 2 - 100))
        textView.center = CGPoint(x:fullSize.width / 2, y: fullSize.height / 2 - 230)
        textView.textAlignment = .left
        textView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        textView.font = UIFont(name: "Helvetica", size: 14)
        textView.isSelectable = true
        textView.delegate = self
        textView.becomeFirstResponder()
        return textView
    }()
    
    lazy var rightButton: UIBarButtonItem = {
        // 導覽列左邊按鈕
        let rightButton = UIBarButtonItem(
          title:"保存",
          style:.plain ,
          target:self ,
            action: #selector(EditViewController.saving))
        rightButton.isEnabled = false
        return rightButton 
    }()
    
    lazy var textCountLabel:UILabel = {
        let textCountLabel = UILabel(frame: CGRect(x: 280, y: fullSize.height/2 - 100, width: 54, height: 15))
        textCountLabel.text = "0/200"
        textCountLabel.textColor = UIColor.gray
        textCountLabel.font = UIFont(name: "Helvetica", size: 14)
        return textCountLabel
    }()
    
    lazy var hintLabel:UILabel = {
        let hintLabel = UILabel(frame: CGRect(x: 44, y: 32, width: 100, height: 15))
        hintLabel.text = "添加常用语"
        hintLabel.font = UIFont(name: "Helvetica", size: 14)
        hintLabel.textColor = UIColor.lightGray
        return hintLabel
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setupConstrains()
        print("viewDidLoad")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
        rightButton.isEnabled = false
        self.isEditStatus = false
        hintLabel.isHidden = false
        textView.text = nil
        textCountLabel.text = "0/200"
    }
    
    override func awakeFromNib() {
        print("awakeFromNib")
    }
    
    override func loadView() {
        super.loadView()
        print("loadView")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
    }
    
    override func viewWillLayoutSubviews() {
        print("viewWillLayoutSubviews")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
    }
    
    override func didReceiveMemoryWarning() {
        print("didReceiveMemoryWarning")
    }
}

//MARK: -
extension EditViewController{
    @objc func saving(){
            let dformatter = DateFormatter()
            dformatter.dateFormat = "MM月dd日 ah:mm"
            let commonWord = CommonWord(commonWord: textView.text,date: dformatter.string(from: Date()))
            self.delegate?.retResourceData(data: commonWord,isEditStatus:isEditStatus)
            self.isEditStatus = false
            self.navigationController?.popViewController(animated: false)
    }
    
    func setDelegate(delegate:ViewControllerDelegate){
        self.delegate = delegate
    }
    
    func setTextView(text:String){
        rightButton.isEnabled = true
        isEditStatus = true
        hintLabel.isHidden = true
        textView.text = text
        textCountLabel.text = String(format: "%i/200", textView.text.count)
    }
}

//MARK: - UI
extension EditViewController {
    func setUpUI(){
        self.navigationItem.rightBarButtonItem = rightButton
//        if resoureData.count == 0 {
//            self.navigationItem.rightBarButtonItem?.isEnabled = false
//        }
        self.navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
        view.addSubview(textView)
        view.addSubview(textCountLabel)
        view.addSubview(hintLabel)
        print("setUpUI")

    }
    func setupConstrains(){
        
    }
}

//MARK: - TextView
extension EditViewController:UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("replacementText")
        return true
    }
    func textViewDidChange(_ textView: UITextView) {
        print("textViewDidChange")
        let len = textView.text.count
        if len > 0{
            if len > 200 {
                rightButton.isEnabled = false
                textCountLabel.textColor = UIColor.red
            } else {
                textCountLabel.textColor = UIColor.gray
                rightButton.isEnabled = true
                hintLabel.isHidden = true
            }
            
        } else {
            rightButton.isEnabled = false
            hintLabel.isHidden = false
        }
        textCountLabel.text = String(format: "%i/200", len)
    }
    
}

