#!/usr/bin/perl

use warnings;
use strict;

my $url = <STDIN>;
my $sub = '!,$,\',(,),*,+,,,;,='; #sub-delims    = "!" / "$" / "&" / "'" / "(" / ")" / "*" / "+" / "," / ";" / "="

my $d = '0-9';
my $a = 'a-zA-Z';
my $pct = ''; #pct-encoded   = "%" HEXDIG HEXDIG



my $scheme = "";  # scheme      = ALPHA *( ALPHA / DIGIT / "+" / "-" / "." )

my $autority = ""; #authority   = [ userinfo "@" ] host [ ":" port ]
my $userinfo = ""; #userinfo    = *( unreserved / pct-encoded / sub-delims / ":" )
my $login = "";
my $password = "";
my $host = "";      #host        = IP-literal / IPv4address / reg-name
		    #host может состоять только или из IPv4address или из reg-name
		    #IPv4address = dec-octet "." dec-octet "." dec-octet "." dec-octet

# dec-octet   = DIGIT                 ; 0-9
#	           / %x31-39 DIGIT         ; 10-99
#                  / "1" 2DIGIT            ; 100-199
#                  / "2" %x30-34 DIGIT     ; 200-249
#                  / "25" %x30-35          ; 250-255

# reg-name    = *( unreserved / pct-encoded / sub-delims )

my $port = ""; #port        = *DIGIT

my $path = "";# пиздец, потом разберу
my $query = "";#  query       = *( pchar / "/" / "?" )
my $fragment = "";# fragment    = *( pchar / "/" / "?" )


#$url =~m/([$a]+[$a,$d,\+,\-,\.]*)/;

#print ($print_scheme);

             (---------scheme--------)                       )userinfo
if ($url =~m/(([$a]+[$a,$d,\+,\-,\.]*)(   (userinfo) (host) (port)   )        )/){
my $scheme = $1;
my $authority = $;

print ("\tscheme: $scheme\n
\tauthority: 1234\n
\tuserinfo: 2134\n
\tlogin: 4332\n
\tpassword: 324\n
\thost: 123312\n
\tport: 1441\n
\tpath: 123\n
\tquery: 532\n
\tfragment: 35634\n
");
}

else{
print ("Некорректный URL\n\n");
}

