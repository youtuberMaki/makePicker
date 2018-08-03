//
//  AlbumsViewController.swift
//  UNKO_Library
//
//  Created by 牧 良樹 on 2017/10/09.
//  Copyright © 2017年 牧 良樹. All rights reserved.
//

import UIKit
import MediaPlayer

class AlbumsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var list: UITableView!
    
    var albumList: [String:Any] = [:]
    var songList: [String] = []
    var titleList: [String] = []
    var passList : [String] = []
    var albumArtist = "Artist"
    var albumSong = "Song"
    var albumTitle = "Title"
    var passTitle = "渡したい値"
    var count = 0
    var _count = 0
    var player : MPMusicPlayerController?
    var passUrl : [MPMediaItemCollection] = []
    var selectUrl: [MPMediaItemCollection] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        list.delegate = self
        
        player = MPMusicPlayerController.applicationMusicPlayer()
        
        test()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    func test(){
        let albumsQuery = MPMediaQuery.albums()
        
        albumsQuery.addFilterPredicate(MPMediaPropertyPredicate(value: false, forProperty: MPMediaItemPropertyIsCloudItem))
        
        if let albums = albumsQuery.collections {
            
            passUrl = albums
            
            for album in albums {
                
                for song in album.items {
                    
                    _count += 1
                    
                    //player.setQueue(with: albums[0])
                    //player.play()
                    
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
                    
                    albumArtist = artist as! String
                    albumSong = title as! String
                    albumTitle = aTitle as! String
                    
                    songList.append(albumSong)
                }
                
                albumList[albumTitle] = songList
                titleList.append(albumTitle)
                songList = []
            }
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
        selectUrl = [passUrl[indexPath.row]]
        
        segueToSecondViewController()
        
    }
    
    func segueToSecondViewController() {
        self.performSegue(withIdentifier: "songViewController", sender: selectUrl)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "songViewController" {
            let _songViewController = segue.destination as! songViewController
            _songViewController.selectUrl = sender as! [MPMediaItemCollection]
        }
    }

}
