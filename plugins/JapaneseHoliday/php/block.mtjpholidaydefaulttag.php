<?php
function smarty_block_mtjpholidaydefaulttag($args, $content, &$ctx, &$repeat) {
    $localvars = array('jpholiday_default_tag');

    if (!isset($content)) {
        $tag = $args['tag'];
        $ctx->localize($localvars);
        $ctx->stash('conditional', 1);
        $ctx->stash('jpholiday_default_tag', $tag);
    }
    else {
        $ctx->restore($localvars);
    }
    return $content;
}
?>
