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
    
    lazy var textView:UITextView = {
        let textView = UITextView(frame: CGRect(x:0,y:0,width: 300,height: fullSize.height / 2 - 40))
        textView.center = CGPoint(x:fullSize.width / 2, y: fullSize.height / 2 - 150)
        textView.text = "添加常用语"
        textView.textAlignment = .left
        textView.keyboardType = .default
        textView.keyboardAppearance = .default
        textView.backgroundColor = UIColor.lightGray
        return textView
    }()
    
    lazy var rightButton: UIBarButtonItem = {
        // 導覽列左邊按鈕
        let rightButton = UIBarButtonItem(
          title:"保存",
          style:.plain ,
          target:self ,
            action: #selector(EditViewController.saving))
        return rightButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setupConstrains()
    }
}

//MARK: -
extension EditViewController{
    @objc func saving(){
        let dformatter = DateFormatter()
        dformatter.dateFormat = "MM月dd日 ah:mm"
        let commonWord = CommonWord(commonWord: textView.text,date: dformatter.string(from: Date()))
        self.delegate?.retResourceData(data: commonWord)
        self.navigationController?.popViewController(animated: false)
    }
    
    func setDelegate(delegate:ViewControllerDelegate){
        self.delegate = delegate
    }
}

//MARK: - UI
extension EditViewController {
    func setUpUI(){
        self.navigationItem.rightBarButtonItem = rightButton
//        if resoureData.count == 0 {
//            self.navigationItem.rightBarButtonItem?.isEnabled = false
//        }
        view.addSubview(textView)
    }
    func setupConstrains(){
        
    }
}

extension EditViewController:UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    func textViewDidChange(_ textView: UITextView) {
        
    }
    
    
}

