MIME-Version: 1.0
Date: Fri, 6 May 2011 17:13:50 +0200
Message-ID: <BANLkTi=qj7YfrFvQJPPZQbLjx=QSJqWzng@domain.hid>
From: Aurele Traynard <aurele.traynard@domain.hid>
Content-Type: multipart/alternative; boundary=0016e645b948f1aa2b04a29cef35
Subject: [Xenomai-help] user-space support : Inconsistency detected by ld.so
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

--0016e645b948f1aa2b04a29cef35
Content-Type: text/plain; charset=ISO-8859-1

hello all,

I have a problem whith user-space support :
I compile a program with makefile of Xenomai and when i want to use it this
apear :

Inconsistency detected by ld.so: dl-deps.c: 622: _dl_map_object_deps:
Assertion`nlist > 1' failed!

compilation process :

DESTDIR=/home/aurele/workdir/test/test_noyau/buildroot-2010.08/output/staging
make
XENO=/home/aurele/workdir/test/test_noyau/buildroot-2010.08/output/staging/usr/xenomai/
arm-none-linux-gnueabi-gcc
-I/home/aurele/workdir/test/test_noyau/buildroot-2010.08/output/staging/usr/xenomai/include
-D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__   -lnative
-L/home/aurele/workdir/test/test_noyau/buildroot-2010.08/output/staging/usr/xenomai/lib
-lxenomai -lpthread  -O -Xlinker -rpath -Xlinker
/home/aurele/workdir/test/test_noyau/buildroot-2010.08/output/staging/usr/xenomai/lib
playing_led_rt.c   -o playing_led_rt
playing_led_rt.c: In function 'main':
playing_led_rt.c:126:2: warning: format '%08X' expects type 'unsigned int',
but argument 3 has type 'long unsigned int'
playing_led_rt.c:128:2: warning: format '%08X' expects type 'unsigned int',
but argument 2 has type 'long unsigned int'

I have made two programs one with rt_tasks but he don't work, so supress all
real-time call and it doesn't work again with the same error.

does anyone have a way to go?
thanks for reply

PS : my config :
CPU (XScale) : PXA270 520MHz, 256Mo RAM (100MHz)
gcc : from CodeSourcery
$ arm-none-linux-gnueabi-gcc --version
$ arm-none-linux-gnueabi-gcc (Sourcery G++ Lite 2010q1-202) 4.4.1

linux : 2.6.33.2
Xenomai 2.5.6
patch : ksrc/arch/arm/patches/adeos-
ipipe-2.6.33-arm-1.18-02.patch

--0016e645b948f1aa2b04a29cef35
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hello all,<br><br>I have a problem whith user-space support :<br>I compile =
a program with makefile of Xenomai and when i want to use it this apear : <=
br><br>Inconsistency detected by ld.so: dl-deps.c: 622: _dl_map_object_deps=
: Assertion`nlist &gt; 1&#39; failed!<br>

<br>compilation process : <br><br>DESTDIR=3D/home/aurele/workdir/test/test_=
noyau/buildroot-2010.08/output/staging make XENO=3D/home/aurele/workdir/tes=
t/test_noyau/buildroot-2010.08/output/staging/usr/xenomai/<br>arm-none-linu=
x-gnueabi-gcc -I/home/aurele/workdir/test/test_noyau/buildroot-2010.08/outp=
ut/staging/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__X=
ENO__=A0=A0 -lnative -L/home/aurele/workdir/test/test_noyau/buildroot-2010.=
08/output/staging/usr/xenomai/lib -lxenomai -lpthread=A0 -O -Xlinker -rpath=
 -Xlinker /home/aurele/workdir/test/test_noyau/buildroot-2010.08/output/sta=
ging/usr/xenomai/lib=A0 playing_led_rt.c=A0=A0 -o playing_led_rt<br>

playing_led_rt.c: In function &#39;main&#39;:<br>playing_led_rt.c:126:2: wa=
rning: format &#39;%08X&#39; expects type &#39;unsigned int&#39;, but argum=
ent 3 has type &#39;long unsigned int&#39;<br>playing_led_rt.c:128:2: warni=
ng: format &#39;%08X&#39; expects type &#39;unsigned int&#39;, but argument=
 2 has type &#39;long unsigned int&#39;<br>

<br>I have made two programs one with rt_tasks but he don&#39;t work, so su=
press all real-time call and it doesn&#39;t work again with the same error.=
<br><br>does anyone have a way to go?<br>thanks for reply<br><br>PS : my co=
nfig :<br>
CPU (XScale) : PXA270 520MHz, 256Mo RAM (100MHz)<br>gcc : from CodeSourcery=
 <br>$ arm-none-linux-gnueabi-gcc --version<br>$ arm-none-linux-gnueabi-gcc=
 (Sourcery G++ Lite 2010q1-202) 4.4.1<br><br>linux : 2.6.33.2<br>Xenomai 2.=
5.6<br>

patch : ksrc/arch/arm/patches/adeos-<div id=3D":uw">ipipe-2.6.33-arm-1.18-0=
2.patch</div><br><br>

--0016e645b948f1aa2b04a29cef35--

