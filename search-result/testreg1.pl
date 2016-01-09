#!/usr/bin/perl

use utf8;
use warnings;
use strict;
use LWP::UserAgent;
use Time::localtime;
require LWP::UserAgent;

my $tm = localtime;
my $filmyear = "1985";
my $ua = LWP::UserAgent->new;
$ua->timeout(10);
$ua->env_proxy;


my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
my $time = sprintf("%02d:%02d:%02d", $hour, $min, $sec);

my @array=('Рокки 4','Коммандос','Рэмбо: Первая кровь 2','Враг мой','Полицейская история','Легенда','Жемчужина Нила','Клуб Завтрак','Жизненная сила','Сердце Дракона','Леди-ястреб','Полицейская академия 2: Их первое задание','Кошмар на улице Вязов 2: Месть Фредди','Однажды укушенный','Европейские каникулы','Молодой Шерлок Холмс','Королева варваров','Эвоки: Битва за Эндор','Ох уж эта наука!','Имя ему Смерть','Бразилия','Американский Ниндзя','День мертвецов','Он хуже меня','Ночь Страха','Плоть + кровь','После дождичка в четверг','Тайная прогулка','Тихая Земля','Кошачий глаз','Вид на убийство','Частный курорт','Волчонок','Покровитель','Из Африки','Ран / Хаос / Смута','Пятница 13 - Часть 5: Новое начало','Черная стрела','Мои Счастливые Звезды 2','Кокон','Волшебное Рождество','Свидетель','Комната с видом','Улика','Поезд-беглец','Реаниматор','Девочки хотят повеселиться','Под платьем ничего нет / Слишком красивые чтобы умереть','Парень что надо','Не ходите девки замуж','Цветы лиловые полей','Русь изначальная','Последняя надежда','Абсолютно точно (Верняк)','Вторжение в США','Хронос','Храм Шаолинь 3: Боевые искусства Шаолиня','Подземка','Невеста','Девять с половиной недель');
my $ffURL = "";

for my $film_name (@array){
my $film = "$film_name $filmyear";
print ("\t"x"8","Парсим выдачу по запросу \"$film\"\n");
my $url = "http://www.kinopoisk.ru/index.php?first=no&what=&kp_query=$film/";
my $response = $ua->get($url,'User-Agent' => 'Mozilla/4.76 [en] (Win98; U)','Accept' => 'image/gif, image/x-xbitmap, image/jpeg,
image/pjpeg, image/png, */*','Accept-Charset' => 'iso-8859-1,*,utf-8', 'Accept-Language' => 'en-US');
sleep (5);

	if ($response->is_success){
	my $successLOG ="success.txt";
	open(my $fh, '>>', "$successLOG") or die "Не могу открыть '$successLOG' $!";
	print $fh "$time - Нашли \"$film\"\n";
	}

	else {
	my $failLOG ="fail.txt";
	open(my $fh, '>>', "$failLOG") or die "Не могу открыть '$failLOG' $!";
	print $fh "$time - АХТУНГ, не открылась страница поиска по фильму \"$film\"\n";
	die $response->status_line;
}

my $a = $response->decoded_content;
		if($a =~m/<p class="name"><a href="([^"]+)">([^<]+)<\/a>\s<span class="year">$filmyear<\/span><\/p>/) {
		sleep (10);
		$ffURL ="http://www.kinopoisk.ru$1";

#if($film_name eq $2){
if ($film){
				my $response = $ua->get($ffURL,'User-Agent' => 'Mozilla/4.76 [en] (Win98; U)','Accept' => 'image/gif, image/x-xbitmap, image/jpeg,
				image/pjpeg, image/png, */*','Accept-Charset' => 'iso-8859-1,*,utf-8', 'Accept-Language' => 'en-US');

				my $result = $response->decoded_content;
				my $result2 =~m/<title>(.*)<\/title>/;
				print ("\t"x"8","Сохраняем HTML фильма $film_name","\n");

				my $file = "html-films/$film_name-$filmyear.txt";
				open(my $fh, '>', "$file") or die "Не могу открыть '$file' $!";
				print $fh "$result";
				close $fh;
				print ("\t"x"8","HTML фильма \"$film\" - записаны в $file\n");

				my $successLOG ="success.txt";
				open($fh, '>>', "$successLOG") or die "Не могу открыть '$successLOG' $!";
				print $fh "$time - Фильм \"$film\" - сохранен\n\n";
				sleep (10);
				}

				else{
				print ("Хуйцы! Проблема в названии или годе фильма\n");
				my $failLOG ="fail.txt";
				open(my $fh, '>>', "$failLOG") or die "Не могу открыть '$failLOG' $!";
				print $fh "$time - АХТУНГ, не нашли фильм \"$film\"\n";
				sleep (5);
				}

#else {
#print ("Хуйцы\n");
#}
}

}