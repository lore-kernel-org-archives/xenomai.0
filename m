Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C69BA1.0EF5AE39"
Date: Thu, 29 Jun 2006 12:25:46 -0500
Message-ID: <0D21CBD1298D2C4790E2F2B86D96EC19013280F8@domain.hid>
From: "Reynolds, Terry AMRDEC/SimTech" <terry.reynolds2@domain.hid>
Subject: [Adeos-main] User space, level triggered interrupt
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C69BA1.0EF5AE39
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,
=20
I'm trying to understand what I'm seeing in my real-time code where I
handle a PCI interrupt, using it to handshake with a program running on
another computer connected via a PCI reflective memory card.  This is on
a G5 ppc64 kernel.
=20
When I register the driver for the PCI card, I allocate an IRQ for it,
and install the kernel ISR which only returns IRQ_HANDLED.  I mmap the
registers on the card, as the user application has to access them to
clear the PCI interrupt after the IRQ is detected.
=20
My realtime application is based on Fusion 0.9, but I've looked at the
Xenomai version of the rt_intr_wait code and don't see any differences.
The realtime code accesses the card's pci driver to read the IRQ number,
and creates a user space interrupt object (passing I_PROPAGATE &
I_AUTOENA ).  What's strange is that when I call rt_intr_wait for an
instance where only one interrupt has fired, but several micro-seconds
have passed prior to the wait function, the wait returns values
indicating that several interrupts are pending.  Calling the wait
function without allowing any spare time returns a correct 'one'
interrupt having fired.  Calling the wait once seems to clear the
interrupt pending count.
=20
My questions are:  how are multiple interrupt pending counts being
generated during a real time task that doesn't yield?  How is it
possible to service several pending interrupts if the pending count gets
cleared every time you check for an interrupt?
=20
=20
Thanks,
=20
=20

Terry Reynolds

Simulation Technologies, INC.

=20

When trouble arises and things look bad, there is always=20

one individual who perceives a solution and is willing to=20

take command.  Very often, that individual is crazy.

                                                            Dave Barry

=20

------_=_NextPart_001_01C69BA1.0EF5AE39
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2912" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D492300316-29062006><FONT face=3DArial size=3D2>Hi=20
All,</FONT></SPAN></DIV>
<DIV><SPAN class=3D492300316-29062006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D492300316-29062006><FONT face=3DArial size=3D2>I'm =
trying to=20
understand what I'm seeing in my real-time code where I handle a PCI =
interrupt,=20
using it to handshake with a program running on another computer =
connected via a=20
PCI reflective memory card.&nbsp; This is on a G5 ppc64=20
kernel.</FONT></SPAN></DIV>
<DIV><SPAN class=3D492300316-29062006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D492300316-29062006><FONT face=3DArial size=3D2>When I =
register the=20
driver for the PCI card, I allocate an IRQ for it, and install the =
kernel ISR=20
which only returns IRQ_HANDLED.&nbsp; I mmap the registers on the =
card,&nbsp;as=20
the user application has to access them to clear the PCI interrupt after =
the IRQ=20
is detected.</FONT></SPAN></DIV>
<DIV><SPAN class=3D492300316-29062006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D492300316-29062006><FONT face=3DArial size=3D2>My =
realtime=20
application is based on Fusion 0.9, but I've looked at the Xenomai =
version of=20
the rt_intr_wait code and don't see any differences.&nbsp; The realtime =
code=20
accesses the card's pci driver to read the IRQ number, and creates a =
user space=20
interrupt object (passing <FONT face=3D"Times New Roman" size=3D3><FONT =
face=3DArial=20
size=3D2>I_PROPAGATE &amp; I_AUTOENA</FONT> <FONT face=3DArial =
size=3D2>).&nbsp;=20
What's strange is that when I call rt_intr_wait for an instance where =
only one=20
interrupt has fired, but several micro-seconds have passed prior to the =
wait=20
function, the wait returns values indicating that several interrupts are =

pending.&nbsp; Calling the wait function without allowing any spare time =
returns=20
a correct 'one' interrupt having fired.&nbsp; Calling the wait once =
seems to=20
clear the interrupt pending count.</FONT></FONT></FONT></SPAN></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D492300316-29062006><FONT face=3DArial size=3D2>My =
questions=20
are:&nbsp; how are multiple interrupt pending counts being generated =
during a=20
real time task that doesn't yield?&nbsp; How is it possible to service =
several=20
pending interrupts if the pending count gets cleared every time you =
check for an=20
interrupt?</FONT></SPAN></DIV>
<DIV><SPAN class=3D492300316-29062006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D492300316-29062006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D492300316-29062006><FONT face=3DArial=20
size=3D2>Thanks,</FONT></SPAN></DIV>
<DIV><SPAN class=3D492300316-29062006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D492300316-29062006></SPAN>&nbsp;</DIV>
<DIV class=3DSection1>
<P class=3DMsoNormal align=3Dleft><EM><SPAN=20
style=3D"FONT-SIZE: 18pt; FONT-FAMILY: 'Comic Sans MS'">Terry=20
Reynolds</SPAN></EM></P>
<P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">Simulation=20
Technologies, INC.</SPAN></P>
<P class=3DMsoNormal>&nbsp;</P><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-family: =
'Times New Roman'">
<P class=3DMsoNormal=20
style=3D"MARGIN: 0in 0in 0pt; tab-stops: .5in; mso-layout-grid-align: =
none"><FONT=20
size=3D3><EM><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">When =
trouble arises=20
and things look bad, there is always </SPAN></EM></FONT></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0in 0in 0pt; tab-stops: .5in; mso-layout-grid-align: =
none"><FONT=20
size=3D3><EM><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">one&nbsp;</SPAN><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">individual who perceives a =
solution=20
and is willing to </SPAN></EM></FONT></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0in 0in 0pt; tab-stops: .5in; mso-layout-grid-align: =
none"><FONT=20
size=3D3><EM><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">take=20
command.&nbsp;<SPAN style=3D"mso-spacerun: =
yes">&nbsp;</SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Very often, that =
individual is=20
crazy.</SPAN></EM></FONT></P>
<P class=3DMsoNormal></SPAN></P>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
Dave Barry</SPAN></P></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C69BA1.0EF5AE39--

