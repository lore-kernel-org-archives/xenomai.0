MIME-Version: 1.0
In-Reply-To: <4F87036D.1050605@domain.hid>
References: <CAGq8jPhOy=v8Lccb+hddH9W_u8p-Ayi+XfEcFC+rHVzsSp-ghg@domain.hid>
	<CAGq8jPi4S4TTBy9dLYYnWuWQdX_awhXxu0C93okgFO5vWv_20A@mail.gmail.com>
	<4F75B5BF.8030401@domain.hid>
	<CAGq8jPgY6fTw0ufdj=pvc+Q1jrrQkYptSHTzFOQK=qSiJJU32Q@mail.gmail.com>
	<4F75C7D1.4020808@domain.hid>
	<CAGq8jPhqv16jgPQh631x8S2MmDhm1F4HtnrQA0xsGPe4bTo6eA@mail.gmail.com>
	<4F79D5EA.3010501@domain.hid>
	<CAGq8jPjq79CdBbNys1=ccV-CKSyNfG9nX-1L31Ar6WShuNE=HQ@mail.gmail.com>
	<4F7D7A43.4060502@domain.hid>
	<CAGq8jPhqRN0WTKHC1uJXbHyecX_tKOB6zFnDJ4=DbKtzU3mmcA@mail.gmail.com>
	<CAGq8jPgON96yy7_wOCSs83QwxVrfSsTn-fe1P+EBZ8-KLMfj0A@mail.gmail.com>
	<4F8592F3.6070907@domain.hid> <4F85B7BE.9080706@domain.hid>
	<4F85B869.2060102@domain.hid> <4F85D505.6080002@domain.hid>
	<CAGq8jPj4dNaukTMZXo6+C=UA-TfpP5h9FOU07FUTnX0TTDsqCA@mail.gmail.com>
	<4F8689BD.4050508@domain.hid>
	<CAGq8jPgV3aQrz6-Y0LqrjT1HA2udHG887o1EFd4bS5eFvp6gkw@domain.hid>
	<4F87036D.1050605@domain.hid>
Date: Wed, 25 Apr 2012 11:11:30 +0200
Message-ID: <CAGq8jPi17=r6=k0Zayfky-Z7_7gtopf=ManFBp+9_v0nGe301w@domain.hid>
From: Minh GIANG <giang.hminh@domain.hid>
Content-Type: multipart/alternative; boundary=20cf3040eb5cc49d5e04be7d416b
Subject: Re: [Xenomai-help] Cross-link.c ---RTSER_RTIOC_WAIT_EVENT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

--20cf3040eb5cc49d5e04be7d416b
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

hello,

Thank you for helping me solve my problem.

You recommend me to update to a more recent version. But I think the
xenomai version 2.6.0 is the lastest version over http://www.xenomai.org
 site.

By the way, i have a short question. When i make run cross-link program, i
don't understand why there is a leak memory. Even if, i try to remove all
parasite in while loop, but the leak memory is always constant. i think the
problem comes from rt_dev_write() or rt_dev_read() which don't release the
memory buffer. im wrong?


On Thu, Apr 12, 2012 at 6:31 PM, Wolfgang Grandegger <wg@domain.hid>wro=
te:

