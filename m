From: "Gregory Gosse" <gregory.gosse@domain.hid>
References: <000101ccc4b8$74856eb0$5d904c10$@soterem.fr>	<4EF9F949.5000708@domain.hid>
	<000001ccc541$7fa8d960$7efa8c20$@soterem.fr>
	<4EFAE1BF.4090203@domain.hid>
	<000301ccc556$168472e0$438d58a0$@soterem.fr>
	<4EFB0456.9010409@domain.hid>
	<000d01ccc55c$3cc52d40$b64f87c0$@soterem.fr>
	<4EFB0D66.8060306@domain.hid> 
In-Reply-To: 
Date: Wed, 28 Dec 2011 18:03:58 +0100
Message-ID: <000d01ccc582$b0dff770$129fe650$@soterem.fr>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000E_01CCC58B.12ABB270"
Content-Language: fr
Subject: [Xenomai-help] TR:  problem following 'xenomai quick build guide'
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org
Cc: Christophe@domain.hid, 'xenomai-help' <xenomai@xenomai.org>

This is a multipart message in MIME format.

------=_NextPart_000_000E_01CCC58B.12ABB270
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

ERRATUM :

It=E2=80=99s > cyclictest -t 10 -p 80 -n -i 5000 -l 5000

That gave the results bellow

=20

