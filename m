Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8EE44.3AB87A8C"
Date: Fri, 25 Jul 2008 12:50:18 +0200
Message-ID: <406CC9939904F143B9D42CEEA3E56E563ABB19@domain.hid>
From: "Filip Van Rillaer" <Filip.VanRillaer@domain.hid>
Subject: [Xenomai-help] V2.4.4 on blackfin
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

------_=_NextPart_001_01C8EE44.3AB87A8C
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

rt_event_wait seems not to work properly if one specifies a timeout :
the functioncall returns after the specified of time, but it returns 0,
instead of -ETIMEDOUT.
Below is an example that demonstrates the problem.

In version 2.4.0 it worked fine.
Probably the problem is not specific for the rt_event_wait function, but
in general the passing of return-values in userspace.

This are the version I am currently using:

URL: http://svn.gna.org/svn/xenomai/trunk
Repository Root: http://svn.gna.org/svn/xenomai
Repository UUID: c6d672ea-8702-0410-b560-f74c916a59fe
Revision: 4047

URL:
svn://firewall-sources.blackfin.uclinux.org:80/svn/uclinux-dist/trunk
Repository Root:
svn://firewall-sources.blackfin.uclinux.org:80/svn/uclinux-dist
Repository UUID: 3e2a5524-39e8-4cb9-84a9-c49da69cba3a
Revision: 6418

URL:
svn://firewall-sources.blackfin.uclinux.org:80/svn/linux-kernel/tags/200
8R1-RC8
Repository Root:
svn://firewall-sources.blackfin.uclinux.org:80/svn/linux-kernel
Repository UUID: 526b6c2d-f592-4532-a319-5dd88ccb003d
Revision: 4963


How can this be solved/avoided?

Best regards,

Filip

#include <stdio.h>
#include <sys/mman.h>
#include <native/task.h>
#include <native/event.h>

#define EVENT_INIT        0x0           /* No flags present at init */
#define EVENT_MODE        EV_PRIO       /* Tasks will wait by priority
order */
#define EVENT_WAIT_MASK   (0x1|0x2|0x4) /* List of monitored events */


