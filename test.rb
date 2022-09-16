require 'webrick'

server = WEBrick::HTTPServer.new({ #WEBrickインスタンス作成
  :DocumentRoot => '.', #webアプリケーションのドメイン設定
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,#このプログラムを実行・翻訳できるプログラム・Ruby本体の居場所を指定する。
  :Port => '3000',#このWebアプリケーションの情報の出入り口を表す設定。
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}

server.mount('/test', WEBrick::HTTPServlet::ERBHandler, 'test.html.erb')#Webサーバを起動した状態で、（DocumentRootの値）/testというURLを送信すると、同じディレクトリ階層にあるtest.html.erbファイルを表示する
server.mount('/excercise', WEBrick::HTTPServlet::ERBHandler, 'excercise.html.erb')

server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb')

server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')

server.start
