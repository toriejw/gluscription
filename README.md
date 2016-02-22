# README

## Description

Gluscription is an application that allows users with celiacs to search for prescription and OTC drugs, and find out if they are safe. It uses the OpenFDA API to search for drugs. It was a two-week individual project for Turing School. The live version of the app can be found here: [http://gluscription.herokuapp.com/](http://gluscription.herokuapp.com/).


![](http://g.recordit.co/HJEiwA2isk.gif)

## Running Locally

* `git clone https://github.com/toriejw/gluscription.git`  
* `bundle`  
* `bundle exec rake db:migrate`  
* visit `http://localhost:3000/`

### Running Tests  

You will need to have Firefox installed in order to run the tests. If you do not want to use firefox, you can change the default browser used by selenium.  

After cloning, bundling, and creating the database, do the following:

`bundle exec rake`
