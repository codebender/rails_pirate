Rails Pirate
============

# Ruby on Rails doing R

![pirate flag](http://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Flag_of_Edward_England.svg/500px-Flag_of_Edward_England.svg.png)

Arrrr!

Code Status
------------
[![Build Status](https://semaphoreapp.com/api/v1/projects/059e4052-6e33-4d90-8d1e-5affd067c422/275185/badge.png)](https://semaphoreapp.com/codebender/rails_pirate)
[![Code Climate](https://codeclimate.com/github/codebender/rails_pirate/badges/gpa.svg)](https://codeclimate.com/github/codebender/rails_pirate)
[![Test Coverage](https://codeclimate.com/github/codebender/rails_pirate/badges/coverage.svg)](https://codeclimate.com/github/codebender/rails_pirate)


## Install
  1. brew install dependencies
    ```shell
    brew install gcc
    brew tap homebrew/science
    ```

    Gotcha #1

    Edit /usr/local/Library/Formula/r.rb add build arg '--enable-R-shlib'
    (http://rforge.net/Rserve/doc.html)

    ```shell
    brew install r
    brew install gettext
    ```


    Gotcha #2
    ```shell
    brew link gettext --force
    ```

  1. Install packages by running commands
    ```R
    install.packages('Rserve')
    install.packages('rpart')
    ```
