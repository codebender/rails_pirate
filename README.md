rails_pirate
============

* Ruby on Rails doing R

![pirate flag](http://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Flag_of_Edward_England.svg/500px-Flag_of_Edward_England.svg.png)

Arrrr!


** Install
  1. brew install dependencies
    ```shell
    brew install gcc
    brew tap homebrew/science
    ```
    
    (Gotcha #1)
    Edit /usr/local/Library/Formula/r.rb add build arg '--enable-R-shlib'
    - http://rforge.net/Rserve/doc.html
    ```shell
    brew install r
    brew install gettext
    ```

    (Gotcha #2)
    ```shell
    brew link gettext --force (Gotcha #2)
    ```

  1. Install packages by running commands
    ```R
    install.packages('Rserve')
    install.packages('rpart')
    ```
