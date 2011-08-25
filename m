MIME-Version: 1.0
In-Reply-To: <4E552695.7090401@domain.hid>
References: <CAL+uwv-D111pO40ZT=ipXU+V1Ss8Fi4L1DfXWj=o+f2UxFubaA@mail.gmail.com>
	<4E54EAE4.2060705@domain.hid>
	<CAL+uwv9Lg6uhqwy_YMxevFt4e8RJLrxZhm186L4-0xAHYDgLUw@domain.hid>
	<4E54F5B4.5070100@domain.hid>
	<CAL+uwv_429MvgmL8urkFc+4KWqRj328F7AhZUMc_u-UwjO_Gzg@domain.hid>
	<4E552695.7090401@domain.hid>
Date: Thu, 25 Aug 2011 11:25:20 +0200
Message-ID: <CAL+uwv8La8ad9Vc8HZYhvgMyWb0=5r5-X1yy1aDKJ-jauJgESw@domain.hid>
From: suresh reddy <sureshreddy.balijepalli@domain.hid>
Content-Type: multipart/alternative; boundary=20cf307cfecefbeb3904ab5101ea
Subject: Re: [Xenomai-help] Hanging
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

--20cf307cfecefbeb3904ab5101ea
Content-Type: text/plain; charset=ISO-8859-1

Dear Giles,

1. taking timing results using rt_timer-tsc on pandaboard for a test program
using xenomai native services.

2. taking timing results using gettimeofday on pandaboard for same test
program using linuxthreads.


Can i compare these two timing results ?






On 24 August 2011 18:28, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 08/24/2011 04:12 PM, suresh reddy wrote:
> > Thank you Giles.
> >
> > yes .The rt_printf is single-writer/ single -reader.
>
> No, each thread has a buffer. But the point is that the thread which
> empties the buffers and prints them run in secondary mode, so, it will
> not run if there is always a real-time thread running, the buffer will
> fill up, and nothing will be printed.
>
> --
>                                             Gilles.
>



-- 

Suresh balijepalli
Rosenehim,Baveria.

--20cf307cfecefbeb3904ab5101ea
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Giles,<div><br></div><div>1. taking timing results us=
ing rt_timer-tsc on pandaboard for a test program using xenomai native serv=
ices.</div><div><br></div><div>2. taking timing results using gettimeofday =
on pandaboard for same test program using linuxthreads.</div>
<div><br></div><div><br></div><div>Can i compare these two timing results ?=
=A0</div><div><br></div><div><br></div><div><br><div class=3D"gmail_quote">=
<br></div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote"><=
br></div>
<div class=3D"gmail_quote">On 24 August 2011 18:28, Gilles Chanteperdrix <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gil=
les.chanteperdrix@domain.hid</a>&gt;</span> wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex;">
<div class=3D"im">On 08/24/2011 04:12 PM, suresh reddy wrote:<br>
&gt; Thank you Giles.<br>
&gt;<br>
&gt; yes .The rt_printf is single-writer/ single -reader.<br>
<br>
</div>No, each thread has a buffer. But the point is that the thread which<=
br>
empties the buffers and prints them run in secondary mode, so, it will<br>
not run if there is always a real-time thread running, the buffer will<br>
fill up, and nothing will be printed.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><br>S=
uresh balijepalli<br>Rosenehim,Baveria.<br>
</div></div>

--20cf307cfecefbeb3904ab5101ea--

