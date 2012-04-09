Date: Mon, 09 Apr 2012 00:44:02 -0400
From: Glen Wernersbach <glen@domain.hid>
Message-ID: <CBA7E152.1F509%glen@domain.hid>
Mime-version: 1.0
Content-type: multipart/alternative;
	boundary="B_3416777074_15101140"
Subject: [Xenomai-help] Rename xeno_16550A module name
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

> This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--B_3416777074_15101140
Content-type: text/plain;
	charset="ISO-8859-1"
Content-transfer-encoding: quoted-printable

Hi All,

Here is a simple question

How can I just rename the module name that shows in LSMOD for the
xeno_16550A.ko serial driver????

I have change the name in 16550A.c but that did not work.

I tried hard coding the KBUILD_NAME xeno_16550A.mod.c  but it just get
replaced with every build.

Same with the hidden command files.

If I was more familiar with build scripts this would be easy.

I am trying to be able to load two difference mods of the xeno_16550.ko
driver at one time for testing on different ports.

Glen




--=20
Glen Wernersbach
President & CTO

Jetsoft Development Co.
629 Old St Rt. 74 =AD Suite 210
Cincinnati, Oh 45244
Custom Programming Web Site: www.jetsoftdev.com
Retail Products Web Site: www.scanhelp.com
Phone:   513-528-6660
Fax: 513-528-3470
Cell 513-240-9929
----
Partner for Software Technology
Jacobs Automation
2365 Progress Drive
Hebron, KY 41048=20
(513) 297-7550
----
"Support Dyslexia Research"


--B_3416777074_15101140
Content-type: text/html;
	charset="ISO-8859-1"
Content-transfer-encoding: quoted-printable

<HTML>
<HEAD>
<TITLE>Rename xeno_16550A module name</TITLE>
</HEAD>
<BODY>
<FONT FACE=3D"Calibri, Verdana, Helvetica, Arial"><SPAN STYLE=3D'font-size:11pt=
'>Hi All,<BR>
<BR>
Here is a simple question<BR>
<BR>
How can I just rename the module name that shows in LSMOD for the xeno_1655=
0A.ko serial driver????<BR>
<BR>
I have change the name in 16550A.c but that did not work.<BR>
<BR>
I tried hard coding the KBUILD_NAME xeno_16550A.mod.c &nbsp;but it just get=
 replaced with every build.<BR>
<BR>
Same with the hidden command files.<BR>
<BR>
If I was more familiar with build scripts this would be easy.<BR>
<BR>
I am trying to be able to load two difference mods of the xeno_16550.ko dri=
ver at one time for testing on different ports.<BR>
<BR>
Glen<BR>
<BR>
<BR>
<BR>
<BR>
-- <BR>
Glen Wernersbach<BR>
President &amp; CTO<BR>
<BR>
Jetsoft Development Co.<BR>
629 Old St Rt. 74 &#8211; Suite 210<BR>
Cincinnati, Oh 45244<BR>
Custom Programming Web Site: www.jetsoftdev.com<BR>
Retail Products Web Site: www.scanhelp.com<BR>
Phone: &nbsp;&nbsp;513-528-6660<BR>
Fax: 513-528-3470<BR>
Cell 513-240-9929<BR>
----<BR>
Partner for Software Technology<BR>
Jacobs Automation<BR>
</SPAN></FONT><FONT COLOR=3D"#323232"><FONT SIZE=3D"2"><FONT FACE=3D"Arial"><SPAN=
 STYLE=3D'font-size:10pt'>2365 Progress Drive <BR>
Hebron, KY 41048 <BR>
(513) 297-7550<BR>
----<BR>
</SPAN></FONT></FONT></FONT><FONT FACE=3D"Calibri, Verdana, Helvetica, Arial"=
><SPAN STYLE=3D'font-size:11pt'>&quot;Support Dyslexia Research&quot;<BR>
</SPAN></FONT>
</BODY>
</HTML>


--B_3416777074_15101140--




