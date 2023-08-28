//
//  Utilities.swift
//  TODO
//
//  Created by caseycheng on 2023/8/27.
//

import Foundation
import SwiftUI
import Markdown
import Markdownosaur

func with<T>(_ t:T,update:(inout T)throws ->  Void) rethrows ->T{
    var this = t
    try update(&this)
    return this
}

final class AppState:ObservableObject{
    static let isFirstLaunch:Bool = {
        let key = "__Launched__"
        
        if UserDefaults.standard.bool(forKey: key){
            return false
        }
        UserDefaults.standard.set(true, forKey: key)
        return true
    }()
    //每个模型的高度
    static let screenHight = UIScreen.main.bounds.height
    //每个模型的宽度
    static let screenWidth = UIScreen.main.bounds.width
    /// 检查暗黑模式
    /// FIXME: dark and light check not effective
    /// 好像只是模拟器展示错误，实机发现没这个问题
    static var userInterfaceStyle:UIUserInterfaceStyle {
        get{
            UITraitCollection.current.userInterfaceStyle
        }
    }
}

final class Theme{
    static var blackAndBlueGradient:LinearGradient{
        LinearGradient(colors: [.black.opacity(0.7),.blue.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    static let secondaryAccentColor = Color("SecondaryAccentColor")
//    static var
}

extension Collection{
    func infiniteConsecutivelyUniqueRandomSequence() -> AnySequence<Element>{
        AnySequence{ () -> AnyIterator in
            var previousOffset:Int?
            
            return AnyIterator{
                var offset:Int
                repeat{
                    offset = Int.random(in: 0..<count)
                }while offset == previousOffset
                previousOffset = offset
                
                return self[index(startIndex, offsetBy: offset)]
            }
        }
    }
}
/**
 让struct可以突变🥰
 */
@propertyWrapper
struct ViewStorage<Value> : DynamicProperty{
    
    private final class ValueBox{
        var value:Value
        
        init(_ value: Value) {
            self.value = value
        }
    }
    @State private var valueBox :ValueBox
    
    var wrappedValue:Value{
        get{ valueBox.value }
        nonmutating set {
            valueBox.value = newValue
        }
    }
    
    var projectdValue:Binding<Value>{
        .init(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }
    init(wrappedValue value: @autoclosure @escaping ()->Value) {
        self._valueBox = .init(initialValue: ValueBox(value()))
    }
}

extension Binding{
    /**
     对Bindingg的值进行出入变换
     
     ```swift
     $foo.map(
        get: { $0.uppercased() },
        set: { $0.lowercased() },
     )
     ```
     */
    func map<Result>(
        get:@escaping (Value) ->Result,
        set:@escaping (Result) ->Value
    )->Binding<Result>{
        .init(
            get: { get(wrappedValue) },
            set: { wrappedValue = set($0) }
        )
    }
}

extension Sequence where Element:Sequence{
    /// 打平
    /// - Returns: [Element.Element]
    func flatten()->[Element.Element]{
        flatMap{ $0 }
    }
}

/// 为Button按钮的label选项的text进行统一设置
struct TextToButtonLabelModifier:ViewModifier{
    let fontColor:Color
    let font:Font
    let backgroundColor:Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(fontColor)
            .font(font)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(10)
    }
}


extension SwiftUI.Text{
    func withTextToButtonLabel(fontColor:Color,font:Font,backgroundColor:Color)->some View{
        self
            .modifier(TextToButtonLabelModifier(fontColor: fontColor, font: font, backgroundColor: backgroundColor))
    }
    /**
     让text显示支持Markdown
     */
    init(markdown:String){
        self.init(LocalizedStringKey(markdown))
    }
}

/// 用于展示Markdown文本
struct MarkDownTextView:UIViewRepresentable{
    @Binding var markDownText:String
    @ViewStorage var markdownosaur:Markdownosaur = Markdownosaur()
    @ViewStorage var alwayBounceVertical:Bool = false
    @ViewStorage var alwayBounceHorizontal:Bool = false
    let darkFontColor:UIColor
    let lightFontColor:UIColor
    
    /// 用于展示Markdown
    /// - Parameters:
    ///   - markDownText: 待解析的Markdown文本
    ///   - darkFontColor: dark模式下使用的字体颜色
    ///   - lightFontColor: light模式下使用的颜色
    init(markDownText: Binding<String>,darkFontColor:UIColor = .white,lightFontColor:UIColor = .darkText) {
        self._markDownText = markDownText
        self.darkFontColor = darkFontColor
        self.lightFontColor = lightFontColor
    }
    
    func makeUIView(context: Context) -> UITextView {
        let text = getUITextView()
        
        text.isEditable = false
        text.attributedText = markdownosaur.attributedString(from: Document(parsing: markDownText))
        
        return text
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        let doc = Document(parsing: markDownText)
        uiView.attributedText = markdownosaur.attributedString(from: doc)
        uiView.textColor = AppState.userInterfaceStyle == .dark ? self.darkFontColor : self.lightFontColor
    }
    
    private func getUITextView()->UITextView{
        with(UITextView(frame: .zero)){
            $0.alwaysBounceVertical = alwayBounceVertical
            $0.alwaysBounceHorizontal = alwayBounceHorizontal
        }
    }
//    func makeCoordinator() -> Coordinator {
//        Coordinator(content: $markDownText)
//    }
//    final class Coordinator:NSObject,UITextViewDelegate{
//        @Binding var content:String
//        init(content: Binding<String>) {
//            self._content = content
//        }
//        
//        func textViewDidChange(_ textView: UITextView) {
//            content = textView.attributedText.string
//        }
//        
//    }
    
}

extension MarkDownTextView{
    /// 允许视图垂直拉动
    func allowVerticalPull()->Self{
        self.alwayBounceVertical = true
        return self
    }
    /// 允许视图横向拉动
    func allowHorizontalPulling()->Self{
        self.alwayBounceHorizontal = true
        return self
    }
}

extension View{
    func ignoreSafeAreaView<Color:View>(color:()->Color,alignment:Alignment = .center,@ViewBuilder action:()->some View) -> some View {
        
        return ZStack(alignment:alignment){
            color().ignoresSafeArea()
            action()
        }
    }
}


func load<T: Decodable>(_ filename:String) -> T {
    let data:Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else{
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do{
        data = try Data(contentsOf: file)
    }catch{
        fatalError("Couldn't load \(filename) form main bundle:\n\(error)")
    }
    
    do{
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }catch{
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}



fileprivate struct PreView:View {
    @State var markDown:String = "## Documentation *歪斜的a*"
    var body: some View {
        VStack{
            MarkDownTextView(markDownText: $markDown)
                .allowVerticalPull()
            ZStack(alignment:.topLeading){
                TextEditor(text: $markDown)
                    .border(Color.black)
                    .opacity(0.7)
            }
                
        }
        .padding()
    }
}


#Preview("dark"){
    PreView()
        .preferredColorScheme(.dark)
}
#Preview("light"){
    PreView()
        .preferredColorScheme(.light)
}

