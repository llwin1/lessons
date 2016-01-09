#!/usr/bin/perl

use utf8;
use warnings;
use strict;
use LWP::UserAgent;
use Time::localtime;
require LWP::UserAgent;

my $ua = LWP::UserAgent->new;
$ua->timeout(10);
$ua->env_proxy;
my $tm = localtime;

#http://www.kinopoisk.ru/index.php?first=no&what=&kp_query=

#ищем фильм, если есть в поиске (сравниваем по названию и году - переходим на страницу с фильмом, логируем и выдираем его ID)

my @filmsID = ('Рокки 4','Коммандос','Рэмбо: Первая кровь 2','Враг мой','Полицейская история','Легенда','Жемчужина Нила','Клуб Завтрак','Жизненная сила','Сердце Дракона','Леди-ястреб','Полицейская академия 2: Их первое задание','Кошмар на улице Вязов 2: Месть Фредди','Однажды укушенный','Европейские каникулы','Молодой Шерлок Холмс','Королева варваров','Эвоки: Битва за Эндор','Ох уж эта наука!','Имя ему Смерть','Бразилия','Американский Ниндзя','День мертвецов','Он хуже меня','Ночь Страха','Плоть + кровь','После дождичка в четверг','Тайная прогулка','Тихая Земля','Кошачий глаз','Вид на убийство','Частный курорт','Волчонок','Покровитель','Из Африки','Ран / Хаос / Смута','Пятница 13 - Часть 5: Новое начало','Черная стрела','Мои Счастливые Звезды 2','Кокон','Волшебное Рождество','Свидетель','Комната с видом','Улика','Поезд-беглец','Реаниматор','Девочки хотят повеселиться','Под платьем ничего нет / Слишком красивые чтобы умереть','Парень что надо','Не ходите девки замуж','Цветы лиловые полей','Русь изначальная','Последняя надежда','Абсолютно точно (Верняк)','Вторжение в США','Хронос','Храм Шаолинь 3: Боевые искусства Шаолиня','Подземка','Невеста','Девять с половиной недель');

for my $i(@filmsID){
    my $url = "http://www.kinopoisk.ru/index.php?first=no&what=&kp_query=$i 1985/";
    my $response = $ua->get($url,'User-Agent' => 'Mozilla/4.76 [en] (Win98; U)','Accept' => 'image/gif, image/x-xbitmap, image/jpeg,
    image/pjpeg, image/png, */*','Accept-Charset' => 'iso-8859-1,*,utf-8', 'Accept-Language' => 'en-US');

	if ($response->is_success) {
	#print $response->decoded_content;
	my $successLOG ="success.txt";
	open(my $fh, '>>', "$successLOG") or die "Не могу открыть '$successLOG' $!";
	print $fh "$tm - Успешно нашли фильм \"$i\"\n";
	}
	else {
	die $response->status_line;
	my $failLOG ="fail.txt";
	open(my $fh, '>>', "$failLOG") or die "Не могу открыть '$failLOG' $!";
	print $fh "$tm - АХТУНГ, не нашли фильм \"$i\"\n";
	}

	my $result_search = $response->decoded_content;
#тут делаем проверку результатов поиска, что нашли через регулярку
	if($result_search =~m/<p class="name"><a href="(.*)">$i</a>\s<span class="year">1985</span></p>/){
	my $successLOG ="success.txt";
	open(my $fh, '>>', "$successLOG") or die "Не могу открыть '$successLOG' $!";
	print $fh "$tm - Успешно сохранили HTML фильма \"$i\"\n";
#	переходим по урлу и парсим в директорию эту страницу, выдрав с неё тайтл + заносим в лог;
	my $response = $ua->get('http://kinopoisk.ru/$1/','User-Agent' => 'Mozilla/4.76 [en] (Win98; U)','Accept' => 'image/gif, image/x-xbitmap, image/jpeg,
	image/pjpeg, image/png, */*','Accept-Charset' => 'iso-8859-1,*,utf-8', 'Accept-Language' => 'en-US');
	my $result2 = $response->decoded_content;

	if ($result2 =~m/<title>(.*)<\/title>/) {
	print ("Сохраняем HTML фильма $1","\n");
	my $file = "html-films/$i-$1.txt";
	open(my $fh, '>', "$file") or die "Не могу открыть '$file' $!";
	print $fh "$result";
	close $fh;
	print "\t"x"10"."результаты поиска по фильму \"$1\" - записаны в $file\n";
	sleep (10);
	}

}

#my $result_search = $response->decoded content;
}

	else{
	my $failLOG ="fail.txt";
	open(my $fh, '>>', "$failLOG") or die "Не могу открыть '$failLOG' $!";
	print $fh "$tm - АХТУНГ, не спарсили. нет фильма с таким названием и годом. почему? х3. фильм \"$i\"\n";
	sleep (10);}

#if ($result =~m/<title>([^]*)<\/title>/) {
#if ($result =~m/<title>([[:print:]]*)<\/title>/) {