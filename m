Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8F2EE.A11B3B96"
Date: Thu, 31 Jul 2008 11:20:09 +0200
Message-ID: <406CC9939904F143B9D42CEEA3E56E563AC067@domain.hid>
From: "Filip Van Rillaer" <Filip.VanRillaer@domain.hid>
Subject: [Xenomai-help] xnpipe EPOLLIN starvation
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

------_=_NextPart_001_01C8F2EE.A11B3B96
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
I am transferring data from the Xenomai domain to the 2nd domain with
the xenomai pipe.  In the 2nd domain I am using the epoll interface to
wait for the arrival of new data.  The first time that data are written
in the pipe at the Xenomai side, the 2nd domain receives the EPOLLIN (an
that's OK).  But the 2nd time data are written in the pipe at the
Xenomai side, the 2nd domain is NOT receiving EPOLLIN and therefore dies
forever.
=20
I am not familiar at all with the Xenomai internals, but I tried to
gather some information: it look like when the first characters are
written at the Xenomai side, the xnpipe_wakeup_proc calls
xnpipe_dequeue_wait and this way it is removed forever from the
waiters-queue.
When I remove the "else"-instruction in xnpipe_poll so that
xnpipe_wakeup_proc is called un-conditionally, then it works as expected
... however I have no idea if this patch is correct.  So please comment.
=20
FYI:
URL: http://svn.gna.org/svn/xenomai/trunk
Repository Root: http://svn.gna.org/svn/xenomai
Repository UUID: c6d672ea-8702-0410-b560-f74c916a59fe
Revision: 4047

=20
Best regards,
Filip
=20
=20
=20
=20

------_=_NextPart_001_01C8F2EE.A11B3B96
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.6000.16674" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D057020209-31072008>Hi,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D057020209-31072008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D057020209-31072008>I am =
transferring=20
data from the Xenomai domain to the 2nd domain with the xenomai =
pipe.&nbsp; In=20
the 2nd domain I am using the epoll interface to wait for the arrival of =
new=20
data.&nbsp; The first time that data are written in the pipe at the =
Xenomai=20
side, the 2nd domain receives the EPOLLIN (an that's OK).&nbsp; But the =
2nd time=20
data are written in the pipe at the Xenomai side, the 2nd domain is NOT=20
receiving EPOLLIN and therefore dies forever.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D057020209-31072008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D057020209-31072008>I am =
not familiar at=20
all with the Xenomai internals, but I tried to gather some =
information:&nbsp;it=20
look like&nbsp;</SPAN></FONT><FONT face=3DArial size=3D2><SPAN=20
class=3D057020209-31072008>when the first characters are written at the =
Xenomai=20
side, the xnpipe_wakeup_proc calls xnpipe_dequeue_wait and this way it =
is=20
removed forever from the waiters-queue.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D057020209-31072008>When I =
remove the=20
"else"-instruction in xnpipe_poll so that xnpipe_wakeup_proc is called=20
un-conditionally, then it works as expected ... however I have no idea =
if this=20
patch is correct.&nbsp; So please comment.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D057020209-31072008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D057020209-31072008>FYI:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D057020209-31072008>URL: =
<A=20
href=3D"http://svn.gna.org/svn/xenomai/trunk">http://svn.gna.org/svn/xeno=
mai/trunk</A><BR>Repository=20
Root: <A=20
href=3D"http://svn.gna.org/svn/xenomai">http://svn.gna.org/svn/xenomai</A=
><BR>Repository=20
UUID: c6d672ea-8702-0410-b560-f74c916a59fe<BR>Revision:=20
4047<BR></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D057020209-31072008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D057020209-31072008>Best=20
regards,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D057020209-31072008>Filip</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D057020209-31072008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D057020209-31072008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D057020209-31072008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D057020209-31072008></SPAN></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C8F2EE.A11B3B96--

