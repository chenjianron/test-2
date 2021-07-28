//
//  ViewController.swift
//  考核二
//
//  Created by GC on 2021/7/24.
//

import UIKit


protocol ViewControllerDelegate:NSObjectProtocol {
    func retResourceData(data:CommonWord,isEditStatus:Bool)
}

class ViewController: UIViewController, ViewControllerDelegate{
    
    let fullScreenSize = UIScreen.main.bounds.size
    var resoureData = [CommonWord]()
    var deleteIndexs = [Int]()
    var selectIndex:Int? = -1
    
    lazy var leftButton: UIBarButtonItem = {
        // 導覽列左邊按鈕
        let leftButton = UIBarButtonItem(
          title:"编辑",
          style:.plain ,
          target:self ,
          action: #selector(ViewController.edit))
        return leftButton
    }()
    
    lazy var rightButton: UIBarButtonItem = {
        // 導覽列左邊按鈕
        let rightButton = UIBarButtonItem(
          title:"设置",
          style:.plain ,
          target:self ,
          action: #selector(ViewController.setting))
        return rightButton
    }()
    
    lazy var appTitle: UILabel = {
        let appTitle = UILabel(frame: CGRect(x:15,y:0,width: fullScreenSize.width,height: 30))
        appTitle.text = "剪贴板键盘"
        appTitle.font = UIFont(name: "Helvetica", size: 22)
        appTitle.textColor = UIColor.black
        return appTitle
    }()
    
    lazy var emptyImageView: UIImageView = {
       let emptyImageView = UIImageView(
        frame: CGRect(x:0,y:0,width:272,height:228)
       )
        emptyImageView.center = CGPoint(x: fullScreenSize.width / 2, y: 292)
        emptyImageView.image = UIImage(named: "images/empty.png")
        return emptyImageView
    }()
    
    lazy var deleteButton: UIButton = {
       let deleteButton = UIButton(
        frame: CGRect(x:0,y:fullScreenSize.height - 60-44-(UIApplication.shared.keyWindow?.safeAreaInsets.top)!-(UIApplication.shared.keyWindow?.safeAreaInsets.bottom)!,width:fullScreenSize.width,height:60+(UIApplication.shared.keyWindow?.safeAreaInsets.bottom)!)
       )
//        deleteButton.center = CGPoint(x: fullScreenSize.width / 2, y: fullScreenSize.height - 60)
        deleteButton.setTitle("删除", for: .normal)
        deleteButton.backgroundColor = UIColor.red
        deleteButton.addTarget(self, action: #selector(ViewController.deleteing), for: .touchUpInside)
        
        return deleteButton
    }()
    
    lazy var addTableViewCellButton: UIButton = {
        let addTableViewCellButton = UIButton(frame: CGRect(x: 0, y: 0, width: 58, height: 58))
        addTableViewCellButton.center = CGPoint(x: fullScreenSize.width / 2, y: fullScreenSize.height-140)
        addTableViewCellButton.setImage(UIImage(named: "images/add.png"), for: .normal)
        addTableViewCellButton.addTarget(self, action: #selector(ViewController.add), for: .touchUpInside)
        return addTableViewCellButton
    }()
    
    lazy var editViewController:EditViewController = {
        
        return EditViewController()
    }()
    
//    lazy var bottomImageView: UIImageView = {
//        let bottomImageView = UIImageView(
//            frame: CGRect(x: 0, y: 0, width: 134, height: 4)
//        )
//        bottomImageView.center = CGPoint(x: fullScreenSize.width / 2, y: fullScreenSize.height - 71)
//        bottomImageView.image = UIImage(named: "images/Light - Portrait.png")
//        return bottomImageView
//    }()
    var tableView: UITableView?
    var alertController:UIAlertController?
    var labelTrailing: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        setupConstraints()
    }
}

//MARK: -
extension ViewController{
    @objc func edit(){
        tableView?.setEditing(!tableView!.isEditing, animated: true)
        if tableView!.isEditing {
            addTableViewCellButton.isHidden = true
            rightButton.isEnabled = false
            leftButton.title = "完成"
        } else {
            leftButton.title = "编辑"
            addTableViewCellButton.isHidden = false
            rightButton.isEnabled = true
            deleteButton.isHidden = true
        }
    }
//    @objc func delete(){
//        print("1111")
//    }
//
    @objc func setting(){
        
    }
    @objc func deleteing(){
        deleteIndexs.sort(by: >)
        for index in deleteIndexs{
            resoureData.remove(at: index)
            
        }
        deleteIndexs = []
        tableView?.reloadData()
        deleteButton.isHidden = true
        if resoureData.count == 0 {
            leftButton.title = "编辑"
            leftButton.isEnabled = false
            addTableViewCellButton.isHidden = false
            rightButton.isEnabled = true
            tableView?.setEditing(!tableView!.isEditing, animated: true)
            self.view.sendSubviewToBack(self.tableView!)
            self.view.bringSubviewToFront(self.emptyImageView)
        }
    }
    
    @objc func add(){
//        let dformatter = DateFormatter()
//        dformatter.dateFormat = "MM月dd日 ah:mm"
//        let commonWord = CommonWord(commonWord: "这是第一个常用语这是一个常用语这是一个常用语这是一个常用语这是一个常用语",date: dformatter.string(from: Date()))
//        resoureData.append(commonWord)
//        tableView!.reloadData()
        self.navigationController?.pushViewController(editViewController,animated: false)
    }
    
    func setResoureData(commonWord:CommonWord){
       
        resoureData.append(commonWord)
        tableView!.reloadData()
        
    }
    
    func retResourceData(data:CommonWord,isEditStatus:Bool){
        if !isEditStatus {
            resoureData.append(data)
        } else {
            resoureData[selectIndex!] = data
            selectIndex = -1
        }
        
        if resoureData.count == 1 {
            if tableView == nil{
                tableView = UITableView(frame: CGRect(x:0,y:40,width: fullScreenSize.width,height: fullScreenSize.height-212),style:.plain);
                tableView!.register(CommonWordTableViewCell.self, forCellReuseIdentifier:"commonWordCellType")
                
                tableView!.delegate = self
                tableView!.dataSource = self
                
                tableView!.separatorStyle = .none
                tableView!.separatorInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        
                tableView!.allowsSelection = true
                tableView!.allowsMultipleSelection = false
                
                tableView!.allowsMultipleSelectionDuringEditing = true
                tableView!.allowsSelectionDuringEditing = true
                
                self.view.addSubview(tableView!)
            }
            self.navigationItem.leftBarButtonItem?.isEnabled = true
            self.view.sendSubviewToBack(self.emptyImageView)
            self.view.bringSubviewToFront(self.tableView!)
        }
        tableView?.reloadData()
    }
}

//MARK: -UI
extension ViewController {
    func setupUI(){
        // 底色
        self.view.backgroundColor = UIColor.white
        // 導覽列底色
        self.navigationController?.navigationBar.barTintColor =
            UIColor.white
        // 導覽列是否半透明
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.navigationController?.navigationBar.clipsToBounds = true
        
//        self.navigationController?.navigationBar.frame = CGRect(x:20,y: 44,width: fullScreenSize.width,height:44)

        
        // 加到導覽列中
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.leftBarButtonItem = leftButton
        if resoureData.count == 0 {
            self.navigationItem.leftBarButtonItem?.isEnabled = false
        }
        
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = ""
        self.navigationItem.backBarButtonItem = backButtonItem
        
        self.view.addSubview(addTableViewCellButton)
        self.view.addSubview(appTitle)
//        self.view.addSubview(bottomImageView)
        self.view.addSubview(emptyImageView)
        self.view.addSubview(deleteButton)
        deleteButton.isHidden = true
        editViewController.setDelegate(delegate:self)
//        print("setUI\(resoureData)")
        
    }
    func setupConstraints(){
        
    }
}

//MARK: - TableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resoureData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commonWordCellType",
                                 for: indexPath) as! CommonWordTableViewCell
//        let cell = CommonWordTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "CommonWordCell")
        cell.setValueForCell(model: resoureData[indexPath.row])
        cell.selectedBackgroundView?.backgroundColor = UIColor.clear
        return cell
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        // 取消 cell 的選取狀態
//        tableView.deselectRow(
//            at: indexPath as IndexPath, animated: false)
        
        if tableView.isEditing{
            deleteIndexs.append(indexPath.row)
            deleteButton.isHidden = false
        } else {
            selectIndex = indexPath.row
            editViewController.setTextView(text: resoureData[indexPath.row].commonWord)
            self.navigationController?.pushViewController(editViewController,animated: false)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            let index = deleteIndexs.firstIndex(of: indexPath.row)!
            deleteIndexs.remove(at: index)
//            tableView.deselectRow(at: indexPath, animated: false)
            
            if deleteIndexs.count == 0 {
                deleteButton.isHidden = true
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true

    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?{
           return "删除"
       }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
       {
            if editingStyle == UITableViewCell.EditingStyle.delete {
                alertController = UIAlertController(
                        title: "确认刪除",
                    message: "确认删除\"\(resoureData[indexPath.row].commonWord!)\"这个剪切板吗",
                    preferredStyle: .alert)

                    // 建立[取消]按鈕
                    let cancelAction = UIAlertAction(
                      title: "取消",
                        style: .cancel,
                      handler: nil)
                alertController?.addAction(cancelAction)

                    // 建立[刪除]按鈕
                    let okAction = UIAlertAction(
                        title: "刪除",
                        style: .destructive,
                        handler: {_ in
                        self.resoureData.remove(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                        if self.resoureData.count == 0 {
    //                        self.navigationItem.leftBarButtonItem = nil
                            self.navigationItem.leftBarButtonItem?.isEnabled = false
                            self.view.sendSubviewToBack(self.tableView!)
                            self.view.bringSubviewToFront(self.emptyImageView)
                        }
                        tableView.reloadData()
                    })
                alertController?.addAction(okAction)

                    // 顯示提示框
                self.present(
                        alertController!,
                      animated: true,
                      completion: nil)
               }
       }
    
}
