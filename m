Date: Tue, 20 Mar 2012 09:28:01 -0400
From: Glen Wernersbach <glen@domain.hid>
Message-ID: <CB8DFE21.1EE1B%glen@domain.hid>
Mime-version: 1.0
Content-type: multipart/alternative;
	boundary="B_3415080486_28560587"
Subject: [Xenomai-help] Linux Serial Does not work with
	CONFIG_XENO_OPT_PERVASIVE enabled
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

--B_3415080486_28560587
Content-type: text/plain;
	charset="ISO-8859-1"
Content-transfer-encoding: quoted-printable

Hi All,

I install Xenomai 2.6.0 on AT91SAM9G20 system and have found that when
CONFIG_XENO_OPT_PERVASIVE is enabled my standard non real time linux serial
write then read serial program does not work.

If I turn off CONFIG_XENO_OPT_PERVASIVE, my serial program does work.

Any ideas why?????


Also, when you turn CONFIG_XENO_OPT_PERVASIVE you get this error:
CC      kernel/xenomai/nucleus/synch.o
kernel/xenomai/nucleus/synch.c: In function 'xnsynch_release_thread':
kernel/xenomai/nucleus/synch.c:688:3: error: implicit declaration of
function 'xnthread_get_rescnt'
kernel/xenomai/nucleus/synch.c:689:4: error: implicit declaration of
function 'xnshadow_send_sig'

I had to go in and make the code for that option be for it always false.

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


--B_3415080486_28560587
Content-type: text/html;
	charset="ISO-8859-1"
Content-transfer-encoding: quoted-printable

<HTML>
<HEAD>
<TITLE>Linux Serial Does not work with CONFIG_XENO_OPT_PERVASIVE enabled</T=
ITLE>
</HEAD>
<BODY>
<FONT FACE=3D"Calibri, Verdana, Helvetica, Arial"><SPAN STYLE=3D'font-size:11pt=
'>Hi All,<BR>
<BR>
I install Xenomai 2.6.0 on AT91SAM9G20 system and have found that when CONF=
IG_XENO_OPT_PERVASIVE is enabled my standard non real time linux serial writ=
e then read serial program does not work.<BR>
<BR>
If I turn off CONFIG_XENO_OPT_PERVASIVE, my serial program does work. <BR>
<BR>
Any ideas why?????<BR>
<BR>
<BR>
Also, when you turn </SPAN></FONT><FONT SIZE=3D"2"><FONT FACE=3D"Courier TU"><S=
PAN STYLE=3D'font-size:10pt'>CONFIG_XENO_OPT_PERVASIVE you get this error:<BR>
CC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel/xenomai/nucleus/synch.o<BR>
kernel/xenomai/nucleus/synch.c: In function 'xnsynch_release_thread':<BR>
kernel/xenomai/nucleus/synch.c:688:3: error: implicit declaration of<BR>
function 'xnthread_get_rescnt'<BR>
kernel/xenomai/nucleus/synch.c:689:4: error: implicit declaration of<BR>
function 'xnshadow_send_sig'<BR>
</SPAN></FONT></FONT><FONT FACE=3D"Calibri, Verdana, Helvetica, Arial"><SPAN =
STYLE=3D'font-size:11pt'><BR>
I had to go in and make the code </SPAN></FONT><FONT SIZE=3D"2"><FONT FACE=3D"C=
ourier TU"><SPAN STYLE=3D'font-size:10pt'>for that option be</SPAN></FONT></FO=
NT><FONT FACE=3D"Calibri, Verdana, Helvetica, Arial"><SPAN STYLE=3D'font-size:11=
pt'> for it always false.<BR>
<BR>
Glen<BR>
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


--B_3415080486_28560587--




