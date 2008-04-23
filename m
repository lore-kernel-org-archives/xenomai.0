Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8A54D.D3B8E862"
Date: Wed, 23 Apr 2008 10:25:06 -0400
Message-ID: <51B669A8A7D2914E9AB2B3F40AC6553E646F17@domain.hid>
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F13@domain.hid><18446.32522.986935.299094@domain.hid><51B669A8A7D2914E9AB2B3F40AC6553E646F15@domain.hid>
	<2ff1a98a0804230658w57d54addu438948a91faed1d6@domain.hid>
From: "Karch, Joshua" <jkarch@domain.hid>
Subject: Re: [Xenomai-help] Xenomai serial port c++ code and / or
	xeno--(xenomm-0.0.1) install problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8A54D.D3B8E862
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi Gilles,

>From what you're saying it appears a task is necessary to read a byte in =
a loop.  That method works.  The issue is, I want to be able to issue a =
read command to get a byte on demand from the calling thread.

With the /dev/ttyS0 driver, I used to be able to read a byte after using =
select statement without polling: My old code did the following:
=20
realserial *serial =3D new realserial();
serial->startup("serialportdevice",115200);

then in a pthreaded loop I request a read

int count=3D serial->readbyte();
    then I access the buffer if count>0;
char inchar=3Dserial->getreadbyte();
    process inchar
    loop again.

I split read byte and get-read byte into two parts in order to check for =
1 second time-outs for data.

Is it possible to do this using the rtser0 driver?  If I have to use a =
task,
can I make the task run for only one iteration of the loop, then suspend =
it to process the byte,=20
and then reactivate it againwhen another byte is needed?

Sincerely,

Joshua Karch





-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: Wed 4/23/2008 9:58 AM
To: Karch, Joshua
Cc: xenomai-help
Subject: Re: [Xenomai-help] Xenomai serial port c++ code and / or =
xeno--(xenomm-0.0.1) install problem
=20
On Wed, Apr 23, 2008 at 3:47 PM, Karch, Joshua <jkarch@domain.hid> =
wrote:
>
>
>
>
> Gilles,

Please keep sending copies to the mailing list, other might be
interested by your questions.

>
>  thank you for responding to my query.  What would be the right method =
for
> reading byte-at-a-time using the Xenomai drivers?

I do not pretend to know a "right" method. However, what looks simpler
is to call rt_dev_read in a loop.

> Do I even need an RT task to read from the serial driver?

Yes, if the task needs to be suspended (because there is no byte ready
yet), it has to be a real-time task.

Regards.

--=20
 Gilles


------_=_NextPart_001_01C8A54D.D3B8E862
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7651.59">
<TITLE>RE: [Xenomai-help] Xenomai serial port c++ code and / or =
xeno--(xenomm-0.0.1) install problem</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>Hi Gilles,<BR>
<BR>
>From what you're saying it appears a task is necessary to read a byte in =
a loop.&nbsp; That method works.&nbsp; The issue is, I want to be able =
to issue a read command to get a byte on demand from the calling =
thread.<BR>
<BR>
With the /dev/ttyS0 driver, I used to be able to read a byte after using =
select statement without polling: My old code did the following:<BR>
<BR>
realserial *serial =3D new realserial();<BR>
serial-&gt;startup(&quot;serialportdevice&quot;,115200);<BR>
<BR>
then in a pthreaded loop I request a read<BR>
<BR>
int count=3D serial-&gt;readbyte();<BR>
&nbsp;&nbsp;&nbsp; then I access the buffer if count&gt;0;<BR>
char inchar=3Dserial-&gt;getreadbyte();<BR>
&nbsp;&nbsp;&nbsp; process inchar<BR>
&nbsp;&nbsp;&nbsp; loop again.<BR>
<BR>
I split read byte and get-read byte into two parts in order to check for =
1 second time-outs for data.<BR>
<BR>
Is it possible to do this using the rtser0 driver?&nbsp; If I have to =
use a task,<BR>
can I make the task run for only one iteration of the loop, then suspend =
it to process the byte,<BR>
and then reactivate it againwhen another byte is needed?<BR>
<BR>
Sincerely,<BR>
<BR>
Joshua Karch<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Gilles Chanteperdrix [<A =
HREF=3D"mailto:gilles.chanteperdrix@xenomai.org">mailto:gilles.chanteperdri=
x@domain.hid</A>]<BR>
Sent: Wed 4/23/2008 9:58 AM<BR>
To: Karch, Joshua<BR>
Cc: xenomai-help<BR>
Subject: Re: [Xenomai-help] Xenomai serial port c++ code and / or =
xeno--(xenomm-0.0.1) install problem<BR>
<BR>
On Wed, Apr 23, 2008 at 3:47 PM, Karch, Joshua =
&lt;jkarch@domain.hid&gt; wrote:<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt; Gilles,<BR>
<BR>
Please keep sending copies to the mailing list, other might be<BR>
interested by your questions.<BR>
<BR>
&gt;<BR>
&gt;&nbsp; thank you for responding to my query.&nbsp; What would be the =
right method for<BR>
&gt; reading byte-at-a-time using the Xenomai drivers?<BR>
<BR>
I do not pretend to know a &quot;right&quot; method. However, what looks =
simpler<BR>
is to call rt_dev_read in a loop.<BR>
<BR>
&gt; Do I even need an RT task to read from the serial driver?<BR>
<BR>
Yes, if the task needs to be suspended (because there is no byte =
ready<BR>
yet), it has to be a real-time task.<BR>
<BR>
Regards.<BR>
<BR>
--<BR>
&nbsp;Gilles<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8A54D.D3B8E862--

