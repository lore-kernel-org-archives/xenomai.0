Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C95634.4C2B2E6A"
Date: Thu, 4 Dec 2008 18:18:17 +0100
Message-ID: <A820268933E41D449CC13B5E097C1E2F0363CE32@domain.hid>
From: "Rubio, Martial" <Martial.Rubio@domain.hid>
Subject: [Xenomai-help] FW: xntslave_start,xntslave_stop
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>
Cc: Jean-Francois Gilot <jeanfrancois.gilot@domain.hid>, "Dupeyrou,
	Gilles" <Gilles.Dupeyrou@domain.hid>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C95634.4C2B2E6A
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello ...
=20
... another subsidiary question ... what about of "new =
xntbase_bind/unbind" calls ?
These calls don't exist in Xenomai nucleus v2.4.5 .
=20
... other information about xntslave_start/stop (undefined ref while =
module install) :
=20
hurle-bise [anaisvs](80):nm vmlinux.o | grep slave

0010f518 b pty_slave_driver
0005ce2a T xntslave_adjust
0005cc2e T xntslave_destroy
0005d383 T xntslave_init
0005cb0d T xntslave_start
0005ca0f T xntslave_stop
0005c6e7 T xntslave_update
=20
Regards
=20
Martial

________________________________

From: Rubio, Martial=20
Sent: Thursday, December 04, 2008 5:18 PM
To: xenomai@xenomai.org; Philippe Gerum
Cc: Dupeyrou, Gilles; 'Jean-Fran=E7ois Gilot'
Subject: xntslave_start,xntslave_stop


Hello everybody ...
=20
In preamble... find below Philippe's reply (in 08/2008) about HW =
implementation of VxWorks's announcetick
(MSI/PCI interrupt) :
=20
If you want to hack the Xenomai timer sub-system in order to only affect =
the VxWorks timebase, what you actually need is to control the coupling =
between the master timebase (paced by decrementer) and the slave VxWorks =
one, so that decrementer ticks may be prevented from kicking the VxWorks =
timebase. This way, you would be able to call tickAnnounce() freely to =
announce any incoming VxWorks tick (i.e. from your PCI handler).

In short, when paced by the PCI interrupt, you will need to:

- call xntslave_stop(base2slave(wind_tbase))

- call tickAnnounce() from your PCI IRQ handler

When paced normally (simulation, "somebody stole by PCI card" mode), =
just leave the burden to the system timer (i.e. ppc decrementer) as =
usual, by coupling the VxWorks slave timebase to the master one anew:

- call xntslave_start(base2slave(wind_tbase), xnarch_get_cpu_time() + =
period, period); /* period is given in nanoseconds, depends on the =
master timebase */

In any case, you don't need to change the VxWorks tick period. =
Starting/stopping the VxWorks timebase should do the trick.

 NOTE: this is a hack exposing Xenomai internals -- we should probably =
encapsulate this into new xntbase_bind/unbind calls if this does =
eventually works for you.

=20

=20

=20

My probleme is the following one :

I tried to use xntslave_start/stop in my rtdm module, but it seems that, =
despite xntslave_start/stop instructions are present in my System.map, =
the linker don't archive :

> grep xntslave_start /boot/System.map-2.6.25-pae=20

c01629b9 T xntslave_start=20

> depmod -F /boot/System.map-2.6.25-pae -e vxworks_tick_time_module.ko=20

WARNING: vxworks_tick_time_module.ko needs unknown symbol xntslave_start =


WARNING: vxworks_tick_time_module.ko needs unknown symbol xntslave_stop=20

I think I've missed something but ... what ?

And a subsidiary question : If I'm using xntbase_start/stop instead of =
xntslave_start/stop

is the behaviour the same one ? (xntbase_xxxx can be  linked !!!)

Regards

Martial


------_=_NextPart_001_01C95634.4C2B2E6A
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns:o =3D "urn:schemas-microsoft-com:office:office"><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.3790.3959" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D668060217-04122008>Hello ...</SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D668060217-04122008></SPAN></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D668060217-04122008>... another subsidiary question ... =
what&nbsp;about of=20
<FONT face=3D"Times New Roman"><FONT color=3D#000000 size=3D3>"new=20
xntbase_bind/unbind" calls ?</FONT></FONT></SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT><SPAN class=3D668060217-04122008>These =
calls don't=20
exist in Xenomai nucleus v2.4.5 .</SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT><SPAN=20
class=3D668060217-04122008></SPAN></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D668060217-04122008>... other information about =
xntslave_start/stop=20
(undefined ref while module install) :</SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D668060217-04122008></SPAN></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D668060217-04122008>hurle-bise [anaisvs](80):nm vmlinux.o | grep=20
slave</SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D668060217-04122008><BR>0010f518 b pty_slave_driver<BR>0005ce2a T =