> On 04/12/2012 10:51 AM, Minh GIANG wrote:
> > Hello sir,
> >
> > Here is the message after doing your command:
> >
> > giang@domain.hid$
> > make XENO=3D/usr/xenomai/bin
> > --xeno-cflags is deprecated, use --skin=3Dname --cflags instead
> > --xeno-ldflags is deprecated, use --skin=3Dname --ldflags instead
> > gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall
> > -Werror-implicit-function-declaration -pipe -D__XENO__
> -L/usr/xenomai/lib
> > -lxenomai -lpthread -lrt  -lnative -lrtdm -Xlinker -rpath -Xlinker
>
> That's how the program should be comiled and linked.
>
> > /usr/xenomai/lib  cross-link.c   -o cross-link
> > cross-link.c: In function =91write_task_proc=92:
> > cross-link.c:167: warning: format =91%d=92 expects type =91int=92, but =
argument 2
> > has type =91ssize_t=92
> > cross-link.c:167: warning: format =91%d=92 expects type =91int=92, but =
argument 3
> > has type =91ssize_t=92
> > cross-link.c: In function =91read_task_proc=92:
> > cross-link.c:227: warning: format =91%d=92 expects type =91int=92, but =
argument 2
> > has type =91ssize_t=92
> > cross-link.c:227: warning: format =91%d=92 expects type =91int=92, but =
argument 3
> > has type =91ssize_t=92
> > giang@domain.hid$
> > ./cross-link
> > Xenomai: binding failed: Operation not permitted.
> > giang@domain.hid$
> su
> > Mot de passe :
> > root@domain.hid
> :/home/giang/Documents/xenomai-2.6.0/examples/rtdm/profiles/serial#
> > ./cross-link
> > main : write-file opened
> > main : write-config written
> > main : read-file opened
> > main : read-config written
> > main : write-task created
> > main : read-task created
> > main : starting write-task
> > main : starting read-task
> >  Nr |   write->irq    |    irq->read    |   write->read   |
> > -----------------------------------------------------------
> >   0 |          104495 |          617720 |          722215
> >   1 |          104649 |          617061 |          721710
> >   2 |          104360 |          617820 |          722180
> >   3 |          104906 |          617050 |          721956
> >   4 |          105794 |          617188 |          722982
> >   5 |          103504 |          618103 |          721607
> >   6 |          104643 |          617084 |          721727
> >   7 |          106633 |          617767 |          724400
> >
> > oh, it seems to work perfectly, i don't know why it works in this case
> when
> > i lauched it in the terminal linux, i copied exactly the program in
> Eclipse
> > C++ and it doesn't work. Ah the only thing i have changed (otherwise my
> > program don't compile in Eclipse), is
> >
> > static const struct rtser_config read_config =3D {
> > 0xFFFF,
> > 115200,
> > RTSER_DEF_PARITY,
> > RTSER_DEF_BITS,
> > RTSER_DEF_STOPB,
> > RTSER_DEF_HAND,
> > RTSER_DEF_FIFO_DEPTH,
> > RTSER_DEF_TIMEOUT,
> > RTSER_DEF_TIMEOUT,
> > 1000000000, /* 1 s */
> > RTSER_RX_TIMESTAMP_HISTORY,
> > RTSER_EVENT_RXPEND,
> > };
> >
> > static const struct rtser_config write_config =3D {
> > RTSER_SET_BAUD | RTSER_SET_TIMESTAMP_HISTORY,
> > 115200,
> > RTSER_DEF_TIMESTAMP_HISTORY,
> > /* the rest implicitely remains default */
> > };
> >
> > maybe, i don't compile with good parameters in Eclipse?
>
> Yes, that's your problem. And exactly to avoid such problems, Xenomai
> provides the script "xeno-config" to retrieve proper compiler and linker
> options.
>
> > my version Xenomai 2.6.0
>
> I also recommend to update to a more recent version.
>
> Wolfgang.
>

--20cf3040eb5cc49d5e04be7d416b
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_extra">hello,=A0</div><div class=3D"gmail_extra"><br></=
div><div class=3D"gmail_extra">Thank you for helping me solve my problem.</=
div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">You=A0r=
ecommend me to update to a more recent version.=A0But=A0I think the xenomai=
 version 2.6.0 is the lastest version over=A0<a href=3D"http://www.xenomai.=
org/">http://www.xenomai.org</a>=A0site.=A0</div>
<div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">By the way,=
 i have a short question. When i make run cross-link program, i don&#39;t u=
nderstand why there is a leak memory. Even if, i try to remove all parasite=
 in while loop, but the leak memory is always constant. i think the problem=
 comes from rt_dev_write() or rt_dev_read() which don&#39;t release the mem=
ory buffer. im wrong?</div>
<div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Thu, Apr 1=
2, 2012 at 6:31 PM, Wolfgang Grandegger <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:wg@domain.hid" target=3D"_blank">wg@domain.hid</a>&gt;</span> =
wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On 04/12/2012 10:51 AM, Mi=
nh GIANG wrote:<br>
&gt; Hello sir,<br>
&gt;<br>
&gt; Here is the message after doing your command:<br>
&gt;<br>
&gt; giang@domain.hid=
$<br>
&gt; make XENO=3D/usr/xenomai/bin<br>
&gt; --xeno-cflags is deprecated, use --skin=3Dname --cflags instead<br>
&gt; --xeno-ldflags is deprecated, use --skin=3Dname --ldflags instead<br>
&gt; gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall<br>
&gt; -Werror-implicit-function-declaration -pipe -D__XENO__ =A0 -L/usr/xeno=
mai/lib<br>
&gt; -lxenomai -lpthread -lrt =A0-lnative -lrtdm -Xlinker -rpath -Xlinker<b=
r>
<br>
</div>That&#39;s how the program should be comiled and linked.<br>
<div><div class=3D"h5"><br>
&gt; /usr/xenomai/lib =A0cross-link.c =A0 -o cross-link<br>
&gt; cross-link.c: In function =91write_task_proc=92:<br>
&gt; cross-link.c:167: warning: format =91%d=92 expects type =91int=92, but=
 argument 2<br>
&gt; has type =91ssize_t=92<br>
&gt; cross-link.c:167: warning: format =91%d=92 expects type =91int=92, but=
 argument 3<br>
&gt; has type =91ssize_t=92<br>
&gt; cross-link.c: In function =91read_task_proc=92:<br>
&gt; cross-link.c:227: warning: format =91%d=92 expects type =91int=92, but=
 argument 2<br>
