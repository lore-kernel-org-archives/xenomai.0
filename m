Message-Id: <s5df14b9.092@domain.hid>
Date: Fri, 23 Feb 2007 16:23:17 +0100
From: "Nicolas BLANCHARD" <n.blanchard@domain.hid>
Subject: Re: [Xenomai-help] error after timeout on serial port
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="=__Part012596F5.1__="
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nathan.Lauener@domain.hid
Cc: xenomai@xenomai.org

--=__Part012596F5.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



>>>> Jan Kiszka <jan.kiszka@domain.hid> 23.02 15:51 >>>
>Lauener Nathan wrote:
>> Hi,
>> 
>> I am polling on a serial port during an init sequence of a
positioning
>> device. Every once in a while I get a return code indicating that a
>> timeout occured, code -110 (ETIMEDOUT). 
 
In the struct rtser_config you have the event_timeout parameter that
cause 
ETIMEDOUT (if it's different than RTSER_DEF_TIMEOUT).
Have a look on rt_dev_ioctl(uiFd, RTSER_RTIOC_WAIT_EVENT, &rx_event ).
 
>After a timeout occured I can't
>> read the port anymore. Whenever I call rt_dev_read() again the
function
>> returns the error code -14 (EFAULT). Is there a flag I must clear to
get
>> the port operatioanl again?
 
Is your device correctly open (file descriptor>=0) ?

>
>I /tend/ to say it's an application bug, because we are using the
driver
>heavily, and our sluggish devices often cause timeouts during setup.
>Some colleague should have already slapped me otherwise. :)
>
>Are you sure that a valid buffer and a valid size is passed to
>rt_dev_read after the timeout (because those should be the reason for
>EFAULT)? If yes, maybe you can post a simple demo for the effect.
>
>Jan
 
Blanchard nicolas

--=__Part012596F5.1__=
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Description: HTML

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Diso-8859-1"=
>
<META content=3D"MSHTML 6.00.2900.2180" name=3DGENERATOR></HEAD>
<BODY style=3D"MARGIN: 4px 4px 1px; FONT: 10pt Tahoma"><BR><BR>&gt;&gt;&gt;=
&gt;=20
Jan Kiszka &lt;jan.kiszka@domain.hid&gt; 23.02 15:51 &gt;&gt;&gt;<BR>
<DIV>&gt;Lauener Nathan wrote:<BR>&gt;&gt; Hi,<BR>&gt;&gt; <BR>&gt;&gt; I =
am=20
polling on a serial port during an init sequence of a positioning<BR>&gt;&g=
t;=20
device. Every once in a while I get a return code indicating that =
a<BR>&gt;&gt;=20
timeout occured, code -110 (ETIMEDOUT). </DIV>
<DIV>&nbsp;</DIV>
<DIV>In the struct rtser_config you have the event_timeout parameter that =
cause=20
</DIV>
<DIV>ETIMEDOUT (if it's different than RTSER_DEF_TIMEOUT).</DIV>
<DIV>Have a look on rt_dev_ioctl(uiFd, RTSER_RTIOC_WAIT_EVENT, &amp;rx_even=
t=20
).</DIV>
<DIV>&nbsp;</DIV>
<DIV>&gt;After a timeout occured I can't<BR>&gt;&gt; read the port =
anymore.=20
Whenever I call rt_dev_read() again the function<BR>&gt;&gt; returns the =
error=20
code -14 (EFAULT). Is there a flag I must clear to get<BR>&gt;&gt; the =
port=20
operatioanl again?</DIV>
<DIV>&nbsp;</DIV>
<DIV>Is your device correctly open (file descriptor&gt;=3D0) ?</DIV>
<DIV><BR>&gt;<BR>&gt;I /tend/ to say it's an application bug, because we =
are=20
using the driver<BR>&gt;heavily, and our sluggish devices often cause =
timeouts=20
during setup.<BR>&gt;Some colleague should have already slapped me =
otherwise.=20
:)<BR>&gt;<BR>&gt;Are you sure that a valid buffer and a valid size is =
passed=20
to<BR>&gt;rt_dev_read after the timeout (because those should be the =
reason=20
for<BR>&gt;EFAULT)? If yes, maybe you can post a simple demo for the=20
effect.<BR>&gt;<BR>&gt;Jan</DIV>
<DIV>&nbsp;</DIV>
<DIV>Blanchard nicolas</DIV></BODY></HTML>

--=__Part012596F5.1__=--

