From: "Gregory Gosse" <gregory.gosse@domain.hid>
References: <000101ccc4b8$74856eb0$5d904c10$@soterem.fr>
	<4EF9F949.5000708@domain.hid>
In-Reply-To: <4EF9F949.5000708@domain.hid>
Date: Wed, 28 Dec 2011 10:17:18 +0100
Message-ID: <000001ccc541$7fa8d960$7efa8c20$@soterem.fr>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0001_01CCC549.E1700080"
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
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is a multipart message in MIME format.

------=_NextPart_000_0001_01CCC549.E1700080
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Now i use more recent xenomai and kernel versions :

- xenomai 2.6.0   2011-11-05 ( latest )

- kernel 2.6.39 ( latest in 2.6 serie )

With the same patch :

- adeos-ipipe-2.6.23-x86_64-1.4-03.patch

=20

I launch the command

scripts/prepare-kernel.sh --linux=3D/usr/src/linux-2.6.39 =
--adeos=3D/usr/src/xenomai-2.6.0/ksrc/arch/x86/patches/adeos-ipipe-2.6.23=
-x86_64-1.4-03.patch --arch=3Dx86_64

=20

And get

Unable to patch kernel 2.6.39 with =
adeos-ipipe-2.6.23-x86_64-1.4-03.patch

=20

with many Hunk #xx FAILED at xx

=20

Gregory

=20

-----Message d'origine-----
De : Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Envoy=C3=A9 : mardi 27 d=C3=A9cembre 2011 17:59
=C3=80 : Gregory Gosse
Cc : xenomai@xenomai.org
Objet : Re: [Xenomai-help] problem following 'xenomai quick build guide'

=20

On 12/27/2011 05:56 PM, Gregory Gosse wrote:

> What can I do to go further ?

=20

There is no point in starting with such outdated versions. Please =
download the latest stable release of Xenomai (xenomai 2.6.0), and if =
the quick build guide does not work, follow the not quick build guide =
called "README.INSTALL" which ships with the sources.

--=20

                                                                Gilles.


------=_NextPart_000_0001_01CCC549.E1700080
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
span.TextebrutCar
	{mso-style-name:"Texte brut Car";
	mso-style-priority:99;
	mso-style-link:"Texte brut";
	font-family:"Calibri","sans-serif";}
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
vlink=3Dpurple><div class=3DWordSection1><p class=3DMsoPlainText><span =
lang=3DEN-US>Now i use more recent xenomai and kernel versions =
:<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US>- =
xenomai 2.6.0 =C2=A0=C2=A02011-11-05 ( latest )<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>- kernel 2.6.39 ( latest in 2.6 =
serie )<o:p></o:p></span></p><p class=3DMsoPlainText><span =
lang=3DEN-US>With the same patch :<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>- =
adeos-ipipe-2.6.23-x86_64-1.4-03.patch<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>I launch the =
command<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>scripts/prepare-kernel.sh --linux=3D/usr/src/linux-2.6.39 =
--adeos=3D/usr/src/xenomai-2.6.0/ksrc/arch/x86/patches/adeos-ipipe-2.6.23=
-x86_64-1.4-03.patch --arch=3Dx86_64<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US>And get<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US style=3D'color:red'>Unable to =
patch kernel 2.6.39 with =
adeos-ipipe-2.6.23-x86_64-1.4-03.patch<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US =
style=3D'color:red'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US style=3D'color:black'>with many =
</span><span lang=3DEN-US style=3D'color:red'>Hunk #xx FAILED at =
xx<o:p></o:p></span></p><p class=3DMsoPlainText><span lang=3DEN-US =
style=3D'color:red'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US =
style=3D'color:black'>Gregory<o:p></o:p></span></p><p =
class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoPlainText><span =
style=3D'mso-fareast-language:FR'>-----Message =
d'origine-----<br>De&nbsp;: Gilles Chanteperdrix =
[mailto:gilles.chanteperdrix@xenomai.org] <br>Envoy=C3=A9&nbsp;: mardi =
27 d=C3=A9cembre 2011 17:59<br>=C3=80&nbsp;: Gregory Gosse<br>Cc&nbsp;: =
xenomai@xenomai.org<br>Objet&nbsp;: Re: [Xenomai-help] problem =
following 'xenomai quick build guide'</span></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText>On =
12/27/2011 05:56 PM, Gregory Gosse wrote:<o:p></o:p></p><p =
class=3DMsoPlainText>&gt; What can I do to go further ?<o:p></o:p></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText>There =
is no point in starting with such outdated versions. Please download the =
latest stable release of Xenomai (xenomai 2.6.0), and if the quick build =
guide does not work, follow the not quick build guide called =
&quot;README.INSTALL&quot; which ships with the =
sources.<o:p></o:p></p><p class=3DMsoPlainText>-- <o:p></o:p></p><p =
class=3DMsoPlainText>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Gilles.<o:p></o:p></p></div></body></html>
------=_NextPart_000_0001_01CCC549.E1700080--


