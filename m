From: "Terry Fryar" <terry.fryar@domain.hid>
Date: Thu, 5 Jan 2012 16:12:15 -0600
Message-ID: <F71AC02934794B77BC6691D3173A980B@TerryHP>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000C_01CCCBC4.CC0DB260"
Subject: [Xenomai-help] RTDM and spi
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

------=_NextPart_000_000C_01CCCBC4.CC0DB260
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Using the RTDM api with Xen 2.6 to develop a linux driver. =20
=20
Basically have an ISR registered using rtdm_irq_request() that is =
triggered
from a gpio pin.  ISR works fine.  Inside ISR, the only thing done is a
rtdm_event_signal() on an event.
=20
Then, I have a task created using rtdm_task_init() that is waiting on =
the
event using rtdm_event_timedwait().
=20
So far, so good...all works.  But, in the task I am making an SPI call =
after
the event is signaled using spi_message_add_tail() and spi_sync() and =
that's
where I get this:
=20
BUG: sleeping function called from invalid context at kernel/mutex.c:278
[   98.449178] in_atomic(): 1, irqs_disabled(): 0, pid: -555875760, =
name:
v=FF=FF=FD=FF=BF=B7=BD=FF=A7=FF=FF=F5>=FF=FF=FDw=BF@=DE=DEP=DE=DE
[   98.458686] INFO: lockdep is turned off.
[   98.462811] [<c00572ac>] (unwind_backtrace+0x0/0xe0) from =
[<c04639bc>]
(mutex_lock_nested+0x24/0x384)
[   98.472501] [<c04639bc>] (mutex_lock_nested+0x24/0x384) from =
[<c033ca48>]
(__spi_sync+0x88/0xd8)
[   98.481730] [<c033ca48>] (__spi_sync+0x88/0xd8) from [<bf007180>]
(irqdrv_task+0x44/0xd4 [irqdrv])
[   98.491149] [<bf007180>] (irqdrv_task+0x44/0xd4 [irqdrv]) from
[<c00e93d0>] (xnarch_thread_trampoline+0x20/0x2c)
[   98.501845] [<c00e93d0>] (xnarch_thread_trampoline+0x20/0x2c) from
[<c00e5adc>] (__xnpod_schedule+0x5cc/0xa54)
[   98.512355] [<c00e5adc>] (__xnpod_schedule+0x5cc/0xa54) from =
[<fff7febf>]
(0xfff7febf)
[   98.520674] Xenomai: suspending kernel thread bf008180 ('irqdrvTask') =
at
0xc00a92f8 after exception #0x0

I have tried this inside a kthread and it works fine.  I can also try =
the
spi stuff without being triggered by an IRQ, and I get the same error.  =
I
know this is something simple???

------=_NextPart_000_000C_01CCCBC4.CC0DB260
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Diso-8859-1" =
http-equiv=3DContent-Type>
<META name=3DGENERATOR content=3D"MSHTML 8.00.7601.17699"></HEAD>
<BODY>
<DIV><SPAN class=3D963211418-05012012><FONT size=3D2 face=3DArial>Using =
the RTDM api=20
with Xen 2.6 to develop a linux driver.&nbsp; </FONT></SPAN></DIV>
<DIV><SPAN class=3D963211418-05012012><FONT size=3D2=20
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D963211418-05012012><FONT size=3D2 =
face=3DArial>Basically have an=20
ISR registered using <B><FONT color=3D#642880 size=3D2><FONT =
color=3D#642880=20
size=3D2>rtdm_irq_request</B></FONT></FONT><FONT size=3D2>()</FONT><SPAN =

