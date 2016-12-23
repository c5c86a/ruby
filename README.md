[![Travis build status](https://travis-ci.org/nicosmaris/demos.png?branch=master)](https://travis-ci.org/nicosmaris/demos) [![codecov.io](http://codecov.io/github/nicosmaris/demos/coverage.svg?branch=master)](https://codecov.io/gh/nicosmaris/demos/branch/master) 

Demonstration of an algorithm in ruby that finds all solutions in a 2D maze.

It is required to “discover” the route progressively, being only able to inspect and move to any squares that are North, South, East and West from its current position.

## Run sample and read output on terminal

At the folder of the Gemfile, run:

ruby sample.rb

## Input file format

```
first line:max_width max_height
each other line corresponds to a row in a maze and each character can be
0 for the starting vertex, 1 for unvisited vertices, 5 for the goal vertex
or # for the wall
```

## Test

rake test

## Dev workstation

* Ubuntu 16.04
* Ruby MRI at folder ~/.rubies/2.3.1 installed [manually](http://ryanbigg.com/2014/10/ubuntu-ruby-ruby-install-chruby-and-you/)


sudo apt-get install -y build-essential

wget -O ruby-install-0.6.0.tar.gz   https://github.com/postmodern/ruby-install/archive/v0.6.0.tar.gz
tar -xzvf ruby-install-0.6.0.tar.gz
cd ruby-install-0.6.0/
sudo make install
cd ..
rm -rf ruby-install-0.6.0*

mkdir ~/.rubies
ruby-install -i ~/.rubies/2.3.1 ruby 2.3.1

wget -O chruby-0.3.9.tar.gz   https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
tar -xzvf chruby-0.3.9.tar.gz
cd chruby-0.3.9/
sudo make install
cd ..
rm -rf chruby-0.3.9*

echo 'source /usr/local/share/chruby/chruby.sh' >> ~/.bashrc
echo 'source /usr/local/share/chruby/auto.sh' >> ~/.bashrc
exec $SHELL
echo '2.3.1' > ~/.ruby-version

gem install bundler
bundle

