//
//  GameViewController.swift
//  LetsRun.Com
//
//  Created by Max Norman on 7/17/17.
//  Copyright © 2017 Max Norman. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        QuestionText.isHidden = true;
        setLabel();
        makeListOfQuestions();
        currentQuestion = questionList[0]

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var QuestionText: UILabel!
    @IBOutlet weak var fiveKLabel: UILabel!
    @IBOutlet weak var hotnessLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    
    var fKTime = "17:10";
    var hotness = 3;
    var money = 100;

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBOutlet weak var Intro: UIView!
    @IBOutlet weak var oneBut: UIButton!
    @IBOutlet weak var twoBut: UIButton!
    @IBOutlet weak var threeBut: UIButton!
    @IBOutlet weak var fOp: UILabel!
    @IBOutlet weak var tOp: UILabel!
    @IBOutlet weak var sOp: UILabel!
    @IBAction func ReadyButtonPressed(_ sender: Any) {
        Intro.isHidden = true;
        QuestionText.isHidden = false;
        dispQuestion(Q: questionList[0]);
    
    }
    func dispQuestion(Q : Question) {
        //Sets the labels to their corresponding parts of question
        QuestionText.text = Q.Questiond;
        fOp.text = Q.answer1;
        sOp.text = Q.answer2;
        tOp.text = Q.answer3;
    }
    var questionList : [Question] = [];
    var currentQuestion : Question? = nil;
    var currentNum = 0;
    func makeListOfQuestions(){
        //Simple helper function that is used of adding all the questions and adding them to an array
        /* The format for the results of a decision is a string with the format 
         / "_TIME_a value added to be added to the wife hotness_a value added to the income_the next question(by index)"
         /this supports negative INTS - only INTS
         */
        var q1 = Question()
        q1.addQuestion(Q: "You are entering your senior year of HighSchool. What is your plan for the Summer?",ans1 :"Summer of Malmo!", ans2: "Party Hard", ans3: "Get an internship", ansD1: "_15:40_-1_80_1", ansD2: "_16:40_1_45_2", ansD3: "_16:30_0_400_2")
        questionList.append((q1));
        
        var q2 = Question();
        q2.addQuestion(Q: "A Divison 1 college coach contacts you asking if you would be interested in running for his team, with a scholarship", ans1: "Sure" , ans2: "I'll weigh my options.", ans3: "I dont see myself attending a college", ansD1: "_15:10_1_1000_3", ansD2: "_15:30_0_800_4", ansD3: "_15:35_0_600_6");
        questionList.append(q2);
        
        var q3 = Question();
        q3.addQuestion(Q: "A Divison 2 college coach contacts you asking if you would be interested in running for his team, with a scholarship", ans1: "Sure" , ans2: "I'll weigh my options.", ans3: "I dont see myself attending a college", ansD1: "_15:15_1_1000_5", ansD2: "_15:15_0_800_5", ansD3: "_15:45_0_600_6");
        questionList.append(q3);
        
        let q4 = Question()
        q4.addQuestion(Q: "At your weak D1 School your focus is:", ans1: "Grinding", ans2: "Studying", ans3: "Partying", ansD1: "_14:30_0_1000_7", ansD2:"_14:40_0_10000_8" , ansD3: "_14:40_2_1000_9");
        questionList.append(q4);
        
        let q5 = Question()
        q5.addQuestion(Q: "At your average D1 School you walked on to, your focus is:", ans1: "Grinding", ans2: "Studying", ans3: "Partying", ansD1: "_14:30_0_1000_7", ansD2:"_14:40_0_10000_8" , ansD3: "_14:40_2_1000_9");
        questionList.append(q5);
        
        let q6 = Question()
        q6.addQuestion(Q: "At your D2 School, your focus is:", ans1: "Grinding", ans2: "Studying", ans3: "Partying", ansD1: "_14:30_0_1000_7", ansD2:"_14:40_0_10000_8" , ansD3: "_14:40_2_1000_9");
        questionList.append(q6);
        
        let q7 = Question()
        q7.addQuestion(Q: "At your Junior College, your focus is:", ans1: "Grinding", ans2: "Studying", ans3: "Partying", ansD1: "_14:30_0_1000_7", ansD2:"_14:40_0_10000_8" , ansD3: "_14:40_2_1000_9");
        questionList.append(q7);
        let q8 = Question()
        
    }
    // each of these are the function buttons and use the ansDecode function
    @IBAction func stAnswer(_ sender: Any) {
        ansDecode(ans: currentQuestion!.ans1D);
        setLabel();
    }
    @IBAction func ndAnswer(_ sender: Any) {
        ansDecode(ans: currentQuestion!.ans2D);
        setLabel();
    }
    @IBAction func rdAnswer(_ sender: Any) {
        ansDecode(ans: currentQuestion!.ans3D)
        setLabel();
    }
    
    
    func ansDecode(ans : String){
        // takes the ans string and "decodes it by breaking it apart by "_"
        let arr = ans.components(separatedBy: "_");
        fKTime = arr[1];
        hotness += Int(arr[2])!
        money += Int(arr[3])!
        nextQuestion(c: Int(arr[4])!)
        
    }
    
    func setLabel(){
        fiveKLabel.text =  fKTime;
        hotnessLabel.text = String(hotness);
        moneyLabel.text = String(money);
    }
    
    func nextQuestion(c : Int){
        currentNum = c ;
        currentQuestion = questionList[currentNum];
        dispQuestion(Q: currentQuestion!);
    }
    

}

class Question {
    var Questiond : String = "";
    
    var answer1 : String = "";
    var answer2 : String = "";
    var answer3 : String = "";
    
    var ans1D = "";
    var ans2D = "";
    var ans3D = "";
    
    func addQuestion(Q : String, ans1 : String, ans2: String, ans3 : String, ansD1 : String, ansD2 : String, ansD3: String){
        Questiond = Q;
        answer1 = ans1;
        answer2 = ans2;
        answer3 = ans3;
        
        ans1D = ansD1
        ans2D = ansD2
        ans3D = ansD3
        
    }
    
}

