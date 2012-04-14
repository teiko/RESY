<?php

# Probe for a language include with constants. Still include defines later on, if some constants were missing
$probelang = dirname(__FILE__) . '/' . $serendipity['charset'] . 'lang_' . $serendipity['lang'] . '.inc.php';
if (file_exists($probelang)) {
    include $probelang;
}

include dirname(__FILE__) . '/lang_en.inc.php';

# Template options:
$template_config = array(

    # Only the right sidebar is supported:
    array(
        'var'           => 'sidebars',
        'type'          => 'hidden',
        'default'       => 'hide,right'
    ),

    array(
        'var'           => 'useless',
        'name'          => RESY_OPTION_USELESS,
        'description'   => RESY_OPTION_USELESS_DESCRIPTION,
        'type'          => 'boolean',
        'default'       => 'false'
    ),

    array(
        'var'           => 'liveless',
        'name'          => RESY_OPTION_LIVELESS,
        'description'   => RESY_OPTION_LIVELESS_DESCRIPTION,
        'type'          => 'boolean',
        'default'       => 'false'
    )

);
