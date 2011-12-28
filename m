From: "Gregory Gosse" <gregory.gosse@domain.hid>
References: <000101ccc4b8$74856eb0$5d904c10$@soterem.fr>	<4EF9F949.5000708@domain.hid>
	<000001ccc541$7fa8d960$7efa8c20$@soterem.fr>
	<4EFAE1BF.4090203@domain.hid>
In-Reply-To: <4EFAE1BF.4090203@domain.hid>
Date: Wed, 28 Dec 2011 12:44:41 +0100
Message-ID: <000301ccc556$168472e0$438d58a0$@soterem.fr>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0004_01CCC55E.784ECE50"
Content-Language: fr
Subject: Re: [Xenomai-help] problem following 'xenomai quick build guide'
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Philippe Gerum' <rpm@xenomai.org>
Cc: 'xenomai-help' <xenomai@xenomai.org>

This is a multipart message in MIME format.

------=_NextPart_000_0004_01CCC55E.784ECE50
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Now I use:

- xenomai 2.6.0   2011-11-05

- kernel 2.6.38.8

- patch adeos-ipipe-2.6.38.8-x86-2.10-01.patch

=20

The following command works well:

scripts/prepare-kernel.sh --linux=3D/usr/src/linux-2.6.38.8 =
--adeos=3D/usr/src/xenomai-2.6.0/ksrc/arch/x86/patches/adeos-ipipe-2.6.38=
.8-x86-2.10-01.patch --arch=3Dx86

Then I enter the configuration menu with

Make menuconfig

=20

I apply the changes suggested in 'hard real time linux using xenomai on =
intel Multi-Core processors'

Save and exit

=20

When I try to compile the kernel with 'Make'  , the compilation finishes =
on:

CC      kernel/xenomai/nucleus/pod.o
In file included from =
/usr/src/linux-2.6.38.8/arch/x86/include/asm/xenomai/switch.h:2:0,
                 from =
/usr/src/linux-2.6.38.8/arch/x86/include/asm/xenomai/bits/pod_32.h:27,
                 from =
/usr/src/linux-2.6.38.8/arch/x86/include/asm/xenomai/bits/pod.h:2,
                 from kernel/xenomai/nucleus/pod.c:47:
/usr/src/linux-2.6.38.8/arch/x86/include/asm/xenomai/switch_32.h:30:2: =
attention : #warning "Buffer overflow detection not supported in 32bit =
mode" [-Wcpp]
/usr/src/linux-2.6.38.8/arch/x86/include/asm/xenomai/switch_32.h:31:2: =
erreur: #error "Disable CONFIG_CC_STACKPROTECTOR in your kernel =
configuration"
make[3]: *** [kernel/xenomai/nucleus/pod.o] Erreur 1
make[2]: *** [kernel/xenomai/nucleus] Erreur 2
make[1]: *** [kernel/xenomai] Erreur 2
make: *** [kernel] Erreur 2

=20

Gregory

=20

