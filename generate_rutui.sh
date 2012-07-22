rm rutui.rb
echo "#" > rutui.rb
echo "# Generated one file script of rutui" >> rutui.rb
echo "# This file is commandless and stripped down" >> rutui.rb
echo "# For full source please visit:" >> rutui.rb
echo "#   https://github.com/b1nary/rutui" >> rutui.rb
echo "#" >> rutui.rb
echo "# Author: Roman Pramberger (roman.pramberger@gmail.com)" >> rutui.rb
echo "# License: MIT" >> rutui.rb
echo "#" >> rutui.rb
echo -n "# " >> rutui.rb
date >> rutui.rb
echo "#" >> rutui.rb
echo "class RuTui" >> rutui.rb
cat lib/util.rb | egrep -v "(^#.*|^$)" >> rutui.rb
cat lib/pixel.rb | egrep -v "(^#.*|^$)" >> rutui.rb
cat lib/theme.rb | egrep -v "(^#.*|^$)" >> rutui.rb
cat lib/objects.rb | egrep -v "(^#.*|^$)" >> rutui.rb
cat lib/screen.rb | egrep -v "(^#.*|^$)" >> rutui.rb
cat lib/screenmanager.rb | egrep -v "(^#.*|^$)" >> rutui.rb
cat lib/figlet.rb | egrep -v "(^#.*|^$)" >> rutui.rb
cat lib/ansi.rb | egrep -v "(^#.*|^$)" >> rutui.rb
cat lib/axx.rb | egrep -v "(^#.*|^$)" >> rutui.rb
cat lib/sprites.rb | egrep -v "(^#.*|^$)" >> rutui.rb


echo "end" >> rutui.rb
#rm rutui-0.1.gem
#gem build rutui.gemspec
#sudo gem install rutui-0.1.gem

cp rutui.rb ../../Ruby/BämBox/
