description "Facades. Front end development awesome-ness."

stylesheet 'screen.scss',  :media => 'all'
stylesheet '_config.scss', :to    => 'shared/_config.scss'
stylesheet 'assets/styles.css', :to    => 'assets/styles.css'

html 'index.html'
file 'humans.txt'
file 'robots.txt'
file 'MIT-LICENSE.txt'

help %Q{
Facades front end awesome-ness. For more information visit https://github.com/kurbmedia/facades
}

welcome_message %Q{
Awww yeahhh, now your getting awesome. If you need more information, visit https://github.com/kurbmedia/facades
}