&gt; has type =91ssize_t=92<br>
&gt; cross-link.c:227: warning: format =91%d=92 expects type =91int=92, but=
 argument 3<br>
&gt; has type =91ssize_t=92<br>
&gt; giang@domain.hid=
$<br>
&gt; ./cross-link<br>
&gt; Xenomai: binding failed: Operation not permitted.<br>
&gt; giang@domain.hid=
$ su<br>
&gt; Mot de passe :<br>
&gt; root@domain.hid=
es/serial#<br>
&gt; ./cross-link<br>
&gt; main : write-file opened<br>
&gt; main : write-config written<br>
&gt; main : read-file opened<br>
&gt; main : read-config written<br>
&gt; main : write-task created<br>
&gt; main : read-task created<br>
&gt; main : starting write-task<br>
&gt; main : starting read-task<br>
&gt; =A0Nr | =A0 write-&gt;irq =A0 =A0| =A0 =A0irq-&gt;read =A0 =A0| =A0 wr=
ite-&gt;read =A0 |<br>
&gt; -----------------------------------------------------------<br>
&gt; =A0 0 | =A0 =A0 =A0 =A0 =A0104495 | =A0 =A0 =A0 =A0 =A0617720 | =A0 =
=A0 =A0 =A0 =A0722215<br>
&gt; =A0 1 | =A0 =A0 =A0 =A0 =A0104649 | =A0 =A0 =A0 =A0 =A0617061 | =A0 =
=A0 =A0 =A0 =A0721710<br>
&gt; =A0 2 | =A0 =A0 =A0 =A0 =A0104360 | =A0 =A0 =A0 =A0 =A0617820 | =A0 =
=A0 =A0 =A0 =A0722180<br>
&gt; =A0 3 | =A0 =A0 =A0 =A0 =A0104906 | =A0 =A0 =A0 =A0 =A0617050 | =A0 =
=A0 =A0 =A0 =A0721956<br>
&gt; =A0 4 | =A0 =A0 =A0 =A0 =A0105794 | =A0 =A0 =A0 =A0 =A0617188 | =A0 =
=A0 =A0 =A0 =A0722982<br>
&gt; =A0 5 | =A0 =A0 =A0 =A0 =A0103504 | =A0 =A0 =A0 =A0 =A0618103 | =A0 =
=A0 =A0 =A0 =A0721607<br>
&gt; =A0 6 | =A0 =A0 =A0 =A0 =A0104643 | =A0 =A0 =A0 =A0 =A0617084 | =A0 =
=A0 =A0 =A0 =A0721727<br>
&gt; =A0 7 | =A0 =A0 =A0 =A0 =A0106633 | =A0 =A0 =A0 =A0 =A0617767 | =A0 =
=A0 =A0 =A0 =A0724400<br>
&gt;<br>
&gt; oh, it seems to work perfectly, i don&#39;t know why it works in this =
case when<br>
&gt; i lauched it in the terminal linux, i copied exactly the program in Ec=
lipse<br>
&gt; C++ and it doesn&#39;t work. Ah the only thing i have changed (otherwi=
se my<br>
&gt; program don&#39;t compile in Eclipse), is<br>
&gt;<br>
&gt; static const struct rtser_config read_config =3D {<br>
&gt; 0xFFFF,<br>
&gt; 115200,<br>
&gt; RTSER_DEF_PARITY,<br>
&gt; RTSER_DEF_BITS,<br>
&gt; RTSER_DEF_STOPB,<br>
&gt; RTSER_DEF_HAND,<br>
&gt; RTSER_DEF_FIFO_DEPTH,<br>
&gt; RTSER_DEF_TIMEOUT,<br>
&gt; RTSER_DEF_TIMEOUT,<br>
&gt; 1000000000, /* 1 s */<br>
&gt; RTSER_RX_TIMESTAMP_HISTORY,<br>
&gt; RTSER_EVENT_RXPEND,<br>
&gt; };<br>
&gt;<br>
&gt; static const struct rtser_config write_config =3D {<br>
&gt; RTSER_SET_BAUD | RTSER_SET_TIMESTAMP_HISTORY,<br>
&gt; 115200,<br>
&gt; RTSER_DEF_TIMESTAMP_HISTORY,<br>
&gt; /* the rest implicitely remains default */<br>
&gt; };<br>
&gt;<br>
&gt; maybe, i don&#39;t compile with good parameters in Eclipse?<br>
<br>
</div></div>Yes, that&#39;s your problem. And exactly to avoid such problem=
s, Xenomai<br>
provides the script &quot;xeno-config&quot; to retrieve proper compiler and=
 linker<br>
options.<br>
<br>
&gt; my version Xenomai 2.6.0<br>
<br>
I also recommend to update to a more recent version.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Wolfgang.<br>
</font></span></blockquote></div><br></div>

--20cf3040eb5cc49d5e04be7d416b--

