import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';//add this new line；step2

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    //final wordPair = new WordPair.random();
    // add this new line；step2
    //remove；step3
    return new MaterialApp(
      title: 'This is whole title',
      //Where does it appear?

      /*
      home: new Scaffold(
        //使用 Scaffold 类实现基础的 Material Design 布局；step4
        appBar: new AppBar(
          title: const Text('This is appBar title'),
        ),
        body: new Center(//静态Center常量widget树，改为了new widget树对象实例；step2
          //child: const Text('This is body\'s child')
          //原本是使用const text widget树显示生成text方式；step1
          //child: new Text(wordPair.asPascalCase)
          //新widget树实例，asPascalCase大驼峰式命名法；step2
          child: new RandomWords(),
          //利用state类中的build方法来生成随机文本；step3
        ),
      ),
      */

      home: new RandomWords(),
      //用RandomWords()=>build()=>Scaffold()替换原本的一长串Scaffold()；step4
    );
  }
}

class RandomWords extends StatefulWidget{
  @override
  RandomWordsState createState() => new RandomWordsState();
}//step3

class RandomWordsState extends State<RandomWords>{
  final List<WordPair> _suggestion = <WordPair>[];
  //List类型的suggestion变量，初始化为空列表，其中的内容为单词对；step4

  final Set<WordPair> _saved = new Set<WordPair>();
  //Set 中不允许重复的值，故适用于创建收藏集合；step5

  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
  //TextStyle类型的biggerFont变量，初始化为静态的TextStyle变量，其中的fontSize属性值为18.0；step4
  //在 Dart 语言中，使用下划线为前缀标识的变量或函数，会强制其变为所在类的私有变量或函数；step4

  @override
  Widget build(BuildContext context){
    //RandomWordsState=>更新RandomWords=>更新MyApp中的child中的RandomWords()=>更新生成方式

    /*
    final WordPair wordPair = new WordPair.random();
    return new Text(wordPair.asPascalCase);
    //减少耦合，与原方法一样用于生成单词对，一样实现大驼峰式命名法；step3
    */

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Text from RWS\'title'),
      ),
      body: _buildSuggestions(),
    );
  }//使用_buildSuggestions方法生成text；step4

  Widget _buildSuggestions(){
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext _context, int i){
          //BuildContext类型的context私有变量以及int型的i变量；step4
          //在每一列之前，添加一个1像素高的分隔线widget；step4
          if(i.isOdd){
            return new Divider();
            //新的方法前一定要用new声明；step4
            //偶数行时，单词对将被添加一个 ListTile row；step4
          }
          final int index = i ~/ 2;//即 (int)(i/2)；step4

          if(index >= _suggestion.length){
            //如果滑到了最底部，此时分割线的索引大于等于了suggestion List中的单词对数目，则继续生成单词对；step4
            _suggestion.addAll(generateWordPairs().take(10));
            //'.addAll()'函数表示向suggestion表中添加元素；step4
            //'generateWordPairs()'函数表示创建单词对；step4
            //'take(int i)'函数表示创建个数；step4
          }
          return _buildRow(_suggestion[index]);
          //将每个单词对都经过buildRow的处理后再输出；step4
        }
    );
  }

  Widget _buildRow(WordPair wordPair){
    final bool alreadySaved = _saved.contains(wordPair);
    //新建一个bool型值，检查收藏的列表中是否已经包含了某单词对；step5

    return new ListTile(
      title: new Text(
        wordPair.asPascalCase,
        //生成的单词对要进行大驼峰式命名法美化；step4
        style: _biggerFont,
        //style属性的值设为之前声明的biggerFont变量改变字号大小；step4
      ), 
      trailing: Icon(
        alreadySaved ? Icons.star : Icons.star_border,
        //if语句三段式，按照bool类型值来判断是否改变icon绘图；step5
        color: alreadySaved ? Colors.yellow : null,
        //if语句三段式，按照bool类型值来判断是否改变颜色；step5
      ),
    );
  }
}//step3