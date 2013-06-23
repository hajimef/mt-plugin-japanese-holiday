<?php
require_once('public_holiday.php');

function smarty_block_mtifjpholiday($args, $content, &$ctx, &$repeat) {
    if (!isset($content)) {
        if (isset($args['ts'])) {
            $ts = $args['ts'];
        }
        elseif (isset($args['tag'])) {
            $ts = $ctx->tag($args['tag'], array('format' => '%Y%m%d%H%M%S'));
        }
        elseif ($ctx->stash('jpholiday_default_tag')) {
            $ts = $ctx->tag($ctx->stash('jpholiday_default_tag'), array('format' => '%Y%m%d%H%M%S'));
        }
        else {
            $ts = $ctx->tag('Date', array('format' => '%Y%m%d%H%M%S'));
        }
        list($year, $month, $day) = sscanf($ts, "%04d%02d%02d");
        $r = public_holiday($year, $month, $day);
        return $ctx->_hdlr_if($args, $content, $ctx, $repeat, ($r['rc'] != 0));
    }
    else {
        return $ctx->_hdlr_if($args, $content, $ctx, $repeat);
    }
}
?>
