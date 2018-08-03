//
//  songsViewController.swift
//  UNKO_Library
//
//  Created by 牧 良樹 on 2017/10/10.
//  Copyright © 2017年 牧 良樹. All rights reserved.
//

import UIKit
import MediaPlayer

class songViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var passTitle:[String] = []
    var passList:[String] = []
    var selectUrl:[MPMediaItemCollection] = []
    var titleList:[String] = []
    var chosenUrl:[MPMediaItem] = []
    
    @IBOutlet weak var songList: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        songList.dataSource = self    //追加
        songList.delegate = self // 追加
        
        //print(passTitle)
        //print(passList)

        // Do any additional setup after loading the view.
        
        checkTitle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func checkTitle(){
        for song in selectUrl[0].items {
            
            //print(song)
            
            // アーティスト名
            guard let artist = song.value(forProperty: MPMediaItemPropertyArtist) else {
                continue
            }
            
            // 楽曲のタイトル
            guard let title = song.value(forProperty: MPMediaItemPropertyTitle) else {
                continue
            }
            
            // 楽曲のタイトル
            guard let aTitle = song.value(forProperty: MPMediaItemPropertyAlbumTitle) else {
                continue
            }
            
            //print("\(artist)の\(title)です")
            //print(selectUrl[0].items[1] ?? nil)
            titleList.append(title as! String)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "td")
        cell.textLabel?.text = titleList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        chosenUrl = []
        
        for i in indexPath.row..<selectUrl[0].items.count{
            chosenUrl.append(selectUrl[0].items[i])
        }
        
        segueToThirdViewController()
    }
    
    func segueToThirdViewController() {
        self.performSegue(withIdentifier: "playerViewController", sender: chosenUrl)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playerViewController" {
            let _songViewController = segue.destination as! playerViewController
            _songViewController.chosenUrl = sender as! [MPMediaItem]
        }
    }

}
