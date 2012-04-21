# Makefile for creation of several RESY-components
#
# Author: Manuel Hiptmair
# Compiled on: Ubuntu Linux 10.04 the lucid lynx


# To compile the LESS-files into a CSS-file, a LESS-compiler is needed.
# Be aware that those compilers provide different features and probably
# different syntax!
LESSCOMPILER 	= ~/node_modules/less/bin/lessc --compress

# wmctrl makes it possible to interact with the X window manager.
# In this file, wmctrl is used to open up a webbrowser and to resize it.
# This allows the creation of standardized screenshots.
WMCTRL_SEARCH 	= "John Doe"

# The webbrowser of choice which is needed to render the website
# for an automatic screenshot:
WEBBROWSER 	= /usr/bin/firefox

# Command for removing files, only if they exist
REMOVE 		= /bin/rm -f

# Path to temporary folder
TEMP 		= /tmp

# Absolute path to current directory
PROJECT_DIR 	= $(shell pwd)

# Further software required to run this file:
# * imagemagick: to make a screenshot and edit it
# * awk: to extract the colors out of colorsets.csv

all: 		colorsets basestyle preview langfiles
		@echo "Done"

langfiles: 	production/UTF-8/lang_de.inc.php production/UTF-8/lang_en.inc.php
		/usr/bin/iconv --from-code UTF-8 --to-code ISO-8859-1 production/UTF-8/lang_en.inc.php --output production/lang_en.inc.php
		/usr/bin/iconv --from-code UTF-8 --to-code ISO-8859-1 production/UTF-8/lang_de.inc.php --output production/lang_de.inc.php

colorsets: 	colorsets.csv
		@echo "Remove temporary files..."
		${REMOVE} ${TEMP}/colorset* ${TEMP}/resy_config ${TEMP}/coloring.less
		@echo "Removing colorset CSS files in production folder..."
		${REMOVE} production/colorset*
		@echo "Generating colorset LESS-files..."
		/usr/bin/awk --assign=temporary_folder=${TEMP} -f setup_colorsets.awk colorsets.csv
		@echo "Generating link to coloring.less file -- panic mode"
		ln -s ${PROJECT_DIR}/less/coloring.less ${TEMP}/coloring.less
		@echo "Generating colorset CSS-files..."
		find ${TEMP}/colorset* -execdir sh -c '${LESSCOMPILER} {} {}.css --include ${PROJECT_DIR}/less/coloring.less' \;
		@echo "Move generated CSS-files..."
		mv ${TEMP}/colorset*.css ${PROJECT_DIR}/production/
		@echo "Compile config.inc.php..."
		sed '/Colorsets/ r ${TEMP}/resy_config' <config.inc.php >production/config.inc.php

basestyle:	less/base.less less/coloring.less less/verekia.less
		@echo "Compiling stylesheet..."
		${LESSCOMPILER} less/base.less production/style.css
		@echo "Done compiling stylesheet"

preview: 	production/style.css production/index.tpl production/entries.tpl
		@echo "Removing preview images"
		${REMOVE} production/preview_fullsize.jpg production/preview.png
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
		#mogrify -crop 1006x746+1+127 -gravity NorthWest production/preview_fullsize.jpg
		mogrify -crop 1006x746+1+100 -gravity NorthWest production/preview_fullsize.jpg
		@echo "Creating thumbnail..."
		convert -resize 100x production/preview_fullsize.jpg production/preview.png
		#@echo "Kill webbrowser..."
		#wmctrl -c $(WMCTRL_SEARCH)

# vim: tabstop=8 shiftwidth=8 noexpandtab
