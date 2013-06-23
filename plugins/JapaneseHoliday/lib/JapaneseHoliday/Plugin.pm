package JapaneseHoliday::Plugin;

use strict;
use Calendar::Japanese::Holiday;

sub japanese_holiday {
    my ($ctx, $args, $cond) = @_;

    my $tag = lc $ctx->stash('tag');
    my $default_tag = $ctx->stash('jpholiday_default_tag');
    my $ts = $default_tag ? $ctx->tag($default_tag, { format => '%Y%m%d%H%M%S' }) :
             $args->{ts} ? $args->{ts} :
             $args->{tag} ? $ctx->tag($args->{tag}, { format => '%Y%m%d%H%M%S' }) :
             $ctx->tag('date', { format => '%Y%m%d%H%M%S' });
    my ($year, $month, $day) = unpack('A4A2A2', $ts);
    $year += 0;
    $month += 0;
    $day += 0;
    my $holiday_name = isHoliday($year, $month, $day, 1);
    if ($tag eq 'ifjpholiday') {
        if ($holiday_name) {
            return $ctx->slurp($args, $cond);
        }
        else {
            return $ctx->_hdlr_pass_tokens_else(@_);
        }
    }
    else {
        return $holiday_name || '';
    }
}

sub default_tag {
    my ($ctx, $args, $cond) = @_;
    my $plugin = MT->component('JapaneseHoliday');

    my $tag = $args->{tag}
        or return $ctx->error($plugin->translate('Please specify tag modifier.'));
    local $ctx->{__stash}{jpholiday_default_tag} = $tag;
    return return $ctx->slurp($args, $cond);
}

1;
