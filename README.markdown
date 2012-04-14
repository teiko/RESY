### Short description

RESY is an effort to create a responsive template for the blogging software Serendipity (S9Y)


### Detailed description

RESY is based upon the Responsive Template (RT) by Jonathan Verrecchia, aka Verekia. The goal of RT is to provide a website-template which can be viewed by all sorts of devices -- from standard PC's to Smartphones. Just try the RT demo yourself!

RESY extends the RT not only by adapting the look & feel of S9Y, but also by providing the underlying Stylesheet in LESS-Syntax. With LESS, a Webdesigner is able to create his Stylesheets with less instructions -- hence the name! In addition, the programmer of LESS -- cloudhead -- has added the possibility of styling websites on the fly: no refresh needed (but JavaScript!).
When using LESS, the colors of the template can easily get modified by editing the file less/style.less; if you are comfortable with the overall layout of the template, you can leave all other files untouched.
Later on, when you have developed your wanted style, you can compile the LESS-files into a CSS-file. Yet, this works only if your computer fullfills all requirements and provides the essential software. For more info please have a look at the Makefile or consult the LESS-homepage.

For those who want to go the traditional CSS-way: simple modify the style.css to your needs and be done!


### Compiling:

Please have a look at the Makefile.


### Notes:

  - Keep the filestructure intact, especially if you want to use the LESS-compiler on the fly
  - If you plan to not use LESS, you can delete the entire less/ folder, also the config.inc.php file can be removed -- probably results in a better performance of S9Y


### Resources:
  - [Serendipity](http://www.s9y.org/)
  - [Responsive Template by Verekia](http://www.initializr.com/try)
  - [initializr.com - Home of Verekia and the Responsive Template](http://www.initializr.com/)
  - [LESS](http://lesscss.org/)
  - [cloudhead - programmer of LESS](http://cloudhead.io/)
  - [HTML5 Boilerplate -- h5bp](http://www.html5boilerplate.com/)


### Thanks

Besides Verekia, who put the code of RT as Public Domain, I want to thank Gatis Tomsons from the ruby-forum and Shannon Nelson from stackoverflow.com for their notes about automatic screenshot creation.
Also, my thanks go to the large group of HTML5Boilerplate (h5bp) developers and to Alexis Sellier for his LESS stylesheet language.


### License

RESY is Public Domain