-----Message d'origine-----
De : Philippe Gerum [mailto:rpm@xenomai.org
Envoy=C3=A9 : mercredi 28 d=C3=A9cembre 2011 10:31
=C3=80 : Gregory Gosse
Cc : xenomai-help; Gilles Chanteperdrix
Objet : Re: [Xenomai-help] problem following 'xenomai quick build guide'

=20

On 12/28/2011 10:17 AM, Gregory Gosse wrote:

> Now i use more recent xenomai and kernel versions :

>=20

> - xenomai 2.6.0   2011-11-05 ( latest )

>=20

> - kernel 2.6.39 ( latest in 2.6 serie )

>=20

> With the same patch :

>=20

> - adeos-ipipe-2.6.23-x86_64-1.4-03.patch

>=20

> I launch the command

>=20

> scripts/prepare-kernel.sh --linux=3D/usr/src/linux-2.6.39=20

> =
--adeos=3D/usr/src/xenomai-2.6.0/ksrc/arch/x86/patches/adeos-ipipe-2.6.2

> 3-x86_64-1.4-03.patch

> --arch=3Dx86_64

=20

- there is no support for 2.6.39/x86. Looking at ksrc/arch/x86/patches =
tells you so. Latest kernel release currently supported on this arch is =
2.6.38.8.

=20

--arch=3Dx86, not x86_64 which is for legacy patches when 32 and 64bit =
linux trees were not merged yet.

=20

You need to unpack a vanilla linux 2.6.38.8 kernel tree, then

=20

$ cd <linux-tree>

$ <xenomai-2.6.0>/scripts/prepare-kernel.sh --arch=3Dx86

=20

Nothing more.

=20

>=20

> And get

>=20

> Unable to patch kernel 2.6.39 with=20

> adeos-ipipe-2.6.23-x86_64-1.4-03.patch

>=20

> with many Hunk #xx FAILED at xx

>=20

> Gregory

>=20

> -----Message d'origine-----

> De : Gilles Chanteperdrix  =
<mailto:[mailto:gilles.chanteperdrix@xenomai.org]> =
[mailto:gilles.chanteperdrix@xenomai.org]

> Envoy=C3=A9 : mardi 27 d=C3=A9cembre 2011 17:59

> =C3=80 : Gregory Gosse

> Cc :  <mailto:xenomai@xenomai.org> xenomai@xenomai.org

> Objet : Re: [Xenomai-help] problem following 'xenomai quick build =
guide'

>=20

> On 12/27/2011 05:56 PM, Gregory Gosse wrote:

>=20

>  > What can I do to go further ?

>=20

> There is no point in starting with such outdated versions. Please=20

> download the latest stable release of Xenomai (xenomai 2.6.0), and if=20

> the quick build guide does not work, follow the not quick build guide=20

> called "README.INSTALL" which ships with the sources.

>=20

> --

>=20

>                                                                  =
Gilles.

>=20

>=20

>=20

> _______________________________________________

> Xenomai-help mailing list

>  <mailto:Xenomai-help@domain.hid> Xenomai-help@domain.hid

>  <https://mail.gna.org/listinfo/xenomai-help> =
https://mail.gna.org/listinfo/xenomai-help

=20

=20

--

Philippe.


------=_NextPart_000_0004_01CCC55E.784ECE50
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
span.TextedebullesCar
	{mso-style-name:"Texte de bulles Car";
	mso-style-priority:99;
	mso-style-link:"Texte de bulles";
	font-family:"Tahoma","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
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
vlink=3Dpurple><div class=3DWordSection1><p class=3DMsoPlainText>Now I =
use:<o:p></o:p></p><p class=3DMsoPlainText>- xenomai 2.6.0=C2=A0=C2=A0 =
2011-11-05<o:p></o:p></p><p class=3DMsoPlainText>- kernel =
2.6.38.8<o:p></o:p></p><p class=3DMsoPlainText>- patch =
adeos-ipipe-2.6.38.8-x86-2.10-01.patch<o:p></o:p></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText><span =
lang=3DEN-US>The following command works well:<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>scripts/prepare-kernel.sh =
--linux=3D/usr/src/linux-2.6.38.8 =
--adeos=3D/usr/src/xenomai-2.6.0/ksrc/arch/x86/patches/adeos-ipipe-2.6.38=
.8-x86-2.10-01.patch --arch=3Dx86<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US> <o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>Then I enter the configuration =
menu with<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>Make menuconfig<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>I apply the changes suggested in =
'hard real time linux using xenomai on intel Multi-Core =
processors'<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>Save and exit<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>When I try to compile the kernel =
with 'Make'=C2=A0 , the compilation finishes on:<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US style=3D'font-family:"Courier =
New";color:red'>CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
kernel/xenomai/nucleus/pod.o<br>In file included from =
/usr/src/linux-2.6.38.8/arch/x86/include/asm/xenomai/switch.h:2:0,<br>=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 from =
/usr/src/linux-2.6.38.8/arch/x86/include/asm/xenomai/bits/pod_32.h:27,<br=
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from =
/usr/src/linux-2.6.38.8/arch/x86/include/asm/xenomai/bits/pod.h:2,<br>=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0from =
kernel/xenomai/nucleus/pod.c:47:<br>/usr/src/linux-2.6.38.8/arch/x86/incl=
ude/asm/xenomai/switch_32.h:30:2: attention : #warning &quot;Buffer =
overflow detection not supported in 32bit mode&quot; =
[-Wcpp]<br>/usr/src/linux-2.6.38.8/arch/x86/include/asm/xenomai/switch_32=
.h:31:2: erreur: #error &quot;Disable CONFIG_CC_STACKPROTECTOR in your =
kernel configuration&quot;<br>make[3]: *** =
[kernel/xenomai/nucleus/pod.o] Erreur 1<br>make[2]: *** =
[kernel/xenomai/nucleus] Erreur 2<br>make[1]: *** [kernel/xenomai] =
Erreur 2<br>make: *** [kernel] Erreur 2</span><span lang=3DEN-US =
style=3D'color:red'><o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US style=3D'color:red'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>Gregory<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US =
style=3D'mso-fareast-language:FR'>-----Message =
d'origine-----<br>De&nbsp;: Philippe Gerum [mailto:rpm@xenomai.org] =
<br>Envoy=C3=A9&nbsp;: mercredi 28 d=C3=A9cembre 2011 =
10:31<br>=C3=80&nbsp;: Gregory Gosse<br>Cc&nbsp;: xenomai-help; Gilles =
Chanteperdrix<br>Objet&nbsp;: Re: [Xenomai-help] problem following =
'xenomai quick build guide'</span><span =
lang=3DEN-US><o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoPlainText>On =
12/28/2011 10:17 AM, Gregory Gosse wrote:<o:p></o:p></p><p =
class=3DMsoPlainText>&gt; Now i use more recent xenomai and kernel =
versions :<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; - xenomai 2.6.0=C2=A0=C2=A0 2011-11-05 ( =
latest )<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; - kernel 2.6.39 ( latest in 2.6 serie =
)<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; With the same patch :<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; - =
adeos-ipipe-2.6.23-x86_64-1.4-03.patch<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; I launch the command<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; scripts/prepare-kernel.sh =
--linux=3D/usr/src/linux-2.6.39 <o:p></o:p></p><p =
class=3DMsoPlainText>&gt; =
--adeos=3D/usr/src/xenomai-2.6.0/ksrc/arch/x86/patches/adeos-ipipe-2.6.2<=
o:p></o:p></p><p class=3DMsoPlainText>&gt; =
3-x86_64-1.4-03.patch<o:p></o:p></p><p class=3DMsoPlainText>&gt; =
--arch=3Dx86_64<o:p></o:p></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText>- =
there is no support for 2.6.39/x86. Looking at ksrc/arch/x86/patches =
tells you so. Latest kernel release currently supported on this arch is =
2.6.38.8.<o:p></o:p></p><p class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>--arch=3Dx86, not x86_64 which is for legacy =
patches when 32 and 64bit linux trees were not merged =
yet.<o:p></o:p></p><p class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>You need to unpack a vanilla linux 2.6.38.8 kernel =
tree, then<o:p></o:p></p><p class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>$ cd &lt;linux-tree&gt;<o:p></o:p></p><p =
class=3DMsoPlainText>$ &lt;xenomai-2.6.0&gt;/scripts/prepare-kernel.sh =
--arch=3Dx86<o:p></o:p></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>Nothing more.<o:p></o:p></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; And get<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; Unable to patch kernel 2.6.39 with =
<o:p></o:p></p><p class=3DMsoPlainText>&gt; =
adeos-ipipe-2.6.23-x86_64-1.4-03.patch<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; with many Hunk #xx FAILED at =
xx<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; Gregory<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; -----Message d'origine-----<o:p></o:p></p><p =
class=3DMsoPlainText>&gt; De : Gilles Chanteperdrix <a =
href=3D"mailto:[mailto:gilles.chanteperdrix@xenomai.org]"><span =
style=3D'color:windowtext;text-decoration:none'>[mailto:gilles.chanteperd=
rix@domain.hid]</span></a><o:p></o:p></p><p class=3DMsoPlainText>&gt; =
Envoy=C3=A9 : mardi 27 d=C3=A9cembre 2011 17:59<o:p></o:p></p><p =
class=3DMsoPlainText>&gt; =C3=80 : Gregory Gosse<o:p></o:p></p><p =
class=3DMsoPlainText>&gt; Cc : <a =
href=3D"mailto:xenomai@xenomai.org"><span =
style=3D'color:windowtext;text-decoration:none'>xenomai@xenomai.org</spa=
n></a><o:p></o:p></p><p class=3DMsoPlainText>&gt; Objet : Re: =
[Xenomai-help] problem following 'xenomai quick build =
guide'<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; On 12/27/2011 05:56 PM, Gregory Gosse =
wrote:<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt;=C2=A0 &gt; What can I do to go further =
?<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; There is no point in starting with such =
outdated versions. Please <o:p></o:p></p><p class=3DMsoPlainText>&gt; =
download the latest stable release of Xenomai (xenomai 2.6.0), and if =
<o:p></o:p></p><p class=3DMsoPlainText>&gt; the quick build guide does =
not work, follow the not quick build guide <o:p></o:p></p><p =
class=3DMsoPlainText>&gt; called &quot;README.INSTALL&quot; which ships =
with the sources.<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; --<o:p></o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Gilles.<o:p></o:p></p>=
<p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>&gt; =
_______________________________________________<o:p></o:p></p><p =
class=3DMsoPlainText>&gt; Xenomai-help mailing list<o:p></o:p></p><p =
class=3DMsoPlainText>&gt; <a href=3D"mailto:Xenomai-help@domain.hid"><span =
style=3D'color:windowtext;text-decoration:none'>Xenomai-help@domain.hid</spa=
n></a><o:p></o:p></p><p class=3DMsoPlainText>&gt; <a =
href=3D"https://mail.gna.org/listinfo/xenomai-help"><span =
style=3D'color:windowtext;text-decoration:none'>https://mail.gna.org/list=
info/xenomai-help</span></a><o:p></o:p></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>--<o:p></o:p></p><p =
class=3DMsoPlainText>Philippe.<o:p></o:p></p></div></body></html>
------=_NextPart_000_0004_01CCC55E.784ECE50--


