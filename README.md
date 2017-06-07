# DemoAmrToWav
iOS 与 android 之间的音频格式。`iOS-WAV`    `android-AMR`  

## 文件说明 

- opencore.sh  自动编译脚本 [参考 编译opencore-amr for iOS8并支持bitcode](http://www.ifun.cc/blog/2015/10/23/bian-yi-opencore-amr-for-ios8bing-zhi-chi-bitcode/)

- opencore-amr-0.1.3.tar.gz  自动编译时用到的文件[下载地址](https://sourceforge.net/projects/opencore-amr/files/)

- VoiceTypeTool  用我们编译好的 libopencore-amrnb.a 和 libopencore-amrwb.a库制作的音频格式转化的工具库。

- DemoAmrToWav  介绍如何使用我们打包的 libVoiceTypeTool.a

## 脚本编译 opencore-amr
1. 根据脚本的源码 创建.sh 脚本文件
2. 下载脚本编译用到的`opencore-amr-0.1.3.tar.gz`文件
3. 将以上两个文件放到同一根目录下
4. cd 到 文件的根目录，将 .sh 文件拽入terminal中，运行
5. 执行完成之后会在同一目录下得到lib-ios 文件夹 里面有我们需要的include头文件 与 libopencore-amrnb.a、libopencore-amrwb.a

我们得到的静态库就是支持bitcode。之后我们再次使用该静态库制作另外的静态的库的时候，我们的静态库也是可以支持bitcode的。具体可以参考 VoiceTypeTool 这里是静态库的制作。（静态库的制作在这就不介绍了可以参考[iOS 打包静态库](http://note.youdao.com/noteshare?id=3dc7d94434253dc5c4c728973e65daa2)）

## 使用 
- SFJRecordTool 封装的是一些对录音与播放的基本操作
- VoiceTypeTool wav 与 amr格式互转。

--

```Objective-c
- (NSData *)amrToWav:(NSData *)amrData;
- (NSData *)wavToAmr:(NSData *)wavData;
```
> 说明 ：直接将 `VoiceTypeTool.h` `libVoiceTypeTool.a`拉入到工程中，就可以使用了。完美支持bitcode。如果版本不支持，可以自己动手从新制作 libopencore-amrnb.a、libopencore-amrwb.a 再重新制作静态库。

## 总结

经过opencore-amr库的编译，以及上一篇openssl库的编译（制作的是一个RSA解密的静态库[HBRSAHandlerLib](https://github.com/shafujiu/HBRSAHandlerLib)）

可以得出一个结论，我们在制作自己的静态库的时候，默认系统是支持bitcode。但是如果我们的静态库中引入了其他的静态库，如果在引入的库中包含不支持bitcode的库，那么我们制作出来的静态库，也不会支持bitcode。所以解决办法就是，如果引入了第三方静态库，那么就采用自动编译的方式编译一份支持bitcode的库。openssl 与 opencore-amr 都是采用脚本自动编译的方式。