De : Gregory Gosse [mailto:gregory.gosse@domain.hid
Envoy=C3=A9 : mercredi 28 d=C3=A9cembre 2011 17:51
=C3=80 : 'Gilles Chanteperdrix'
Cc : 'Philippe Gerum'; 'xenomai-help'; 'Christophe@domain.hid'
Objet : RE: [Xenomai-help] problem following 'xenomai quick build guide'

=20

Thanks Gilles,

=20

Well with =E2=80=9C/=E2=80=9D I found CONFIG_CC_STACKPROTECTOR that is =
in :

Processor type and features > Enable -fstack-protector buffer overflow =
detection (EXPERIMENTAL)

=20

I have disabled it

=20

Then switching between different tutorials , I tried the following =
commands :

=20

> make

ok ( take a moment )

>make modules

>make modules_install

>make install

>make bzImage

=20

Here I get:

Root device is (7, 0)

Setup is 16220 bytes (padded to 16384 bytes).

System is 4238 kB

CRC 702aeac7

Kernel: arch/x86/boot/bzImage is ready  (#2)

=20

>addgroup xenomai

>usermod -a -G xenomai gg

>usermod -a -G xenomai root

=20

Then I reboot . Choose 'Older Linux Versions > 2.6.38.8 '

=20

> cd /usr/src/xenomai-2.6.0

> ./configure

> make

> make install

> cp /etc/ld.so.conf /etc/ld.so.conf.d/xenomai.conf

=20

Add the following lines in /etc/ld.so.conf.d/xenomai.conf  :

# xenomai libs

/usr/local/lib

=20

> set =
PATH=3D/usr/xenomai/bin:/usr/xenomai/lib:/usr/xenomai/include:$PATH

> ldconfig

=20

Then tried=20

>cd  /usr/src/xenomai-2.6.0/examples/native

>make

That Failed :

--xeno-cflags is deprecated, use --skin=3Dname --cflags instead

--xeno-ldflags is deprecated, use --skin=3Dname --ldflags instead

gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall =
-Werror-implicit-function-declaration -pipe -D__XENO__   =
-L/usr/xenomai/lib -lxenomai -lpthread -lrt  -lnative -Xlinker -rpath =
-Xlinker /usr/xenomai/lib  trivial-periodic.c   -o trivial-periodic

trivial-periodic.c: In function =E2=80=98main=E2=80=99:

trivial-periodic.c:72:1: attention : contr=C3=B4le a atteint la fin non =
void de la fonction [-Wreturn-type]

/tmp/ccqQeLZj.o: In function `demo':

trivial-periodic.c:(.text+0x2f): undefined reference to =
`rt_task_set_periodic'

trivial-periodic.c:(.text+0x34): undefined reference to `rt_timer_read'

trivial-periodic.c:(.text+0x46): undefined reference to =
`rt_task_wait_period'

trivial-periodic.c:(.text+0x4b): undefined reference to `rt_timer_read'

/tmp/ccqQeLZj.o: In function `main':

trivial-periodic.c:(.text+0x133): undefined reference to =
`rt_task_create'

trivial-periodic.c:(.text+0x14f): undefined reference to `rt_task_start'

trivial-periodic.c:(.text+0x160): undefined reference to =
`rt_task_delete'

collect2: ld a retourn=C3=A9 1 code d'=C3=A9tat d'ex=C3=A9cution

make: *** [trivial-periodic] Erreur 1

=20

And

>cd /usr/xenomai/bin

>apt-get install rt-tests

>cyclictest -t 10 -p 80 -n -i 5000 -l 500

That gives:

T: 0 (17824) P:80 I:5000 C:   5000 Min:   2578 Act: 3600 Avg: 4097 Max:  =
  5625

T: 1 (17825) P:79 I:5500 C:   4547 Min:   2085 Act: 3602 Avg: 3856 Max:  =
  5631

T: 2 (17826) P:78 I:6000 C:   4168 Min:   2587 Act: 4612 Avg: 3614 Max:  =
  4666

T: 3 (17827) P:77 I:6500 C:   3847 Min:   2091 Act: 3618 Avg: 3871 Max:  =
  5686

T: 4 (17828) P:76 I:7000 C:   3573 Min:   2595 Act: 2624 Avg: 4127 Max:  =
  5691

T: 5 (17829) P:75 I:7500 C:   3334 Min:   2101 Act: 5136 Avg: 3885 Max:  =
  5700

T: 6 (17830) P:74 I:8000 C:   3126 Min:   2616 Act: 2658 Avg: 2653 Max:  =
  2732

T: 7 (17831) P:73 I:8500 C:   2942 Min:   2112 Act: 4158 Avg: 3901 Max:  =
  5704

T: 8 (17832) P:72 I:9000 C:   2779 Min:   2618 Act: 4640 Avg: 4151 Max:  =
  5708

T: 9 (17833) P:71 I:9500 C:   2633 Min:   2113 Act: 2642 Avg: 3899 Max:  =
  5712

=20

( it goes without saying that I don=E2=80=99t know what I=E2=80=99ve =
done until there )

=20

Gregory=20

=20

=20

=20

-----Message d'origine-----
De : Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Envoy=C3=A9 : mercredi 28 d=C3=A9cembre 2011 13:37
=C3=80 : Gregory Gosse
Cc : 'Philippe Gerum'; 'xenomai-help'
Objet : Re: [Xenomai-help] problem following 'xenomai quick build guide'

=20

On 12/28/2011 01:28 PM, Gregory Gosse wrote:

> For the moment I use an Intel Core I5 as host and target .

>=20

> Since I think I have to compile a  64bits kernel .

=20

For x86_64 processors, you have the choice to compile a 32 bits or 64 =
bits kernels. If you have a 64 bits filesystem, you must compile a 64 =
bits kernel. If you have a 32 bits filesystem and want to compile a 64 =
bits kernel, you have to enable the 32 bits compatibility option.

=20

>=20

> Do you know where is located CONFIG_CC_STACKPROTECTOR in the =
configuration menu ?

=20

Use ctrl-F to search if using "make xconfig" or "/" if using "make =
menuconfig".

=20

--=20

                                                                Gilles.


------=_NextPart_000_000E_01CCC58B.12ABB270
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; charset=3Dutf-8"><meta =
name=3DGenerator content=3D"Microsoft Word 14 (filtered =
medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Texte brut Car";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Texte de bulles Car";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";
	mso-fareast-language:EN-US;}
span.TextebrutCar
	{mso-style-name:"Texte brut Car";
	mso-style-priority:99;
	mso-style-link:"Texte brut";
	font-family:"Calibri","sans-serif";}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
span.TextedebullesCar
	{mso-style-name:"Texte de bulles Car";
	mso-style-priority:99;
	mso-style-link:"Texte de bulles";
	font-family:"Tahoma","sans-serif";
	mso-fareast-language:EN-US;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DFR link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p =
class=3DMsoNormal>ERRATUM&nbsp;:<o:p></o:p></p><p =
class=3DMsoPlainText>It=E2=80=99s &gt; <span lang=3DEN-US =
style=3D'font-family:"Courier New"'>cyclictest -t 10 -p 80 -n -i 5000 -l =
<u>5000<o:p></o:p></u></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US style=3D'font-family:"Courier New"'>That gave the results =
bellow<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p><div><div =
style=3D'border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm'><p class=3DMsoNormal><b><span =
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif";mso-fareast-l=
anguage:FR'>De&nbsp;:</span></b><span =
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif";mso-fareast-l=
anguage:FR'> Gregory Gosse [mailto:gregory.gosse@domain.hid] =
<br><b>Envoy=C3=A9&nbsp;:</b> mercredi 28 d=C3=A9cembre 2011 =
17:51<br><b>=C3=80&nbsp;:</b> 'Gilles Chanteperdrix'<br><b>Cc&nbsp;:</b> =
'Philippe Gerum'; 'xenomai-help'; =
'Christophe@domain.hid'<br><b>Objet&nbsp;:</b> RE: [Xenomai-help] problem =
following 'xenomai quick build =
guide'<o:p></o:p></span></p></div></div><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText><span =
lang=3DEN-US>Thanks Gilles,<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>Well with =E2=80=9C/=E2=80=9D I =
found CONFIG_CC_STACKPROTECTOR that is in :<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>Processor type and features &gt; =
Enable -fstack-protector buffer overflow detection =
(EXPERIMENTAL)<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>I have disabled it<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>Then switching between different =
tutorials , I tried the following commands :<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>&gt; =
make<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US>ok =
( take a moment )<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>&gt;make modules<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>&gt;make =
modules_install<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>&gt;make install<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>&gt;make =
bzImage<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>Here I get:<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US style=3D'color:red'>Root device =
is (7, 0)<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US style=3D'color:red'>Setup is 16220 bytes (padded to 16384 =
bytes).<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US =
style=3D'color:red'>System is 4238 kB<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US style=3D'color:red'>CRC =
702aeac7<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US =
style=3D'color:red'>Kernel: arch/x86/boot/bzImage is ready&nbsp; =
(#2)<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>&gt;addgroup xenomai<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>&gt;usermod -a -G xenomai =
gg<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>&gt;usermod -a -G xenomai root<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>Then I reboot . Choose 'Older =
Linux Versions &gt; 2.6.38.8 '<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText>&gt; cd /usr/src/xenomai-2.6.0<o:p></o:p></p><p =
class=3DMsoPlainText>&gt; ./configure<o:p></o:p></p><p =
class=3DMsoPlainText>&gt; make<o:p></o:p></p><p =
class=3DMsoPlainText>&gt; make install<o:p></o:p></p><p =
class=3DMsoPlainText>&gt; cp /etc/ld.so.conf =
/etc/ld.so.conf.d/xenomai.conf<o:p></o:p></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText><span =
lang=3DEN-US>Add the following lines in =
/etc/ld.so.conf.d/xenomai.conf&nbsp; :<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US># xenomai =
libs<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>/usr/local/lib<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>&gt; set =
PATH=3D/usr/xenomai/bin:/usr/xenomai/lib:/usr/xenomai/include:$PATH<o:p><=
/o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US>&gt; =
ldconfig<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>Then tried <o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>&gt;cd =
&nbsp;/usr/src/xenomai-2.6.0/examples/native<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>&gt;make<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>That Failed =
:<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US =
style=3D'font-family:"Courier New";color:red'>--xeno-cflags is =
deprecated, use --skin=3Dname --cflags instead<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US style=3D'font-family:"Courier =
New";color:red'>--xeno-ldflags is deprecated, use --skin=3Dname =
--ldflags instead<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US style=3D'font-family:"Courier New";color:red'>gcc =
-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall =
-Werror-implicit-function-declaration -pipe -D__XENO__&nbsp;&nbsp; =
-L/usr/xenomai/lib -lxenomai -lpthread -lrt&nbsp; -lnative -Xlinker =
-rpath -Xlinker /usr/xenomai/lib&nbsp; trivial-periodic.c&nbsp;&nbsp; -o =
trivial-periodic<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US style=3D'font-family:"Courier =
New";color:red'>trivial-periodic.c: In function =
=E2=80=98main=E2=80=99:<o:p></o:p></span></p><p =
class=3DMsoPlainText><span style=3D'font-family:"Courier =
New";color:red'>trivial-periodic.c:72:1: attention : contr=C3=B4le a =
atteint la fin non void de la fonction =
[-Wreturn-type]<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US style=3D'font-family:"Courier =
New";color:red'>/tmp/ccqQeLZj.o: In function =
`demo':<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US =
style=3D'font-family:"Courier =
New";color:red'>trivial-periodic.c:(.text+0x2f): undefined reference to =
`rt_task_set_periodic'<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US style=3D'font-family:"Courier =
New";color:red'>trivial-periodic.c:(.text+0x34): undefined reference to =
`rt_timer_read'<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US style=3D'font-family:"Courier =
New";color:red'>trivial-periodic.c:(.text+0x46): undefined reference to =
`rt_task_wait_period'<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US style=3D'font-family:"Courier =
New";color:red'>trivial-periodic.c:(.text+0x4b): undefined reference to =
`rt_timer_read'<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US style=3D'font-family:"Courier =
New";color:red'>/tmp/ccqQeLZj.o: In function =
`main':<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US =
style=3D'font-family:"Courier =
New";color:red'>trivial-periodic.c:(.text+0x133): undefined reference to =
`rt_task_create'<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US style=3D'font-family:"Courier =
New";color:red'>trivial-periodic.c:(.text+0x14f): undefined reference to =
`rt_task_start'<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US style=3D'font-family:"Courier =
New";color:red'>trivial-periodic.c:(.text+0x160): undefined reference to =
`rt_task_delete'<o:p></o:p></span></p><p class=3DMsoPlainText><span =
style=3D'font-family:"Courier New";color:red'>collect2: ld a =
retourn=C3=A9 1 code d'=C3=A9tat =
d'ex=C3=A9cution<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US style=3D'font-family:"Courier New";color:red'>make: *** =
[trivial-periodic] Erreur 1<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US =
style=3D'color:red'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US =
style=3D'color:black'>And<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US style=3D'color:black'>&gt;cd =
/usr/xenomai/bin<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US style=3D'font-family:"Courier New"'>&gt;apt-get install =
rt-tests<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US =
style=3D'font-family:"Courier New"'>&gt;cyclictest -t 10 -p 80 -n -i =
5000 -l 500<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US style=3D'font-family:"Courier New"'>That =
gives:<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US =
style=3D'font-family:"Courier New";color:red'>T: 0 (17824) P:80 I:5000 =
C:&nbsp;&nbsp; 5000 Min:&nbsp;&nbsp; 2578 Act: 3600 Avg: 4097 =
Max:&nbsp;&nbsp;&nbsp; 5625<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US style=3D'font-family:"Courier =
New";color:red'>T: 1 (17825) P:79 I:5500 C:&nbsp;&nbsp; 4547 =
Min:&nbsp;&nbsp; 2085 Act: 3602 Avg: 3856 Max:&nbsp;&nbsp;&nbsp; =
5631<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US =
style=3D'font-family:"Courier New";color:red'>T: 2 (17826) P:78 I:6000 =
C:&nbsp;&nbsp; 4168 Min:&nbsp;&nbsp; 2587 Act: 4612 Avg: 3614 =
Max:&nbsp;&nbsp;&nbsp; 4666<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US style=3D'font-family:"Courier =
New";color:red'>T: 3 (17827) P:77 I:6500 C:&nbsp;&nbsp; 3847 =
Min:&nbsp;&nbsp; 2091 Act: 3618 Avg: 3871 Max:&nbsp;&nbsp;&nbsp; =
5686<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US =
style=3D'font-family:"Courier New";color:red'>T: 4 (17828) P:76 I:7000 =
C:&nbsp;&nbsp; 3573 Min:&nbsp;&nbsp; 2595 Act: 2624 Avg: 4127 =
Max:&nbsp;&nbsp;&nbsp; 5691<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US style=3D'font-family:"Courier =
New";color:red'>T: 5 (17829) P:75 I:7500 C:&nbsp;&nbsp; 3334 =
Min:&nbsp;&nbsp; 2101 Act: 5136 Avg: 3885 Max:&nbsp;&nbsp;&nbsp; =
5700<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US =
style=3D'font-family:"Courier New";color:red'>T: 6 (17830) P:74 I:8000 =
C:&nbsp;&nbsp; 3126 Min:&nbsp;&nbsp; 2616 Act: 2658 Avg: 2653 =
Max:&nbsp;&nbsp;&nbsp; 2732<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US style=3D'font-family:"Courier =
New";color:red'>T: 7 (17831) P:73 I:8500 C:&nbsp;&nbsp; 2942 =
Min:&nbsp;&nbsp; 2112 Act: 4158 Avg: 3901 Max:&nbsp;&nbsp;&nbsp; =
5704<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US =
style=3D'font-family:"Courier New";color:red'>T: 8 (17832) P:72 I:9000 =
C:&nbsp;&nbsp; 2779 Min:&nbsp;&nbsp; 2618 Act: 4640 Avg: 4151 =
Max:&nbsp;&nbsp;&nbsp; 5708<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US style=3D'font-family:"Courier =
New";color:red'>T: 9 (17833) P:71 I:9500 C:&nbsp;&nbsp; 2633 =
Min:&nbsp;&nbsp; 2113 Act: 2642 Avg: 3899 Max:&nbsp;&nbsp;&nbsp; =
5712<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US =
style=3D'font-family:"Courier =
New";color:red'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US style=3D'color:black'>( it goes =
without saying that I don=E2=80=99t know what I=E2=80=99ve done until =
there )<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US =
style=3D'color:black'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US style=3D'color:black'>Gregory =
<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoPlainText><span =
style=3D'mso-fareast-language:FR'>-----Message =
d'origine-----<br>De&nbsp;: Gilles Chanteperdrix <a =
href=3D"mailto:[mailto:gilles.chanteperdrix@xenomai.org]">[mailto:gilles.=
chanteperdrix@domain.hid]</a> <br>Envoy=C3=A9&nbsp;: mercredi 28 =
d=C3=A9cembre 2011 13:37<br>=C3=80&nbsp;: Gregory Gosse<br>Cc&nbsp;: =
'Philippe Gerum'; 'xenomai-help'<br>Objet&nbsp;: Re: [Xenomai-help] =
problem following 'xenomai quick build guide'</span><o:p></o:p></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText>On =
12/28/2011 01:28 PM, Gregory Gosse wrote:<o:p></o:p></p><p =
class=3DMsoPlainText>&gt; For the moment I use an Intel Core I5 as host =
and target .<o:p></o:p></p><p class=3DMsoPlainText>&gt; =
<o:p></o:p></p><p class=3DMsoPlainText>&gt; Since I think I have to =
compile a&nbsp; 64bits kernel .<o:p></o:p></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText>For =
x86_64 processors, you have the choice to compile a 32 bits or 64 bits =
kernels. If you have a 64 bits filesystem, you must compile a 64 bits =
kernel. If you have a 32 bits filesystem and want to compile a 64 bits =
kernel, you have to enable the 32 bits compatibility =
option.<o:p></o:p></p><p class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; <o:p></o:p></p><p class=3DMsoPlainText>&gt; Do =
you know where is located CONFIG_CC_STACKPROTECTOR in the configuration =
menu ?<o:p></o:p></p><p class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>Use ctrl-F to search if using &quot;make =
xconfig&quot; or &quot;/&quot; if using &quot;make =
menuconfig&quot;.<o:p></o:p></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText>-- =
<o:p></o:p></p><p =
class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles.<o:p></o:p></p></div></bod=
y></html>
------=_NextPart_000_000E_01CCC58B.12ABB270--


