# Reads in the colorsets.csv and exports individual sets into LESS-files
#
# Author: Manuel Hiptmair
#
# This script expects input files with the following structure:
# 	Column 1: Name of a colorset; only the characters a-z and underscores are recognized
# 	Column 2 to Column 4: Can hold either color definitions in hexadecimal notation (#fff, #000, and so on) or colornames like white, black, ... Both uppercase and lowercase characters are accepted.
#
# Records with an invalid structure are ignored.
#
# Records with valid structure are prepared as LESS-Stylesheets and as template configuration options with PHP syntax.
#
# Columns in the CSV file are separated by a colon. A valid record may look like:
# 	iceblue,#91b7cc,#25253d,#febf02
# An invalid record may look like:
# 	ice blue,#91b7cc,#25253d,#febf02


BEGIN {
	FS = ","        # Field-Separator
}

# Extract record:
$0 ~ /[a-z_]+,#?[A-Za-z0-9]+,#?[A-Za-z0-9]+,#?[A-Za-z0-9]+,.*$/ {

	# Compile filenames
	less_filename = temporary_folder "/colorset_" $1
	config_filename = temporary_folder "/resy_config"

	# Generate LESS file for extracted colorset:
	print "// Automatically generated" > less_filename
	print "@lightColor:" $2 ";" >> less_filename
	print "@darkColor:" $3 ";" >> less_filename
	print "@contrastColor:" $4 ";" >> less_filename
	print "@import 'coloring.less';" >> less_filename

	# Output colorset
	print "            '" $1 "' => RESY_COLORSET_" toupper($1) "," >> config_filename
}
