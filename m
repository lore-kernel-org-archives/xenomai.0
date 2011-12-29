From: "Terry Fryar" <terry.fryar@domain.hid>
Date: Thu, 29 Dec 2011 15:43:41 -0600
Message-ID: <C3860BCA25804175ABD53E2F2B1A942A@TerryHP>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0049_01CCC640.A59E8DE0"
Subject: [Xenomai-help] Mode switches??
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

------=_NextPart_000_0049_01CCC640.A59E8DE0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Using 2.6.0, I am have trouble understanding the results of the
rt_task_info() call?
 
Have a very simple kernel module that fires off an ISR routine and a xenomai
task.  The IRQ is not firing for these tests, so it's not doing anything.
Here's the xenomai rt task created using rt_create_task():
 
void irqdrv_task(void *args)
{
    while (!irqdrv_terminated)
     {
          rt_task_sleep(10000000);
     }
}
 
So, in the driver "exit" code, right before I delete this task I do a
rt_task_info() and I see no context switches and very little exec time for
this task.  However, it's showing 1,000,000 mode switches in just 5 or 10
seconds of exec time??
 
The info.modeswitches is the number of times the task switches between
primary and secondary mode, yes??  Why in the world are there so many for a
small task doing nothing but call a xenomai function, and in a kernel driver
to boot!!
 
Am I missing something here....shouldn't mode switches be zero???  I'm not
calling any linux kernel functions...it shouldn't have switched ever??
 

------=_NextPart_000_0049_01CCC640.A59E8DE0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dus-ascii" =
http-equiv=3DContent-Type>
<META name=3DGENERATOR content=3D"MSHTML 8.00.7601.17699"></HEAD>
<BODY>
<DIV><SPAN class=3D481233521-29122011><FONT size=3D2 face=3DArial>Using =
2.6.0, I am=20
have trouble understanding the results of the rt_task_info()=20
call?</FONT></SPAN></DIV>
<DIV><SPAN class=3D481233521-29122011><FONT size=3D2=20
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D481233521-29122011><FONT size=3D2 face=3DArial>Have a =
very simple=20
kernel module that fires off an ISR routine and a xenomai task.&nbsp; =
The IRQ is=20
not firing for these tests, so it's not doing anything.&nbsp; Here's the =
xenomai=20
rt task created using rt_create_task():</FONT></SPAN></DIV>
<DIV><SPAN class=3D481233521-29122011><FONT size=3D2=20
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D481233521-29122011><FONT size=3D2 face=3DArial>void=20
irqdrv_task(void *args)<BR>{<BR>&nbsp;&nbsp;&nbsp; while=20
(!irqdrv_terminated)<BR>&nbsp;&nbsp;&nbsp;&nbsp;=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
rt_task_sleep(10000000);<BR>&nbsp;&nbsp;&nbsp;&nbsp; =
}<BR>}</FONT></SPAN></DIV>
<DIV><SPAN class=3D481233521-29122011><FONT size=3D2=20
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D481233521-29122011><FONT size=3D2 face=3DArial>So, in =
the driver=20
"exit" code, right before I delete this task I do a rt_task_info() and I =
see no=20
context switches and very little exec time for this task.&nbsp; However, =
it's=20
showing 1,000,000 mode switches in just 5 or 10 seconds of exec=20
time??</FONT></SPAN></DIV>
<DIV><SPAN class=3D481233521-29122011><FONT size=3D2=20
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D481233521-29122011><FONT size=3D2 face=3DArial>The=20
info.modeswitches is the number of times the task switches between =
primary and=20
secondary mode, yes??&nbsp; Why in the world are there so many for a =
small task=20
doing nothing but call a xenomai function, and in a kernel driver to=20
boot!!</FONT></SPAN></DIV>
<DIV><SPAN class=3D481233521-29122011><FONT size=3D2=20
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D481233521-29122011><FONT size=3D2 face=3DArial>Am I =
missing=20
something here....shouldn't mode switches be zero???&nbsp; I'm not =
calling any=20
linux kernel functions...it shouldn't have switched =
ever??</FONT></SPAN></DIV>
<DIV><FONT size=3D2 face=3DArial></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0049_01CCC640.A59E8DE0--


