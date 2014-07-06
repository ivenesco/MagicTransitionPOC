//
//  ViewController.swift
//  TransitionTest
//
//  Created by Maciej Koziel on 05/07/14.
//  Copyright (c) 2014 Maciej Koziel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let vFrom = FromView(frame: CGRectZero)
    let vTo = ToView(frame: CGRectZero)
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(vTo)
        view.addSubview(vFrom)
        vTo.alpha = 0.0
        
        let tapFromRecognizer = UITapGestureRecognizer(target: self, action: "handleTapFrom")
        vFrom.addGestureRecognizer(tapFromRecognizer)
        
        let tapToRecognizer = UITapGestureRecognizer(target: self, action: "handleTapTo")
        vTo.addGestureRecognizer(tapToRecognizer)
    }
    
    func handleTapFrom() {
        let transition = TransitionTest(from: vFrom, to: vTo)
        
        transition.addMapping(vFrom.titleLabel, to: vTo.titleLabel)
        transition.addMapping(vFrom.subtitleLabel, to: vTo.subtitleLabel)
        transition.addMapping(vFrom.titleImage, to: vTo.titleImage)
        
        transition.start()
    }
    
    func handleTapTo() {
        let transition = TransitionTest(from: vTo, to: vFrom)
        
        transition.addMapping(vTo.titleLabel, to: vFrom.titleLabel)
        transition.addMapping(vTo.subtitleLabel, to: vFrom.subtitleLabel)
        transition.addMapping(vTo.titleImage, to: vFrom.titleImage)
        
        transition.start()
    }
    
    override func viewWillLayoutSubviews()  {
        super.viewWillLayoutSubviews()
        
        vFrom.frame = CGRectMake(10, 80, 300, 70)
        vTo.frame = CGRectMake(0, 20, 320, 500)
    }

}


class ViewController2: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let vTo = ToView(frame: CGRectZero)
    let tableView = UITableView(frame: CGRectZero)
    var currentCell: TestCell?
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 70
        tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        view.addSubview(vTo)
        vTo.alpha = 0.0
        
        let tapFromRecognizer = UITapGestureRecognizer(target: self, action: "handleTapFrom")
        vTo.addGestureRecognizer(tapFromRecognizer)
    }
    
    func handleTapFrom() {
        let transition = TransitionTest(from: vTo, to: currentCell!.innerView)
        
        transition.addMapping(vTo.titleLabel, to: currentCell!.innerView.titleLabel)
        transition.addMapping(vTo.subtitleLabel, to: currentCell!.innerView.subtitleLabel)
        transition.addMapping(vTo.titleImage, to: currentCell!.innerView.titleImage)
        
        transition.start()
    }
    
    func handleTapToCell(cell: TestCell) {
        let transition = TransitionTest(from: cell.innerView, to: vTo)

        transition.addMapping(cell.innerView.titleLabel, to: vTo.titleLabel)
        transition.addMapping(cell.innerView.subtitleLabel, to: vTo.subtitleLabel)
        transition.addMapping(cell.innerView.titleImage, to: vTo.titleImage)
        
        transition.start()
    }
    
    override func viewWillLayoutSubviews()  {
        super.viewWillLayoutSubviews()
        
        tableView.frame = view.bounds
        
        vTo.frame = CGRectMake(0, 0, 320, view.frame.height)
    }
    

    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let tvc = TestCell(style: UITableViewCellStyle.Default, reuseIdentifier: "")
        
        return tvc
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as TestCell
        currentCell = cell
        handleTapToCell(cell)
    }

}

class TestCell : UITableViewCell {
    let innerView: FromView
    
    init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        innerView = FromView(frame: CGRectMake(0, 0, 320, 70))
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(innerView)
        selectionStyle = UITableViewCellSelectionStyle.None
    }
}
