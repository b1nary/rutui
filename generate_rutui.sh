rm rutui.rb
echo "# Generated one file script of rutui" > rutui.rb
echo "# This file is commandless and stripped down" >> rutui.rb
echo "# For full source please visit:" >> rutui.rb
echo "#   " >> rutui.rb
echo "#" >> rutui.rb
echo "# Author: Roman Pramberger (roman.pramberger@gmail.com)" >> rutui.rb
echo "# License: MIT" >> rutui.rb
echo "class RuTui" >> rutui.rb
cat lib/util.rb | egrep -v "(^#.*|^$)" >> rutui.rb
cat lib/objects.rb | egrep -v "(^#.*|^$)" >> rutui.rb
cat lib/pixel.rb | egrep -v "(^#.*|^$)" >> rutui.rb
cat lib/screen.rb | egrep -v "(^#.*|^$)" >> rutui.rb
cat lib/screenmanager.rb | egrep -v "(^#.*|^$)" >> rutui.rb
cat lib/figlet.rb | egrep -v "(^#.*|^$)" >> rutui.rb

echo "end" >> rutui.rb
