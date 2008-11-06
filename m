Date: Thu, 6 Nov 2008 14:02:07 +0000 (GMT)
From: Gabriele Moabiti <gabmoa@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1939125318-1225980127=:36286"
Message-ID: <184467.36286.qm@domain.hid>
Subject: Re: [Xenomai-help] the exception saga - system hangs
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

--0-1939125318-1225980127=:36286
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=0A>>     __asm__ __volatile__("nop; movl %dr7, %eax;nop");=0A>=0A>This pie=
ce of inline assembly is incorrect, you should mark as output=0A>register t=
he registers you clobber.=0A=0A*ops* I'm not very skilled in Gnu asm=0AThe =
user task asm istruction is used only to raise an exception (CPL=3D0 only),=
=0Abut I can change the example:=0A=0Ainsted of the that asm line i write =
=0A__asm__ __volatile__(nop; clts;nop;);=0A=0Aand in the kernel module I ch=
ange the check=0A=0A- if (*istr =3D=3D 0x210f && (*(istr+1) & 0xFF) =3D=3D =
0xf8) { // movl %dr7, %eax=0A-      regs->x86reg_ip+=3D3;=0A+if (*istr =3D=
=3D 0x060f) { /* clts */=0A+    regs->x86reg_ip+=3D2;=0A=0Athe behaviour is=
 always the same... after some loops system hang=0A(tested with turned on a=
nd off all debug options of xenomai)=0A=0A Gabriele=0A=0A=0A      Unisciti =
alla community di Io fotografo e video, il nuovo corso di fotografia di Gaz=
zetta dello sport:=0Ahttp://www.flickr.com/groups/iofotografoevideo
--0-1939125318-1225980127=:36286
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:arial,helvetica,sans-serif;font-size:10p=
t"><div style=3D"font-family: arial,helvetica,sans-serif; font-size: 10pt;"=
><div style=3D"font-family: arial,helvetica,sans-serif; font-size: 10pt;"><=
div style=3D"font-family: arial,helvetica,sans-serif; font-size: 10pt;"><br=
>&gt;&gt;&nbsp; &nbsp;  __asm__ __volatile__("nop; movl %dr7, %eax;nop");<b=
r>&gt;<br>&gt;This piece of inline assembly is incorrect, you should mark a=
s output<br>&gt;register the registers you clobber.<br><br>*ops* I'm not ve=
ry skilled in Gnu asm<br>The user task asm istruction is used only to raise=
 an exception (CPL=3D0 only),<br>but I can change the example:<br><br>inste=
d of the that asm line i write <br>__asm__ __volatile__(nop; clts;nop;);<br=
><br>and in the kernel module I change the check<br><br>- if (*istr =3D=3D =
0x210f &amp;&amp; (*(istr+1) &amp; 0xFF) =3D=3D 0xf8) { // movl %dr7,
 %eax<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regs-&gt;x86reg_ip+=3D3;<br>+if (*=
istr =3D=3D 0x060f) { /* clts */<br>+&nbsp;&nbsp;&nbsp; regs-&gt;x86reg_ip+=
=3D2;<br><br>the behaviour is always the same... after some loops system ha=
ng<br>(tested with turned on and off all debug options of xenomai)<br><br>&=
nbsp;Gabriele<br><br></div></div></div></div><br>=0A=0A=0A=0A      <hr size=
=3D1><font face=3D"Arial" size=3D"2">Scopri la community di Io fotografo e =
video<br>=0A<a href=3Dhttp://us.rd.yahoo.com/SIG=3D11ud6kror/**http%3A%2F%2=
Fwww.flickr.com%2Fgroups%2Fiofotografoevideo%2F>Il nuovo corso</a> di Gazze=
tta dello sport per diventare veri fotografi!</font></body></html>
--0-1939125318-1225980127=:36286--

