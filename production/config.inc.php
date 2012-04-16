<?php

# Template options:
$template_config = array(

    # Only the right sidebar is supported:
    array(
        'var'           => 'sidebars',
        'type'          => 'hidden',
        'default'       => 'hide,right'
    ),

    # Options which are allowed in the Verekia-template but need refining:
    array(
        'var'           => 'navigation',
        'type'          => 'hidden',
        'default'       => 'false'
    ),

    array(
        'var'           => 'footer',
        'type'          => 'hidden',
        'default'       => 'false'
    )

);
