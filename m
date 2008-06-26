Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8D774.2A974D77"
Date: Thu, 26 Jun 2008 12:05:30 +0200
Message-ID: <406CC9939904F143B9D42CEEA3E56E563331EA@oab1mx1.oneaccess.intra>
From: "Filip Van Rillaer" <Filip.VanRillaer@domain.hid>
Subject: [Xenomai-help] help: pipe + event flag group (or other
	synchronisation mechanism
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8D774.2A974D77
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,=20

Our application is written with some kind of super-loop scheduling : we
have many drivers that call rt_event_signal (when data have been written
to the hardware or new data are available to be processed) and 1 task
that is calling rt_event_wait. After receiving an event, the superloop
task is then reading/writing the data from/to the appropriate driver.
Those calls to the drivers must never block (except to some locking to
protect the consistency of data-structures) to garantuee the real-time
behaviour of the application.
Now we want to communicate with the Linux-domain and thought we have to
use the Xenomai pipe-object for that purpose.

How can the superloop task in Xenomai receive an event from the
pipe-object when data are available to be read/written (so without
already reading the data)?

The ideal solution would be if one can ask the pipe-driver to call a
user-callback function when there is a change in the status (read/write)
or an equivalent system to the EPOLL interface (from the uclinux
domain).

Best regards,
Filip.


------_=_NextPart_001_01C8D774.2A974D77
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.6000.16640" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2>
<DIV>
<P><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D385550707-24062008>Hello,</SPAN>&nbsp;</FONT></FONT></P>
<P><FONT face=3DArial size=3D2>Our application is written with some kind =
of=20
super-loop scheduling :&nbsp;we have many drivers that call =
rt_event_signal=20
(when data have been&nbsp;written to the hardware or new data are =
available to=20
be processed) and&nbsp;1 task that is calling rt_event_wait. After =
receiving an=20
event, the&nbsp;superloop task is then reading/writing the data from/to =
the=20
appropriate driver.<SPAN class=3D385550707-24062008>&nbsp;</SPAN>Those =
calls to=20
the drivers must never block<SPAN class=3D385550707-24062008> (except to =
some=20
locking to protect the consistency of data-structures)</SPAN>&nbsp;to =
garantuee=20
the real-time&nbsp;</FONT><FONT face=3DArial size=3D2>behaviour o<SPAN=20
class=3D385550707-24062008>f</SPAN> the application.<BR>Now we want to =
communicate=20
with the Linux-domain and thought we have&nbsp;to use the Xenomai =
pipe-object=20
for that purpose.</FONT></P>
<P><FONT face=3DArial size=3D2>How can the superloop task in Xenomai =
receive an=20
event from the&nbsp;pipe-object when data are available to be =
read/written (so=20
without&nbsp;</FONT><FONT face=3DArial><FONT size=3D2>already reading =
the=20
data)?<BR><BR><SPAN class=3D385550707-24062008>The ideal solution would =
be if one=20
can ask the pipe-driver to call a user-callback function when there is a =
change=20
in the status (read/write) or an equivalent system to the&nbsp;EPOLL =
interface=20
(from the uclinux domain).</SPAN></FONT></FONT></P>
<P><FONT face=3DArial size=3D2>Best regards,<BR></FONT><FONT =
face=3DArial=20
size=3D2>Filip.</FONT></P></DIV></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C8D774.2A974D77--

