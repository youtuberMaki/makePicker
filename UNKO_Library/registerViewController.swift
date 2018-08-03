//
//  registerViewController.swift
//  UNKO_Library
//
//  Created by 牧 良樹 on 2017/10/24.
//  Copyright © 2017年 牧 良樹. All rights reserved.
//

import UIKit

class registerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var regiView: UITableView!
    
        
    var regiList:[String] = ["セットリスト登録画面","プレイリスト登録画面"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        regiView.dataSource = self    //追加
        regiView.delegate = self // 追加

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regiList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "td")
        cell.textLabel?.text = regiList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(regiList[indexPath.row])
        
        if indexPath.row == 0 {
            segueToThirdViewController()
        }else{
            segueToFourceViewController()
        }
    }
    
    func segueToThirdViewController() {
        self.performSegue(withIdentifier: "ResetlistViewController", sender: regiList)
    }
    func segueToFourceViewController() {
        self.performSegue(withIdentifier: "ReplaylistViewController", sender: regiList)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResetlistlistViewController" {
            let _songViewController = segue.destination as! ReplaylistViewController
            _songViewController.getList = sender as! [String]
        }
    }
}
