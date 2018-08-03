//
//  playerViewController.swift
//  UNKO_Library
//
//  Created by 牧 良樹 on 2017/10/10.
//  Copyright © 2017年 牧 良樹. All rights reserved.
//

import UIKit
import MediaPlayer
import SpriteKit

class songPlayerViewController: UIViewController {
  
  
  @IBOutlet weak var musicTitle: UILabel!
  @IBOutlet weak var albumArt: UIImageView!
  
  var passTitle:[String] = []
  //var musicTitle = String()
  var player : MPMusicPlayerController?
  var playList:[String] = []
  var count = 0
  var _count = 0
  var chosenUrl: [MPMediaItem] = []
  var playerList = String()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    player = MPMusicPlayerController.applicationMusicPlayer()
    getMusic()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func getMusic(){
    
    let playList = MPMediaItemCollection(items: chosenUrl)
    
    // アートワーク表示
    if let artwork = playList.items[0].artwork {
      let image = artwork.image(at: albumArt.bounds.size)
      albumArt.image = image
    } else {
      // アートワークがないとき
      albumArt.image = nil
      albumArt.backgroundColor = UIColor.gray
    }
    
    musicTitle.text = playList.items[0].title
    musicTitle.numberOfLines = 0
    //contentsのサイズに合わせてobujectのサイズを変える
    musicTitle.sizeToFit()
    //単語の途中で改行されないようにする
    musicTitle.lineBreakMode = NSLineBreakMode.byWordWrapping
    musicTitle.textAlignment = NSTextAlignment.center
    
    
    player?.setQueue(with: playList)
    player?.play()
  }
}
