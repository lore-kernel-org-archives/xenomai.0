From: "Gregory Gosse" <gregory.gosse@domain.hid>
Date: Tue, 27 Dec 2011 17:56:19 +0100
Message-ID: <000101ccc4b8$74856eb0$5d904c10$@soterem.fr>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0002_01CCC4C0.D64E6A90"
Content-Language: fr
Subject: [Xenomai-help] problem following 'xenomai quick build guide'
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is a multipart message in MIME format.

------=_NextPart_000_0002_01CCC4C0.D64E6A90
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello all,

 

This is my first post . I'm from Toulouse France and absolute beginner in
Linux and Xenomai .

 

I try to install Xenomai on an Intel CORE i5 laptop.

 

I have installed Ubuntu 11.04 inside windows with wubi , and tried to follow
the 'Xenomai quick build guide'
http://www.xenomai.org/index.php/Xenomai_quick_build_quide 

 

Starting from scratch , to follow the quick build guide , I had to :

-          Log as root to paste files in /usr/tmp   ( 'sudo passwd root' to
define the root password in my initial guest session )

-          Install the 'patch' command with ' apt-get install patch' 

-          Install  libncure with 'apt-get install libncurses5-dev'

-          Get linux-2.6.25.tar.bz2  from www.kernell.org (
linux-2.6.25.11.tar.bz2 doesn't exist )

 

I have then get a x86_64 patch on adeos :

adeos-ipipe-2.6.23-x86_64-1.4-03.patch

and add it to /usr/src/xenomai-2.4.4/ksrc/arch/x86/patches/ 

 

I give the following informations in the 'prepare-kernel' script

> /usr/src/linux-2.6.25

> amd64

>
/usr/src/xenomai-2.4.4/ksrc/arch/x86/patches/adeos-ipipe-2.6.23-x86_64-1.4-0
3.patch

 

This step seems ok .

 

Then I enter 'menuconfig' and configure with the infos given on this
document "hard real time linux using xenomai on intel multi-core processors'
http://download.intel.com/design/intarch/papers/322386.pdf 

Save and exit

 

My problem is  in the step 'compile the kernel'

When I type 'Make' the compilation finishes with

 

gcc: erreur: elf_i386: Aucun fichier ou dossier de ce type               (in
English should give 'gcc : error :elf_i386 : no such file or directory' )

make[1]: *** [arch/x86/vdso/vdso32-int80.so.dbg] Erreur 1

make: *** [arch/x86/vdso] Erreur 2

 

What can I do to go further ?

 

Thanks for any help

Gregory

 


------=_NextPart_000_0002_01CCC4C0.D64E6A90
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><META =
HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 14 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
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
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1810324578;
	mso-list-type:hybrid;
	mso-list-template-ids:-291048990 390858750 67895299 67895301 67895297 =
67895299 67895301 67895297 67895299 67895301;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-font-family:Calibri;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DFR link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal><span =
lang=3DEN-US>Hello all,<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>This is my first post . I&#8217;m from Toulouse France and =
absolute beginner in Linux and Xenomai .<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>I try to install Xenomai on an =
Intel CORE i5 laptop.<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>I have installed Ubuntu 11.04 inside windows with wubi , =
and tried to follow the &#8216;Xenomai quick build guide&#8217; <a =
href=3D"http://www.xenomai.org/index.php/Xenomai_quick_build_quide">http:=
//www.xenomai.org/index.php/Xenomai_quick_build_quide</a> =
<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>Starting from scratch , to follow the quick build guide , I =
had to :<o:p></o:p></span></p><p class=3DMsoListParagraph =
style=3D'text-indent:-18.0pt;mso-list:l0 level1 lfo1'><![if =
!supportLists]><span lang=3DEN-US><span style=3D'mso-list:Ignore'>-<span =
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></span></span><![endif]><span lang=3DEN-US>Log as root to paste =
files in /usr/tmp&nbsp;&nbsp; ( &#8216;sudo passwd root&#8217; to define =
the root password in my initial guest session )<o:p></o:p></span></p><p =
class=3DMsoListParagraph style=3D'text-indent:-18.0pt;mso-list:l0 level1 =
lfo1'><![if !supportLists]><span lang=3DEN-US><span =
style=3D'mso-list:Ignore'>-<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></span></span><![endif]><span lang=3DEN-US>Install the =
&#8216;patch&#8217; command with &#8216; apt-get install patch&#8217; =
<o:p></o:p></span></p><p class=3DMsoListParagraph =
style=3D'text-indent:-18.0pt;mso-list:l0 level1 lfo1'><![if =
!supportLists]><span lang=3DEN-US><span style=3D'mso-list:Ignore'>-<span =
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></span></span><![endif]><span lang=3DEN-US>Install &nbsp;libncure =
with &#8216;apt-get install =
libncurses5-dev&#8217;<o:p></o:p></span></p><p class=3DMsoListParagraph =
style=3D'text-indent:-18.0pt;mso-list:l0 level1 lfo1'><![if =
!supportLists]><span lang=3DEN-US><span style=3D'mso-list:Ignore'>-<span =
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></span></span><![endif]><span lang=3DEN-US>Get =
linux-2.6.25.tar.bz2 &nbsp;from <a =
href=3D"http://www.kernell.org">www.kernell.org</a> ( =
linux-2.6.25.11.tar.bz2 doesn&#8217;t exist )<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>I have then get a x86_64 patch on =
adeos :<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>adeos-ipipe-2.6.23-x86_64-1.4-03.patch<o:p></o:p></span></p>=
<p class=3DMsoNormal><span lang=3DEN-US>and add it to =
/usr/src/xenomai-2.4.4/ksrc/arch/x86/patches/ <o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>I give the following informations =
in the &#8216;prepare-kernel&#8217; script<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>&gt; =
/usr/src/linux-2.6.25<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>&gt; amd64<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>&gt; =
/usr/src/xenomai-2.4.4/ksrc/arch/x86/patches/adeos-ipipe-2.6.23-x86_64-1.=
4-03.patch<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>This step seems ok .<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>Then I enter =
&#8216;menuconfig&#8217; and configure with the infos given on this =
document &#8220;hard real time linux using xenomai on intel multi-core =
processors&#8217; <a =
href=3D"http://download.intel.com/design/intarch/papers/322386.pdf">http:=
//download.intel.com/design/intarch/papers/322386.pdf</a> =
<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>Save and =
exit<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>My problem is &nbsp;in the step &#8216;compile the =
kernel&#8217;<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>When I type &#8216;Make&#8217; the compilation finishes =
with<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US style=3D'color:red'>gcc: erreur: elf_i386: Aucun fichier ou =
dossier de ce =
type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; </span><span lang=3DEN-US style=3D'color:black'>(in =
English should give &#8216;gcc&nbsp;: error&nbsp;:elf_i386&nbsp;: no =
such file or directory&#8217; )</span><span lang=3DEN-US =
style=3D'color:red'><o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US style=3D'color:red'>make[1]: *** =
[arch/x86/vdso/vdso32-int80.so.dbg] Erreur 1<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US style=3D'color:red'>make: *** =
[arch/x86/vdso] Erreur 2<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US style=3D'color:red'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US style=3D'color:black'>What can I do =
to go further ?<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US style=3D'color:black'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US style=3D'color:black'>Thanks for =
any help<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US =
style=3D'color:black'>Gregory<o:p></o:p></span></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>
------=_NextPart_000_0002_01CCC4C0.D64E6A90--


