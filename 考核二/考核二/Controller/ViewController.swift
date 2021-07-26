//
//  ViewController.swift
//  考核二
//
//  Created by GC on 2021/7/24.
//

import UIKit

class ViewController: UIViewController {
    
    let fullScreenSize = UIScreen.main.bounds.size
    var resoureData = [CommonWord]()
    
    lazy var leftButton: UIBarButtonItem = {
        // 導覽列左邊按鈕
        let leftButton = UIBarButtonItem(
          title:"编辑",
          style:.plain ,
          target:self ,
          action: #selector(ViewController.edit))
        return leftButton
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
    
    lazy var addTableViewCellButton: UIButton = {
        let addTableViewCellButton = UIButton(frame: CGRect(x: 0, y: 0, width: 58, height: 58))
        addTableViewCellButton.center = CGPoint(x: fullScreenSize.width / 2, y: fullScreenSize.height-140)
        addTableViewCellButton.setImage(UIImage(named: "images/add.png"), for: .normal)
        addTableViewCellButton.addTarget(self, action: #selector(ViewController.add), for: .touchUpInside)
        return addTableViewCellButton
    }()
    
    lazy var bottomImageView: UIImageView = {
        let bottomImageView = UIImageView(
            frame: CGRect(x: 0, y: 0, width: 134, height: 4)
        )
        bottomImageView.center = CGPoint(x: fullScreenSize.width / 2, y: fullScreenSize.height - 71)
        bottomImageView.image = UIImage(named: "images/Light - Portrait.png")
        return bottomImageView
    }()
    var tableView: UITableView?
    var alertController:UIAlertController?
    
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
        addTableViewCellButton.isHidden = !addTableViewCellButton.isHidden
        leftButton.title = leftButton.title == "完成" ? "编辑": "完成"
    }
    @objc func setting(){
        
    }
    @objc func add(){
        if tableView == nil{
            tableView = UITableView(frame: CGRect(x:0,y:40,width: fullScreenSize.width,height: fullScreenSize.height-210),style:.plain);
            tableView!.register(UITableViewCell.self, forCellReuseIdentifier:"Cell")
            
            tableView!.delegate = self
            tableView!.dataSource = self
            
            tableView!.separatorStyle = .none
            tableView!.separatorInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
    
            tableView!.allowsSelection = true
            tableView!.allowsMultipleSelection = false
            
            self.view.addSubview(tableView!)
        }
        let dformatter = DateFormatter()
        dformatter.dateFormat = "MM月dd日 ah:mm"
        let commonWord = CommonWord(commonWord: "这是第一个常用语这是一个常用语这是一个常用语这是一个常用语这是一个常用语",date: dformatter.string(from: Date()))
        resoureData.append(commonWord)
        tableView!.reloadData()
        if resoureData.count != 0 {
            self.navigationItem.leftBarButtonItem = self.navigationItem.leftBarButtonItem ?? leftButton
        }
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

        // 導覽列右邊按鈕
        let rightButton = UIBarButtonItem(
          title:"设置",
          style:.plain,
          target:self,
          action:#selector(ViewController.setting))
        // 加到導覽列中
        self.navigationItem.rightBarButtonItem = rightButton
        
        self.view.addSubview(addTableViewCellButton)
        self.view.addSubview(appTitle)
        self.view.addSubview(bottomImageView)
        self.view.addSubview(emptyImageView)
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
        let cell = CommonWordTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "CommonWordCell")
//        if let myLabel = cell.textLabel {
//            myLabel.text = "\(resoureData[indexPath.row].commonWord!) \(resoureData[indexPath.row].date!)"
//        }
        cell.setValueForCell(model: resoureData[indexPath.row])
//        cell.textLabel?.textColor = .black
        return cell
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
                    title: "刪除",
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
                        self.navigationItem.leftBarButtonItem = nil
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
        return
       }
}
