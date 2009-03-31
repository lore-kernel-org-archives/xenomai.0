MIME-Version: 1.0
In-Reply-To: <37f89760903310314j4dc92dacnfadff82c2a3a3244@domain.hid>
References: <37f89760903310217o29fe3435j286d5fa10dd6aa82@domain.hid>
	<49D1E4CA.3070102@domain.hid>
	<37f89760903310314j4dc92dacnfadff82c2a3a3244@domain.hid>
Date: Tue, 31 Mar 2009 12:59:34 +0200
Message-ID: <37f89760903310359u438293feyc78802613fcaa3f@domain.hid>
From: Marcel Soulot <msoulot@domain.hid>
Content-Type: multipart/alternative; boundary=001636458d3020ffbb0466681838
Subject: Re: [Xenomai-help] Test xen_16500A.ko on different serial port
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

--001636458d3020ffbb0466681838
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi sorry,

I was not very explicit in my last mail.

I try to test with the code from
http://www.captain.at/xenomai-serial-port-example.php

but i got an error: "can't open rtser6" because i try to communicate with
the port "ttyS6"

Do I load something related with the RTDM or something else ? I'm a bit
confused.

thanks,
Marcel.


2009/3/31 Marcel Soulot <msoulot@domain.hid>

> Hi,
>
> thanks for the answer.
>
> now, the command insmod ./xeno_16550.ko io=0x3f8 irq=4 is accepted.
> My question is: does the xeno_16550A.ko driver has replaced the 16550A and
> I able to use the serial com as usual ?
>
> Because I try to communication but it doesn't work.
>
> thanks,
> Marcel.
>
>
> 2009/3/31 Sebastian Smolorz <smolorz@domain.hid>
>
> Marcel Soulot wrote:
>>
>>> Hi
>>>
>>> I start with xenomai so I patch the kernel 2.6.26.7 with the version
>>> 2.4.6.
>>>
>>> So I try to test the xeno_16550A.ko driver generated instead of the
>>> standard
>>> 16550A on serial port ttyS0 ioaddr=0x3f8 irq=4 (standard one) and also on
>>> serial port in PCI card ttyS6 ioaddr=0xe0000400 irq=10.
>>>
>>> I used the following command to substitute the 16550A driver used by the
>>> xeno_16550A.ko:
>>>
>>>  setserial /dev/ttyS0 uart none
>>>> insmod ./xeno_16550.ko ioaddr=0x3f8 irq=4
>>>>
>>>
>>> I got the error message :
>>>
>>> xeno_16550A: Unkonwn parameter 'ioaddr'
>>>
>>
>> You may try "io="
>>
>> --
>> Sebastian
>>
>
>

--001636458d3020ffbb0466681838
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi sorry, <br><br>I was not very explicit in my last mail.<br><br>I try to =
test with the code from <a href=3D"http://www.captain.at/xenomai-serial-por=
t-example.php">http://www.captain.at/xenomai-serial-port-example.php</a><br=
>
<br>but i got an error: &quot;can&#39;t open rtser6&quot; because i try to =
communicate with the port &quot;ttyS6&quot;<br><br>Do I load something rela=
ted with the RTDM or something else ? I&#39;m a bit confused.<br><br>thanks=
,<br>
Marcel.<br><br><br><div class=3D"gmail_quote">2009/3/31 Marcel Soulot <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:msoulot@domain.hid">msoulot@domain.hid</a>=
&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px =
solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi,<br><br>thanks for the answer.<br><br>now, the command insmod ./xeno_165=
50.ko io=3D0x3f8 irq=3D4 is accepted.<br>My question is: does the xeno_1655=
0A.ko driver has replaced the 16550A and I able to use the serial com as us=
ual ?<br>

<br>Because I try to communication but it doesn&#39;t work.<br><br>thanks,<=
br>Marcel. <br>

<br><br><div class=3D"gmail_quote">2009/3/31 Sebastian Smolorz <span dir=3D=
"ltr">&lt;<a href=3D"mailto:smolorz@domain.hid" target=3D"_blank">=
smolorz@domain.hid</a>&gt;</span><div><div></div><div class=3D"h5"=
><br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div>Marcel Soulot wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi<br>
<br>
I start with xenomai so I patch the kernel 2.6.26.7 with the version 2.4.6.=
<br>
<br>
So I try to test the xeno_16550A.ko driver generated instead of the standar=
d<br>
16550A on serial port ttyS0 ioaddr=3D0x3f8 irq=3D4 (standard one) and also =
on<br>
serial port in PCI card ttyS6 ioaddr=3D0xe0000400 irq=3D10.<br>
<br>
I used the following command to substitute the 16550A driver used by the<br=
>
xeno_16550A.ko:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
setserial /dev/ttyS0 uart none<br>
insmod ./xeno_16550.ko ioaddr=3D0x3f8 irq=3D4<br>
</blockquote>
<br>
I got the error message :<br>
<br>
xeno_16550A: Unkonwn parameter &#39;ioaddr&#39;<br>
</blockquote>
<br></div>
You may try &quot;io=3D&quot;<br>
<br>
-- <br><font color=3D"#888888">
Sebastian<br>
</font></blockquote></div></div></div><br>
</blockquote></div><br>

--001636458d3020ffbb0466681838--