class=3D963211418-05012012><FONT size=3D2 face=3DArial> that is =
triggered from a gpio=20
pin.&nbsp; ISR works fine.&nbsp; Inside ISR, the only thing done is a =
<B><FONT=20
color=3D#642880 size=3D2><FONT color=3D#642880=20
size=3D2>rtdm_event_signal</B></FONT></FONT><FONT size=3D2>() on an=20
event.</FONT></FONT></SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D963211418-05012012><FONT size=3D2 face=3DArial><SPAN=20
class=3D963211418-05012012></SPAN></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D963211418-05012012><FONT size=3D2 face=3DArial><SPAN=20
class=3D963211418-05012012>Then, I have a task created using <B><FONT=20
color=3D#642880 size=3D2><FONT color=3D#642880=20
size=3D2>rtdm_task_init</B></FONT></FONT><FONT size=3D2>() that is =
waiting on the=20
event using <B><FONT color=3D#642880 size=3D2><FONT color=3D#642880=20
size=3D2>rtdm_event_timedwait</B></FONT></FONT><FONT=20
size=3D2>().</FONT></FONT></SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D963211418-05012012><FONT size=3D2 face=3DArial><SPAN=20
class=3D963211418-05012012></SPAN></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D963211418-05012012><FONT size=3D2 face=3DArial><SPAN=20
class=3D963211418-05012012>So far, so good...all works.&nbsp; But, in =
the task I=20
am making an SPI call after the event is signaled using =
spi_message_add_tail()=20
and spi_sync() and that's where I get this:</SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D963211418-05012012><FONT size=3D2=20
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D963211418-05012012><FONT size=3D2 face=3DArial>BUG: =
sleeping=20
function called from invalid context at =
kernel/mutex.c:278<BR>[&nbsp;&nbsp;=20
98.449178] in_atomic(): 1, irqs_disabled(): 0, pid: -555875760, name:=20
v=FF=FF=FD=FF=BF=B7=BD=FF=A7=FF=FF=F5&gt;=FF=FF=FDw=BF@=DE=DEP=DE=DE<BR>[=
&nbsp;&nbsp; 98.458686] INFO: lockdep is turned=20
off.<BR>[&nbsp;&nbsp; 98.462811] [&lt;c00572ac&gt;] =
(unwind_backtrace+0x0/0xe0)=20
from [&lt;c04639bc&gt;] (mutex_lock_nested+0x24/0x384)<BR>[&nbsp;&nbsp;=20
98.472501] [&lt;c04639bc&gt;] (mutex_lock_nested+0x24/0x384) from=20
[&lt;c033ca48&gt;] (__spi_sync+0x88/0xd8)<BR>[&nbsp;&nbsp; 98.481730]=20
[&lt;c033ca48&gt;] (__spi_sync+0x88/0xd8) from [&lt;bf007180&gt;]=20
(irqdrv_task+0x44/0xd4 [irqdrv])<BR>[&nbsp;&nbsp; 98.491149] =
[&lt;bf007180&gt;]=20
(irqdrv_task+0x44/0xd4 [irqdrv]) from [&lt;c00e93d0&gt;]=20
(xnarch_thread_trampoline+0x20/0x2c)<BR>[&nbsp;&nbsp; 98.501845]=20
[&lt;c00e93d0&gt;] (xnarch_thread_trampoline+0x20/0x2c) from =
[&lt;c00e5adc&gt;]=20
(__xnpod_schedule+0x5cc/0xa54)<BR>[&nbsp;&nbsp; 98.512355] =
[&lt;c00e5adc&gt;]=20
(__xnpod_schedule+0x5cc/0xa54) from [&lt;fff7febf&gt;]=20
(0xfff7febf)<BR>[&nbsp;&nbsp; 98.520674] Xenomai: suspending kernel =
thread=20
bf008180 ('irqdrvTask') at 0xc00a92f8 after exception=20
#0x0<BR></FONT></SPAN></DIV>
<DIV><SPAN class=3D963211418-05012012><FONT size=3D2 face=3DArial>I have =
tried this=20
inside a kthread and it works fine.&nbsp; I can also try the spi stuff =
without=20
being triggered by an IRQ, and I get the same error.&nbsp; I know this =
is=20
something simple???</DIV></FONT></SPAN></BODY></HTML>

------=_NextPart_000_000C_01CCCBC4.CC0DB260--


