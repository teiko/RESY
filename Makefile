# Makefile for creation of several RESY-components
#
# Author: Manuel Hiptmair
# Created on: 2012-04-14
# Last update on: 2012-04-16
# Compiled on: Ubuntu Linux 10.04 the lucid lynx


# To compile the LESS-files into a CSS-file, a LESS-compiler is needed.
# Be aware that those compilers provide different features and probably
# different syntax!
LESSCOMPILER 	= ~/node_modules/less/bin/lessc

# wmctrl makes it possible to interact with the X window manager.
# In this file, wmctrl is used to open up a webbrowser and to resize it.
# This allows the creation of standardized screenshots.
WMCTRL_SEARCH 	= "John Doe"

# The webbrowser of choice which is needed to render the website
# for an automatic screenshot:
WEBBROWSER 	= firefox

# Further software required to run this file:
# * imagemagick: to make a screenshot and edit it


static: 	style preview
		@echo "Make all"

style: 		less/style.less less/resy.less less/verekia.less
		@echo "Compiling stylesheet..."
		${LESSCOMPILER} less/style.less > production/style.css
		@echo "Done compiling stylesheet"

preview: 	production/style.css production/index.tpl production/entries.tpl
		@echo "Removing preview images"
		/bin/rm -f production/preview_fullsize.jpg production/preview.png
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
		import -window $(WINDOW_ID) production/preview_fullsize.jpg
		@echo "Removing the webbrowser controls..."
		mogrify -crop 1006x746+1+127 -gravity NorthWest production/preview_fullsize.jpg
		@echo "Creating thumbnail..."
		convert -resize 100x production/preview_fullsize.jpg production/preview.png
		#@echo "Kill webbrowser..."
		#wmctrl -c $(WMCTRL_SEARCH)

# vim: tabstop=8 shiftwidth=8 noexpandtab
