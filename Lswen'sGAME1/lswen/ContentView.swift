//
//  ContentView.swift
//  lswen
//
/**                Text("|-------------|-------------|")
 .font(.largeTitle)
 .multilineTextAlignment(.center)
 .frame(width: 500, height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
 .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
 
 .position(x: 207, y: 10)
//Image(systemName: "mic")

 **/
//  Created by lswen on 2021/3/4.
//

import SwiftUI
import AVFoundation
var topic = [
    Topic(Question: "兩姐妹，一樣長，酸甜苦辣她先嚐。", Prompt: "日常用品", Ans: "筷子"),
    Topic(Question: "在家臉上白，出門臉上花，遠近都能到，一去不回家。", Prompt: "日常用品", Ans:"信"),
    Topic(Question: "說馬不像馬，路上沒有它。若用它做藥，要到海中抓。", Prompt: "動物", Ans: "海馬"),
    Topic(Question: "不是點心不是糖,軟軟涼涼肚裡藏,不能吃來不能喝,每天也要嘗一嘗。", Prompt: "日常用品" , Ans: "牙膏"),
    Topic(Question: "遠看兩個零，近看兩個零。有人用了行不得，有人不用不得行。", Prompt: "日常用品", Ans: "眼鏡"),
    Topic(Question: "五月花和百合花哪一個沒有生小孩？", Prompt: "日常用品", Ans: "五月花。因為五月花衛生紙(未生子)。"),
    Topic(Question: "長的少，短的多，腳去踩，手去摸。", Prompt: "日常用品", Ans: "梯子"),
    Topic(Question: "為我打你，為你打我，打破你的皮，流出我的血。", Prompt: "昆蟲", Ans: "蚊子"),
    Topic(Question: "黑人和白雪公主結婚會生下什麼小女孩?", Prompt: "與顏色有關", Ans: "灰姑娘"),
    Topic(Question: "看看沒有，摸摸倒有，似冰不化，似水不流。", Prompt: "日常用品", Ans: "鏡子"),
    Topic(Question: "百姐妹，千姐妹，同床睡，名蓋被", Prompt: "水果", Ans: "石榴")
]//題目


struct ContentView: View {
    @State private var num=0//計數器
    @State private var topic1=topic[0]
    @State private var ans=false
    @State private var prompt=false
    @State private var text=""
    @State private var TotalScore=0
    @State private var topiccount=0
    var body: some View {
        ZStack{
            Image("lanter")
                .resizable()
                .scaledToFill()
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .edgesIgnoringSafeArea(.all)
            VStack{
                Spacer(minLength: 100)
                Text("第\(num+1)題")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                    .background(Color(red: 255, green: 0, blue: 0, opacity	: 0.5))
                    .cornerRadius(15)
                HStack {
                    Button(action: {
                        var SayQuestion=AVSpeechUtterance(string: topic1.Question)
                        SayQuestion.voice=AVSpeechSynthesisVoice(language: "zh-TW")
                        SayQuestion.rate=0.4
                        SayQuestion.pitchMultiplier=1.0
                        SayQuestion.volume=0.8
                        let synthesizer = AVSpeechSynthesizer()
                        synthesizer.speak(SayQuestion)
                    }, label: {
                        Image(systemName: "play")
                            .padding()
                            .font(Font.system(size: 18, weight: .heavy))
                            .foregroundColor(Color(red: 100/255, green: 200/255, blue:100/255, opacity: 1))
                            .background(Color(red: 94/255, green: 134/255, blue:193/255, opacity: 0.9))
                            .cornerRadius(50)
                    })//SayTheTopic
                    
                    Text(topic1.Question)
                        .multilineTextAlignment(.leading)
                        .padding()
                        .background(Color(red: 255/255, green: 128/255, blue: 0, opacity: 0.8))
                        .cornerRadius(17)
                }
                HStack {
                    Text("答案:")
                        .padding(.horizontal, 20.0)
                        .padding(.vertical)
                        .background(Color(red: 1, green: 1, blue:1, opacity: 0.8))                        .cornerRadius(13)
                    TextField("請輸入",text:$text)
                            .padding(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/)
                            .padding(.horizontal, 50.0)
                        .frame(width: 170.0, height: 50.0)
                        .background(Color(red: 1, green: 1, blue:1, opacity: 0.8))
                        .cornerRadius(13)
                }
                HStack{
                    Group{
                        Button(action: {
                            if(num>=9){
                                num=0
                                topic.shuffle()
                                topic1=topic[0]
                                topiccount=0
                                
                            }else{
                                topiccount+=1
                                topic1=topic[topiccount]
                                num+=1
                            }
                            prompt=false
                            ans=false
                        }, label: {
                            Text("下一題")
                        })//printnext
                        Button(action: {
                            prompt=true
                        }, label: {
                            Text("提示")
                        })//printans
                        if prompt==true{
                            Text(topic1.Prompt)
                                .foregroundColor(.red)
                        }
                        Button(action: {
                            if text==topic1.Ans {
                                TotalScore+=1
                            }
                            ans=true
                        }, label: {
                            Text("答案")
                        })//printans
                        if ans==true{
                            Text(topic1.Ans)
                                .foregroundColor(.red)
                        }
                    }
                    .padding()
                    .background(Color(red: 0, green: 0, blue: 0, opacity: 0.8))
                    .cornerRadius(13)
                }
                Text("TotalScore:\(TotalScore)")
                    .padding()
                    .background(Color(red: 0, green: 0, blue: 0, opacity: 0.8))
                    .foregroundColor(.red)
                    .cornerRadius(13)
                Spacer(minLength:50)
                Button(action: {
                    topic.shuffle()
                    topic1=topic[0]
                    num = 0
                    ans=false
                    prompt=false
                    TotalScore=0
                    topiccount=0
                    },label: {
                    Text("重新選10題")
                        .padding()
                        .background(Color(red: 0, green: 0, blue: 0, opacity: 0.8))
                        .cornerRadius(13)
                        .foregroundColor(.red)
                    })
            }.onAppear(perform: {
                topic.shuffle()
                topic1=topic[0]
            })
        }
        
    }

}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
          ContentView()
    }
}
		
