package JapaneseHoliday::Plugin;

use strict;
use Calendar::Japanese::Holiday;

sub japanese_holiday {
    my ($ctx, $args, $cond) = @_;

    my $tag = lc $ctx->stash('tag');
    my $ts = $args->{ts} ? $args->{ts} :
             $args->{tag} ? $ctx->tag($args->{tag}, { format => '%Y%m%d%H%M%S' }) :
             $ctx->tag('date', { format => '%Y%m%d%H%M%S' });
    my ($year, $month, $day) = unpack('A4A2A2', $ts);
    $year += 0;
    $month += 0;
    $day += 0;
    my $holiday_name = isHoliday($year, $month, $day, 1);
    if ($tag eq 'dateifjapaneseholiday') {
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

1;
