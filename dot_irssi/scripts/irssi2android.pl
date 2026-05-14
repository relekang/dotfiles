use strict;
use warnings;

#####################################################################
# This script sends notifications to your
# Android using the NMA (Notify my Android) API when you have
# been idling long enough.
#
# This script is based on irssinotifo by Caesar 'sniker' Ahlenhed.
# Original url: http://sniker.codebase.nu/files/irssinotifo.pl
#
# Commands:
# /set irssi2android_nma_api	    API_KEY                 (Default NULL)
# /set irssi2android_general_hilight on/off           (Default OFF)
# /set irssi2android_idletime (idle time in minutes) (Default 30)
#
# /irssi2android <message, sends a test message thru the api>
#
# "General hilight" basically referrs to ALL the hilights you have
# added manually in irssi, if many, it can get really bloated if
# turned on. Default is Off.
#
# You will need the following packages:
# LWP::UserAgent (You can install this using cpan -i LWP::UserAgent)
# Crypt::SSLeay  (You can install this using cpan -i Crypt::SSLeay)
# 
# Or if you're using Debian GNU/Linux:
# apt-get update;apt-get install libwww-perl libcrypt-ssleay-perl
#
# 
#####################################################################


use Irssi;
use Irssi::Irc;
use vars qw($VERSION %IRSSI);

use LWP::UserAgent;
use HTTP::Request::Common;
use URI::Escape

$VERSION = "0.2";

my $last_gui_action = time();

%IRSSI = (
    authors     => "Juho Garo Makinen",
    contact     => "juho.makinen\@gmail.com",
    name        => "irssi2android",
    description => "Sends notifonotifications when user has been idle long enough (iOS AND ANDROID)",
    license     => "GPLv2",
    url         => "https://github.com/garo/irssi2android"
);

# Configuration settings and default values.
Irssi::settings_add_bool("irssi2android", "irssi2android_general_hilight", 0);
Irssi::settings_add_str("irssi2android", "irssi2android_nma_api", "");
Irssi::settings_add_int("irssi2android", "irssi2android_idletime", 30);

sub send_nma {
    my ($title, $head, $text) = @_;
    my %options = ();
    $options{'application'} ||= "irc: " . $title;
    $options{'priority'} ||= 0;
    $options{'apikey'} = Irssi::settings_get_str("irssi2android_nma_api");
    $options{'event'} =  $head;
    $options{'notification'} = $text;

    # Generate our HTTP request.
    my ($userAgent, $request, $response, $requestURL);
    $userAgent = LWP::UserAgent->new;
    $userAgent->agent("NMAScript/1.0");
    $userAgent->env_proxy();

    my $developerKeyString = "";
 
    $requestURL = sprintf("https://nma.usk.bz/publicapi/notify?apikey=%s&application=%s&event=%s&description=%s&priority=%d%s",
			  $options{'apikey'},
			  $options{'application'},
			  $options{'event'},
			  $options{'notification'},
			  $options{'priority'},
			  $developerKeyString);
    $request = HTTP::Request->new(GET => $requestURL);

    $response = $userAgent->request($request);

    if ($response->is_success) {
	# Irssi::print("Notification $title : $text successfully posted.");
    } else {
	Irssi::print("Notification not posted: " . $response->content);;
    }

}

sub send_noti {
    my ($title, $head, $text) = @_;

    my $sent = 0;
    if (Irssi::settings_get_str("irssi2android_nma_api") ne "") {
	send_nma($title, $head, $text);
	$sent = 1;
    }

    # Add your own api gateways here

    if ($sent == 0) {
	Irssi::print("Notification $title : $text not posted, because no api key was defined for any supported api.");
    }
   
}

sub pubmsg {
    my ($server, $data, $nick) = @_;

    if($server->{usermode_away} == 1 && $data =~ /$server->{nick}/i){
        send_noti("Hilighted", $nick,  $data);
    }
}

sub privmsg {
    my ($server, $data, $nick) = @_;
    if($server->{address} ne 'q.lkng.me'){
        if(is_idle() == 1){
             send_noti("PM", $nick, $data);
        }
    }
}

sub genhilight {
    my($dest, $text, $stripped) = @_;
    my $server = $dest->{server};

    if($dest->{level} & MSGLEVEL_HILIGHT) {
        if(is_idle() == 1){
            if(Irssi::settings_get_bool("irssi2android_general_hilight")){
                send_noti("General Hilight", "hilight", $stripped);
            }
        }
    }
}

sub key_pressed {
    $last_gui_action = time();
}

sub is_idle {
    if ($last_gui_action + Irssi::settings_get_int("irssi2android_idletime") * 60 < time()) {
	return 1;
    } 
    return 0;
}

sub cmd_irssi2android {
	my ($arg, $server, $witem) = @_;
	if ($arg =~ /^"(.+?)"\s(.+)/) {
	    send_noti("Manual message", $1, $2);
	    Irssi::print("Sent: $1, $2");
	} elsif ($arg =~ /^(.+?)\s(.+)/) {
	    send_noti("Manual message", $1, $2);
	    Irssi::print("Sent: $1, $2");
	} else {
	    send_noti("Manual message", "manual", $arg);
	    Irssi::print("Sent: manual, " . $arg);
	}
	
}

Irssi::signal_add_last('message public', 'pubmsg');
Irssi::signal_add_last('message private', 'privmsg');
Irssi::signal_add_last('print text', 'genhilight');
Irssi::signal_add_last("gui key pressed", 'key_pressed');

Irssi::command_bind('irssi2android',\&cmd_irssi2android);
