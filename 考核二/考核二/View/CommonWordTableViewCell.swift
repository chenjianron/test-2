//
//  CommonWordTableViewCell.swift
//  考核二
//
//  Created by GC on 2021/7/25.
//

import UIKit

class CommonWordTableViewCell: UITableViewCell {
    
    let fullScreenSize = UIScreen.main.bounds.size
    
    @IBOutlet var commonWordLabel:UILabel?
    @IBOutlet var dateLabel:UILabel?
    @IBOutlet var rightArrowImage:UIImageView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layoutUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func layoutUI() {
        
        commonWordLabel = UILabel(frame: CGRect(x:15,y:2,width:fullScreenSize.width-50,height: 30))
        commonWordLabel?.font = UIFont.systemFont(ofSize: 14)
//        commonWordLabel?.text = "这是一个常用语"
        self.contentView.addSubview(commonWordLabel!)

        dateLabel = UILabel(frame: CGRect(x:15,y:32,width: fullScreenSize.width-50,height:20))
        dateLabel?.font = UIFont.systemFont(ofSize: 12)
//        dateLabel?.text = "5月15日 上午09:30"
        dateLabel?.textColor = UIColor.darkGray
        self.contentView.addSubview(dateLabel!)

        rightArrowImage = UIImageView(frame:CGRect(x:fullScreenSize.width - 30,y:17,width: 20,height: 20))
        rightArrowImage?.image = UIImage(named: ("images/right-arrow.png"))
        self.contentView.addSubview(rightArrowImage!)
//        self.backgroundColor = UIColor.white
    }

    func setValueForCell(model:CommonWord){
        self.commonWordLabel?.text = model.commonWord
        self.dateLabel?.text = model.date
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
