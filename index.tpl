{if $is_embedded != true}
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="{$lang}"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="{$lang}"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="{$lang}"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="{$lang}"> <!--<![endif]-->
<head>
    <meta charset="{$head_charset}">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <title>{$blogTitle}</title>
    <meta name="description" content="">
    <meta name="author" content="">
    <meta name="Powered-By" content="Serendipity v.{$head_version}">

    <meta name="viewport" content="width=device-width">

    {if $template_option.useless == 'true'}
        <link rel="stylesheet/less" type="text/css" href="{$serendipityBaseURL}templates/{$template}/less/style.less">
        <script src="{$serendipityBaseURL}templates/{$template}/less/less-1.3.0.min.js" type="text/javascript"></script>
        {if $template_option.liveless == 'true'}
            <script type="text/javascript">less.watch()</script>
        {/if}
    {else}
        <link rel="stylesheet" href="{$head_link_stylesheet}">
    {/if}

    <link rel="alternate" type="application/rss+xml" title="{$blogTitle} RSS feed" href="{$serendipityBaseURL}{$serendipityRewritePrefix}feeds/index.rss2" />
    <link rel="alternate" type="application/x.atom+xml" title="{$blogTitle} Atom feed" href="{$serendipityBaseURL}{$serendipityRewritePrefix}feeds/atom.xml" />

    {if $entry_id}
        <link rel="pingback" href="{$serendipityBaseURL}comment.php?type=pingback&amp;entry_id={$entry_id}" />
    {/if}

    {serendipity_hookPlugin hook="frontend_header"}
</head>
<body>
<!--[if lt IE 7]><p class=chromeframe>Your browser is <em>ancient!</em> <a href="http://browsehappy.com/">Upgrade to a different browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">install Google Chrome Frame</a> to experience this site.</p><![endif]-->
{else}
    {serendipity_hookPlugin hook="frontend_header"}
{/if}

{if $is_raw_mode != true}
    <div id="header-container">
        <header class="wrapper clearfix">
            <div id="title">
                <h1><a class="homelink1" href="{$serendipityBaseURL}"
                    >{$head_title|@default:$blogTitle}</a></h1>
                <h2><a class="homelink2" href="{$serendipityBaseURL}"
                    >{$head_subtitle|@default:$blogDescription}</a></h2>
            </div>
            <nav></nav>
        </header>
    </div>
    <div id="main-container">
        <div id="main" class="wrapper clearfix">

            {if $leftSidebarElements > 0}
                <aside style="float:left;">
                    {serendipity_printSidebar side="left"}
                </aside>
            {/if}

            <article>
                {$CONTENT}
            </article>

            {if $rightSidebarElements > 0}
                <aside>
                    {serendipity_printSidebar side="right"}
                </aside>
            {/if}

        </div> <!-- #main -->
    </div> <!-- #main-container -->

    <div id="footer-container">
        <footer class="wrapper">
        </footer>
    </div>

    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="js/libs/jquery-1.7.2.min.js"><\/script>')</script>

    <script src="js/script.js"></script>
{/if} <!-- endif raw mode -->

{$raw_data}
{serendipity_hookPlugin hook="frontend_footer"}
{if $is_embedded != true}
</body>
</html>
{/if}