RT_EVENT ev_desc;
int main(int argc, char **argv)
{
  RT_TASK task;
  unsigned long mask_ret;
  int err;
  RTIME timeout=3D13000000000LL; /* 13 sec */

  mlockall(MCL_CURRENT|MCL_FUTURE);
  rt_task_shadow(&task, "Task", 10, 0);

  err =3D rt_event_create(&ev_desc,"MyEventFlagGroup",EVENT_INIT,
EVENT_MODE);
  if (err<0) {
    fprintf(stderr,"rt_event_create failed\n");
    return -1;
  }
  else {
    fprintf(stderr,"rt_event_create ok\n");
  }

  err =3D rt_event_wait(&ev_desc, EVENT_WAIT_MASK, &mask_ret, EV_ANY
,timeout);
  if (err<0) {
    switch (err)  {
      case -ETIMEDOUT: fprintf(stderr,"rt_event_wait returned -ETIMEDOUT
(and that's OK)\n"); break;
      default:  fprintf(stderr,"rt_event_wait returned %d (which is
wrong)\n",err); return -2;
    }
  }
  else {
    fprintf(stderr,"rt_event_wait returned 0, but we expected
-ETIMEDOUT\n");
    return -3;
  }
  return 0;
}

=20


------_=_NextPart_001_01C8EE44.3AB87A8C
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.6000.16674" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D772274310-25072008>
<P><FONT face=3DArial size=3D2>Hello,</FONT></P>
<P><FONT face=3DArial size=3D2>rt_event_wait seems not to work =
properly&nbsp;if one=20
specifies a timeout : the functioncall returns after the specified of =
time, but=20
it returns 0, instead of -ETIMEDOUT.<BR></FONT><FONT face=3DArial =
size=3D2>Below is=20
an example that demonstrates the problem.</FONT></P>
<P><SPAN class=3D772274310-25072008><FONT face=3DArial size=3D2>In =
version 2.4.0 it=20
worked fine.<BR>Probably the problem is not specific for the =
rt_event_wait=20
function, but in general the passing of return-values&nbsp;in=20
userspace.</FONT></SPAN><SPAN class=3D772274310-25072008><FONT =
face=3DArial=20
size=3D2><BR></FONT></SPAN><SPAN class=3D772274310-25072008><FONT =
face=3DArial=20
size=3D2><BR>This are the version I am currently =
using:</FONT></SPAN></P>
<P><SPAN class=3D772274310-25072008><FONT face=3DArial size=3D2>URL: <A=20
href=3D"http://svn.gna.org/svn/xenomai/trunk">http://svn.gna.org/svn/xeno=
mai/trunk</A><BR>Repository=20
Root: <A=20
href=3D"http://svn.gna.org/svn/xenomai">http://svn.gna.org/svn/xenomai</A=
><BR>Repository=20
UUID: c6d672ea-8702-0410-b560-f74c916a59fe<BR>Revision: =
4047</FONT></SPAN></P>
<P><SPAN class=3D772274310-25072008><FONT face=3DArial size=3D2>URL:=20
svn://firewall-sources.blackfin.uclinux.org:80/svn/uclinux-dist/trunk<BR>=
Repository=20
Root:=20
svn://firewall-sources.blackfin.uclinux.org:80/svn/uclinux-dist<BR>Reposi=
tory=20
UUID: 3e2a5524-39e8-4cb9-84a9-c49da69cba3a<BR>Revision: 6418<BR><BR>URL: =

svn://firewall-sources.blackfin.uclinux.org:80/svn/linux-kernel/tags/2008=
R1-RC8<BR>Repository=20
Root:=20
svn://firewall-sources.blackfin.uclinux.org:80/svn/linux-kernel<BR>Reposi=
tory=20
UUID: 526b6c2d-f592-4532-a319-5dd88ccb003d<BR>Revision:=20
4963<BR></FONT></SPAN></P>
<P><SPAN class=3D772274310-25072008><FONT face=3DArial size=3D2>How can =
this be=20
solved/avoided?</P></FONT></SPAN>
<P><FONT face=3DArial size=3D2>Best regards,</FONT></P>
<P><FONT face=3DArial size=3D2>Filip</FONT></P>
<P><FONT face=3DArial size=3D2>#include &lt;stdio.h&gt;<BR>#include=20
&lt;sys/mman.h&gt;<BR>#include &lt;native/task.h&gt;<BR>#include=20
&lt;native/event.h&gt;</FONT></P>
<P><FONT face=3DArial size=3D2>#define=20
EVENT_INIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0x0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* No =
flags=20
present at init */<BR>#define=20
EVENT_MODE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
EV_PRIO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Tasks will wait by =
priority order=20
*/<BR>#define EVENT_WAIT_MASK&nbsp;&nbsp; (0x1|0x2|0x4) /* List of =
monitored=20
events */</FONT></P>
<P><BR><FONT face=3DArial size=3D2>RT_EVENT ev_desc;<BR>int main(int =
argc, char=20
**argv)<BR>{<BR>&nbsp; RT_TASK task;<BR>&nbsp; unsigned long =
mask_ret;<BR>&nbsp;=20
int err;<BR>&nbsp; RTIME timeout=3D13000000000LL; /* 13 sec =
*/</FONT></P>
<P><FONT face=3DArial size=3D2>&nbsp; =
mlockall(MCL_CURRENT|MCL_FUTURE);<BR>&nbsp;=20
rt_task_shadow(&amp;task, "Task", 10, 0);</FONT></P>
<P><FONT face=3DArial size=3D2>&nbsp; err =3D=20
rt_event_create(&amp;ev_desc,"MyEventFlagGroup",EVENT_INIT,=20
EVENT_MODE);<BR>&nbsp; if (err&lt;0) {<BR>&nbsp;&nbsp;&nbsp;=20
fprintf(stderr,"rt_event_create failed\n");<BR>&nbsp;&nbsp;&nbsp; return =

-1;<BR>&nbsp; }<BR>&nbsp; else {<BR>&nbsp;&nbsp;&nbsp;=20
fprintf(stderr,"rt_event_create ok\n");<BR>&nbsp; }</FONT></P>
<P><FONT face=3DArial size=3D2>&nbsp; err =3D =
rt_event_wait(&amp;ev_desc,=20
EVENT_WAIT_MASK, &amp;mask_ret, EV_ANY ,timeout);<BR>&nbsp; if =
(err&lt;0)=20
{<BR>&nbsp;&nbsp;&nbsp; switch (err)&nbsp; =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
case -ETIMEDOUT: fprintf(stderr,"rt_event_wait returned -ETIMEDOUT (and =
that's=20
OK)\n"); break;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:&nbsp;=20
fprintf(stderr,"rt_event_wait returned %d (which is wrong)\n",err); =
return=20
-2;<BR>&nbsp;&nbsp;&nbsp; }<BR>&nbsp; }<BR>&nbsp; else =
{<BR>&nbsp;&nbsp;&nbsp;=20
fprintf(stderr,"rt_event_wait returned 0, but we expected=20
-ETIMEDOUT\n");<BR>&nbsp;&nbsp;&nbsp; return -3;<BR>&nbsp; }<BR>&nbsp; =
return=20
0;<BR>}</FONT></P>
<P></SPAN>&nbsp;</P></DIV></BODY></HTML>

------_=_NextPart_001_01C8EE44.3AB87A8C--

