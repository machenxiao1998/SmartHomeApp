//
//  FirstViewController.swift
//  techhome
//
//  Created by 马晨骁 on 2018/3/30.
//  Copyright © 2018年 macintech. All rights reserved.
//

import UIKit
import SwiftSocket
class FirstViewController: UIViewController{

    @IBOutlet weak var TemNow: UITextField!
    
    @IBOutlet weak var WatSet: UITextField!
    @IBOutlet weak var GangNow: UITextField!
    @IBOutlet weak var SerNow: UITextField!
    @IBOutlet weak var WatNow: UITextField!
    @IBOutlet weak var LastNow: UITextField!
    @IBOutlet weak var DesNow: UITextField!
    @IBOutlet weak var WarmNow: UIProgressView!
    @IBOutlet weak var TemSet: UITextField!
    @IBOutlet weak var SerPos: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SerPos.textColor = UIColor.red
        SerPos.text = "Unknow"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func ReCon(_ sender: Any) {
        let client = TCPClient(address: "172.93.45.197", port: 12345)
        switch client.connect(timeout: 10) {
        case .success:
            SerPos.text="up"
            SerPos.textColor=UIColor.green
            var oper="2"
            client.send(string: oper)
            guard let data0 = client.read(1024*1) else { return }
            oper="41"
            client.send(string: oper)
            guard let data41 = client.read(1024*1) else { return }
            var response = String(bytes: data41, encoding: .utf8)
            var index = response?.index((response?.startIndex)!, offsetBy:3)
            var result = response?.substring(to: index!)
            var num1:Float = 0.1
            num1=Float(result!)!/10.0
            TemNow.text=String(num1)+"摄氏度"
            
            oper="2"
            client.send(string: oper)
            guard let data00 = client.read(1024*1) else { return }
            oper="11"
            client.send(string: oper)
            guard let data11 = client.read(1024*1) else { return }
            response = String(bytes: data11, encoding: .utf8)
            index = response?.index((response?.startIndex)!, offsetBy:3)
            result = response?.substring(to: index!)
            var num2:Float = 0.1
            num2=Float(result!)!/10.0
            TemSet.text=String(num2)+"摄氏度"
            
            WarmNow.setProgress((num2-num1)/10.0, animated: true)
            
            oper="2"
            client.send(string: oper)
            guard let data000 = client.read(1024*1) else { return }
            oper="42"
            client.send(string: oper)
            guard let data42 = client.read(1024*1) else { return }
            response = String(bytes: data42, encoding: .utf8)
            index = response?.index((response?.startIndex)!, offsetBy:3)
            result = response?.substring(to: index!)
            num2=Float(result!)!/10.0
            DesNow.text=String(num2)+"厘米"
            
            oper="2"
            client.send(string: oper)
            guard let data001 = client.read(1024*1) else { return }
            oper="43"
            client.send(string: oper)
            guard let data43 = client.read(1024*1) else { return }
            response = String(bytes: data43, encoding: .utf8)
            index = response?.index((response?.startIndex)!, offsetBy:3)
            result = response?.substring(to: index!)
            var num:Int
            num=Int(result!)!
            LastNow.text=String(num)+"粒"
            
            oper="2"
            client.send(string: oper)
            guard let data002 = client.read(1024*1) else { return }
            oper="44"
            client.send(string: oper)
            guard let data44 = client.read(1024*1) else { return }
            response = String(bytes: data44, encoding: .utf8)
            index = response?.index((response?.startIndex)!, offsetBy:3)
            result = response?.substring(to: index!)
            num2=Float(result!)!/10.0
            WatNow.text=String(num2)+"%"
            
            oper="2"
            client.send(string: oper)
            guard let data003 = client.read(1024*1) else { return }
            oper="12"
            client.send(string: oper)
            guard let data45 = client.read(1024*1) else { return }
            response = String(bytes: data45, encoding: .utf8)
            index = response?.index((response?.startIndex)!, offsetBy:3)
            result = response?.substring(to: index!)
            num2=Float(result!)!/10.0
            WatSet.text=String(num2)+"%"
            
            client.send(string: "6")
            
            case .failure(let error):
            SerPos.text="error";
            break;
           
        }
    }

}

