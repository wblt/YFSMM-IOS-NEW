//
//  ResultViewController.swift
//  YFSMM
//
//  Created by wb on 2017/9/11.
//  Copyright © 2017年 Alvin. All rights reserved.
//

import UIKit



class ResultViewController: BaseVC {
    
    @IBOutlet weak var resultContent: UILabel!
    
    @IBOutlet weak var waterup: UILabel!
    
    @IBOutlet weak var oile: UILabel!
    
    @IBOutlet weak var jinzhi: UILabel!
    
    @IBOutlet weak var tanxin: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let max: UInt32 = 15
        let min: UInt32 = 5
        
        let water:UInt32 = (arc4random_uniform(max - min) + min)
        waterup.text = "\(water)"
        
        let oi:UInt32 = (arc4random_uniform(max - min) + min)
        
        oile.text = "\(oi)";
        
        let jin:UInt32 = (arc4random_uniform(max - min) + min)
        jinzhi.text = "\(jin)";
        
        let tan:UInt32 = (arc4random_uniform(max - min) + min)
        tanxin.text = "\(tan)";
        
        let sum:UInt32 = water + oi + jin + tan
        resultContent.text = "\(sum)";
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