xntslave_adjust<BR>0005cc2e T xntslave_destroy<BR>0005d383 T=20
xntslave_init<BR>0005cb0d T xntslave_start<BR>0005ca0f T=20
xntslave_stop<BR>0005c6e7 T xntslave_update</SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D668060217-04122008></SPAN></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D668060217-04122008>Regards</SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D668060217-04122008></SPAN></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D668060217-04122008>Martial</SPAN></FONT></DIV><BR>
<DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
<HR tabIndex=3D-1>
<FONT face=3DTahoma size=3D2><B>From:</B> Rubio, Martial =
<BR><B>Sent:</B> Thursday,=20
December 04, 2008 5:18 PM<BR><B>To:</B> xenomai@xenomai.org; Philippe=20
Gerum<BR><B>Cc:</B> Dupeyrou, Gilles; 'Jean-Fran=E7ois =
Gilot'<BR><B>Subject:</B>=20
xntslave_start,xntslave_stop<BR></FONT><BR></DIV>
<DIV></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D125115115-04122008>Hello =
everybody=20
...</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D125115115-04122008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D125115115-04122008>In =
preamble... find=20
below Philippe's reply (in 08/2008) about HW implementation of VxWorks's =

announcetick</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D125115115-04122008>(MSI/PCI interrupt)=20
:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D125115115-04122008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D125115115-04122008>
<P class=3DMsoNormal><FONT face=3D"Times New Roman" size=3D3><SPAN =
lang=3DEN-GB=20
style=3D"FONT-SIZE: 12pt">If you want to hack the Xenomai timer =
sub-system in=20
order to only affect the VxWorks timebase, what you actually need is to =
control=20
the coupling between the master timebase (paced by decrementer) and the =
slave=20
VxWorks one, so that decrementer ticks may be prevented from kicking the =
VxWorks=20
timebase. This way, you would be able to call tickAnnounce() freely to =
announce=20
any incoming VxWorks tick (i.e. from your PCI=20
handler).<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D"Times New Roman" size=3D3><SPAN =
lang=3DEN-GB=20
style=3D"FONT-SIZE: 12pt"><o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D"Times New Roman" size=3D3><SPAN =
lang=3DEN-GB=20
style=3D"FONT-SIZE: 12pt">In short, when paced by the PCI interrupt, you =
will need=20
to:<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal style=3D"TEXT-INDENT: 35.4pt"><FONT face=3D"Times =
New Roman"=20
size=3D3><SPAN lang=3DEN-GB style=3D"FONT-SIZE: 12pt">- call=20
xntslave_stop(base2slave(wind_tbase))</SPAN></FONT></P>
<P class=3DMsoNormal style=3D"TEXT-INDENT: 35.4pt"><FONT face=3D"Times =
New Roman"=20
size=3D3><SPAN lang=3DEN-GB style=3D"FONT-SIZE: =
12pt"></SPAN></FONT><FONT=20
face=3D"Times New Roman" size=3D3><SPAN lang=3DEN-GB style=3D"FONT-SIZE: =
12pt">- call=20
tickAnnounce() from your PCI IRQ handler<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D"Times New Roman" size=3D3><SPAN =
lang=3DEN-GB=20
style=3D"FONT-SIZE: 12pt"><o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D"Times New Roman" size=3D3><SPAN =
lang=3DEN-GB=20
style=3D"FONT-SIZE: 12pt">When paced normally (simulation, "somebody =
stole by PCI=20
card" mode), just leave the burden to the system timer (i.e. ppc =
decrementer) as=20
usual, by coupling the VxWorks slave timebase to the master one=20
anew:<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal style=3D"TEXT-INDENT: 35.4pt"><FONT face=3D"Times =
New Roman"=20
size=3D3><SPAN lang=3DEN-GB style=3D"FONT-SIZE: 12pt">- call=20
xntslave_start(base2slave(wind_tbase), xnarch_get_cpu_time() + period, =
period);=20
/* period is given in nanoseconds, depends on the master timebase=20
*/<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D"Times New Roman" size=3D3><SPAN =
lang=3DEN-GB=20
style=3D"FONT-SIZE: 12pt"><o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D"Times New Roman" size=3D3><SPAN =
lang=3DEN-GB=20
style=3D"FONT-SIZE: 12pt">In any case, you don't need to change the =
VxWorks tick=20
period. Starting/stopping the VxWorks timebase should do the=20
trick.</SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D"Times New Roman" size=3D3><SPAN =
lang=3DEN-GB=20
style=3D"FONT-SIZE: 12pt">&nbsp;NOTE: this is a hack exposing Xenomai =
internals --=20
we should probably encapsulate this into new xntbase_bind/unbind calls =
if this=20
does eventually works for you.</SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D"Times New Roman" size=3D3><SPAN =
lang=3DEN-GB=20
style=3D"FONT-SIZE: 12pt"></SPAN></FONT>&nbsp;</P>
<P class=3DMsoNormal><FONT face=3D"Times New Roman" size=3D3><SPAN =
lang=3DEN-GB=20
style=3D"FONT-SIZE: 12pt"></SPAN></FONT>&nbsp;</P>
<P class=3DMsoNormal><FONT face=3D"Times New Roman" size=3D3><SPAN =
lang=3DEN-GB=20
style=3D"FONT-SIZE: 12pt"></SPAN></FONT>&nbsp;</P>
<P class=3DMsoNormal><FONT face=3D"Times New Roman"><SPAN lang=3DEN-GB=20
style=3D"FONT-SIZE: 12pt"><SPAN class=3D125115115-04122008>My probleme =
is the=20
following one :</SPAN></SPAN></FONT></P><FONT size=3D+0><SPAN =
lang=3DEN-GB=20
style=3D"FONT-SIZE: 12pt"><SPAN class=3D125115115-04122008>
<P class=3DMsoNormal><SPAN lang=3DEN-GB style=3D"FONT-SIZE: 12pt"><FONT=20
face=3D"Times New Roman">I tried to use xntslave_start/stop in my rtdm =
module, but=20
it seems that, despite xntslave_start/stop instructions are present in =
my=20
System.map, the linker don't archive :<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal style=3D"TEXT-INDENT: 35.4pt"><SPAN lang=3DEN-GB=20
style=3D"FONT-SIZE: 12pt"><FONT face=3D"Times New Roman">&gt; grep =
xntslave_start=20
/boot/System.map-2.6.25-pae <o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal style=3D"TEXT-INDENT: 35.4pt"><SPAN lang=3DEN-GB=20
style=3D"FONT-SIZE: 12pt"><FONT face=3D"Times New Roman">c01629b9 T =
xntslave_start=20
<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal style=3D"TEXT-INDENT: 35.4pt"><SPAN lang=3DEN-GB=20
style=3D"FONT-SIZE: 12pt"><FONT face=3D"Times New Roman">&gt; depmod -F=20
/boot/System.map-2.6.25-pae -e vxworks_tick_time_module.ko=20
<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal style=3D"TEXT-INDENT: 35.4pt"><SPAN lang=3DEN-GB=20
style=3D"FONT-SIZE: 12pt"><FONT face=3D"Times New Roman">WARNING:=20
vxworks_tick_time_module.ko needs unknown symbol xntslave_start=20
<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal style=3D"TEXT-INDENT: 35.4pt"><FONT=20
face=3D"Times New Roman"><SPAN lang=3DEN-GB style=3D"FONT-SIZE: =
12pt">WARNING:=20
vxworks_tick_time_module.ko needs unknown symbol xntslave_stop=20
</SPAN></FONT></P>
<P class=3DMsoNormal style=3D"TEXT-INDENT: 35.4pt"><FONT=20
face=3D"Times New Roman"><SPAN lang=3DEN-GB style=3D"FONT-SIZE: =
12pt"><SPAN=20
class=3D125115115-04122008>I think I've missed something but ... what=20
?</SPAN></SPAN></FONT></P>
<P class=3DMsoNormal style=3D"TEXT-INDENT: 35.4pt"><FONT=20
face=3D"Times New Roman"><SPAN lang=3DEN-GB style=3D"FONT-SIZE: =
12pt"><SPAN=20
class=3D125115115-04122008>And a subsidiary question : If I'm using=20
xntbase_start/stop instead of =
xntslave_start/stop</SPAN></SPAN></FONT></P>
<P class=3DMsoNormal style=3D"TEXT-INDENT: 35.4pt"><FONT=20
face=3D"Times New Roman"><SPAN lang=3DEN-GB style=3D"FONT-SIZE: =
12pt"><SPAN=20
class=3D125115115-04122008>is the behaviour the same one ? =
(xntbase_xxxx&nbsp;can=20
be &nbsp;linked !!!)</SPAN></SPAN></FONT></P>
<P class=3DMsoNormal style=3D"TEXT-INDENT: 35.4pt"><FONT=20
face=3D"Times New Roman"><SPAN lang=3DEN-GB style=3D"FONT-SIZE: =
12pt"><SPAN=20
class=3D125115115-04122008>Regards</SPAN></SPAN></FONT></P>
<P class=3DMsoNormal style=3D"TEXT-INDENT: 35.4pt"><FONT=20
face=3D"Times New Roman"><SPAN lang=3DEN-GB style=3D"FONT-SIZE: =
12pt"><SPAN=20
class=3D125115115-04122008>Martial</SPAN></SPAN></FONT></SPAN></SPAN></FO=
NT></P></SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C95634.4C2B2E6A--

