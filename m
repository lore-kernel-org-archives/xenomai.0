From: "Terry Fryar" <terry.fryar@domain.hid>
Date: Thu, 29 Dec 2011 14:39:40 -0600
Message-ID: <32A50F80EA7447F2B43C6A65BED53790@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0039_01CCC637.B43365F0"
Subject: [Xenomai-help] Use of condition vars
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

This is a multi-part message in MIME format.

------=_NextPart_000_0039_01CCC637.B43365F0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Using Xenomai 2.6.0, I have a question regarding the use of condition
variables.  I think I understand why the mutex is required, but how to use
it is a bit of a mystery?
 
- To call "rt_cond_signal()", do you have to have the mutex acquired??
 
- I assume to call "rt_cond_wait()", you are required to have the mutex
acquired, yes??
 
So, the pseudocode would be:
 
Task1:
.
.
rt_cond_signal()
.
.
 
Task2, Task3, ....TaskN
.
.
rt_mutex_acquire()
while (rt_cond_wait() != 0)
// got it, do code that accesses the signaled var (mutex protected)
rt_mutex_release()
.
.
.
 
 
Is that it??

------=_NextPart_000_0039_01CCC637.B43365F0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dus-ascii" =
http-equiv=3DContent-Type>
<META name=3DGENERATOR content=3D"MSHTML 8.00.7601.17699"></HEAD>
<BODY>
<DIV><FONT size=3D2 face=3DArial><SPAN class=3D897435119-29122011>Using =
Xenomai 2.6.0,=20
I have a question regarding the use of condition variables.&nbsp; I =
think I=20
understand why the mutex is required, but how to use it is a bit of a=20
mystery?</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D897435119-29122011></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN class=3D897435119-29122011>- To =
call=20
"rt_cond_signal()", do you have to have the mutex =
acquired??</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D897435119-29122011></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN class=3D897435119-29122011>- I =
assume to call=20
"rt_cond_wait()", you are required to have the mutex acquired,=20
yes??</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D897435119-29122011></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN class=3D897435119-29122011>So, =
the pseudocode=20
would be:</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D897435119-29122011></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D897435119-29122011>Task1:</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D897435119-29122011>.</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D897435119-29122011>.</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D897435119-29122011>rt_cond_signal()</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D897435119-29122011>.</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D897435119-29122011>.</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D897435119-29122011></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN class=3D897435119-29122011>Task2, =
Task3,=20
....TaskN</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D897435119-29122011>.</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D897435119-29122011>.</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D897435119-29122011>rt_mutex_acquire()</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN class=3D897435119-29122011>while=20
(rt_cond_wait() !=3D 0)</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN class=3D897435119-29122011>// got =
it, do code=20
that accesses the signaled var (mutex protected)</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D897435119-29122011>rt_mutex_release()</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D897435119-29122011>.</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D897435119-29122011>.</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D897435119-29122011>.</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D897435119-29122011><FONT size=3D2 face=3DArial>Is =
that=20
it??</FONT></SPAN></DIV></BODY></HTML>

------=_NextPart_000_0039_01CCC637.B43365F0--


