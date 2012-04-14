# Makefile for creation of several RESY-components
#
# Author: Manuel Hiptmair
# Created on: 2012-04-14
# Compiled on: Ubuntu Linux 10.04 the lucid lynx


# To compile the LESS-files into a CSS-file, a LESS-compiler is needed.
# Be aware that those compilers provide different features and probably
# different syntax!
LESSCOMPILER 	= ~/node_modules/less/bin/lessc

# iconv is used to convert UTF-8 language files into the appropriate
# codepages for S9Y installations
ICONV 		= /usr/bin/iconv

# wmctrl makes it possible to interact with the X window manager.
# In this file, wmctrl is used to open up a webbrowser and to resize it.
# This allows the creation of standardized screenshots.
WMCTRL_SEARCH 	= Firefox

# The webbrowser of choice which is needed to render the website
# for an automatic screenshot:
WEBBROWSER 	= firefox

# Further software required to run this file:
# * imagemagick: to make a screenshot and edit it


static: 	style langfiles preview
		@echo "Make all"

style: 		less/style.less less/resy.less less/verekia.less
		@echo "Compiling stylesheet..."
		${LESSCOMPILER} less/style.less > style.css
		@echo "Done compiling stylesheet"

langfiles: 	UTF-8/lang_en.inc.php UTF-8/lang_de.inc.php
		@echo "Converting language files from UTF-8 to appropriate code pages..."
		${ICONV} --from-code UTF-8 --to-code ASCII UTF-8/lang_en.inc.php --output lang_en.inc.php
		${ICONV} -f UTF-8 -t LATIN1 UTF-8/lang_de.inc.php -o lang_de.inc.php
		@echo "Done converting language files"

preview: 	style.css index.tpl entries.tpl
		@echo "Removing image files..."
		#/bin/rm preview_fullsize.jpg preview.png
		@echo "Generating preview images"
		@echo "Starting webbrowser..."
		${WEBBROWSER} -new-tab http://127.0.0.1/s9y&
		sleep 1
		@echo "Focus webbrowser..."
		wmctrl -a $(WMCTRL_SEARCH)
		@echo "Move webbrowser..."
		wmctrl -e 0,0,0,1024,908 -r $(WMCTRL_SEARCH)
		sleep 1
		@echo "Extracting window id..."
		$(eval WINDOW_ID = $(shell wmctrl -l | grep $(WMCTRL_SEARCH) | cut -c 1-10))
		echo Window-id: $(WINDOW_ID)
		@echo "Generating a screenshot..."
		import -window $(WINDOW_ID) preview_fullsize.jpg
		@echo "Removing the webbrowser controls..."
		mogrify -crop 1006x746+1+127 -gravity NorthWest preview_fullsize.jpg
		@echo "Creating thumbnail..."
		convert -resize 100x preview_fullsize.jpg preview.png
		#@echo "Kill webbrowser..."
		#wmctrl -c $(WMCTRL_SEARCH)

# vim: tabstop=8 shiftwidth=8 noexpandtab
