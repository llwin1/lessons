#!/usr/bin/perl
#Сашкины изменения

use utf8;
use warnings;
use strict;
use LWP::UserAgent;
require LWP::UserAgent;

my $ua = LWP::UserAgent->new;
$ua->timeout(10);
$ua->env_proxy;

my $film = $ARGV[0];
my $url = "http://www.kinopoisk.ru/film/$film/";

my $response = $ua->get($url,'User-Agent' => 'Mozilla/4.76 [en] (Win98; U)','Accept' => 'image/gif, image/x-xbitmap, image/jpeg,
     image/pjpeg, image/png, */*','Accept-Charset' => 'iso-8859-1,*,utf-8', 'Accept-Language' => 'en-US');

if ($response->is_success) {
     #print $response->decoded_content;
 }

else {
     die $response->status_line;
 }


my $result = $response->decoded_content;

#if ($result =~m/<title>([^]*)<\/title>/) {
#if ($result =~m/<title>([[:print:]]*)<\/title>/) { 
#if ($result =~m/<title>(.*)<\/title>/) {
#Test comment by LT
│if ($result =~m/<title>()<\/title>/) {.

    print ("Сохраняем фильм $1","\n");
}

my $file = "result$film.txt";
open(my $fh, '>', "$file");
print $fh $result;
close $fh;
print "Фильм №$film - спизжен\n";




