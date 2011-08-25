MIME-Version: 1.0
In-Reply-To: <4E568CFC.2050203@domain.hid>
References: <CAL+uwv-D111pO40ZT=ipXU+V1Ss8Fi4L1DfXWj=o+f2UxFubaA@mail.gmail.com>
	<4E54EAE4.2060705@domain.hid>
	<CAL+uwv9Lg6uhqwy_YMxevFt4e8RJLrxZhm186L4-0xAHYDgLUw@domain.hid>
	<4E54F5B4.5070100@domain.hid>
	<CAL+uwv_429MvgmL8urkFc+4KWqRj328F7AhZUMc_u-UwjO_Gzg@domain.hid>
	<4E552695.7090401@domain.hid>
	<CAL+uwv8La8ad9Vc8HZYhvgMyWb0=5r5-X1yy1aDKJ-jauJgESw@domain.hid>
	<4E568CFC.2050203@domain.hid>
Date: Thu, 25 Aug 2011 20:18:12 +0200
Message-ID: <CAL+uwv-Adfd8d-g9D-YY_R8qTS6_qP=9+FrbJm=0JrdDTYeNfw@domain.hid>
From: suresh reddy <sureshreddy.balijepalli@domain.hid>
Content-Type: multipart/alternative; boundary=20cf307d05e8a6b4c304ab58736e
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

--20cf307d05e8a6b4c304ab58736e
Content-Type: text/plain; charset=ISO-8859-1

Dear Gilles,

Thanks for the reply . Yes , the real-time is about worst case latencies ,
iam running a script in background which will keep on downloading from
network and removing the downloaded .Just to keep machine working.



Thanks
Suresh




On 25 August 2011 19:57, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 08/25/2011 11:25 AM, suresh reddy wrote:
> > Dear Giles,
>
> It is Gilles.
>
> >
> > 1. taking timing results using rt_timer-tsc on pandaboard for a test
> program
> > using xenomai native services.
> >
> > 2. taking timing results using gettimeofday on pandaboard for same test
> > program using linuxthreads.
> >
> >
> > Can i compare these two timing results ?
>
> your system is likely using nptl, not linuxthreads. And clock_gettime
> instead of gettimeofday will give you precision down to the nanosecond,
> like rt_timer_tsc2ns.
>
> But yes, you can compare the results, if you bear in mind that real-time
> is about worst case latencies, so results obtained by running tests for
> a few seconds or minutes on an idle machine are meaningless.
>
> Also note that since Xenomai has a posix api, you can have the exact
> same code running with and without xenomai.
>
> --
>                                                                 Gilles.
>



-- 

Suresh balijepalli
Rosenehim,Baveria.

--20cf307d05e8a6b4c304ab58736e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Gilles,<div><br></div><div>Thanks for the reply . Yes=
 , the real-time is about worst case latencies , iam running a script in ba=
ckground which will keep on downloading from network and removing the downl=
oaded .Just to keep machine working.</div>
<div><br></div><div><br></div><div><br></div><div>Thanks</div><div>Suresh</=
div><div><br></div><div><br></div><div>=A0=A0</div><div><br><div class=3D"g=
mail_quote">On 25 August 2011 19:57, Gilles Chanteperdrix <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdr=
ix@domain.hid</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">On 08/25/2011 11:25 AM, s=
uresh reddy wrote:<br>
&gt; Dear Giles,<br>
<br>
</div>It is Gilles.<br>
<div class=3D"im"><br>
&gt;<br>
&gt; 1. taking timing results using rt_timer-tsc on pandaboard for a test p=
rogram<br>
&gt; using xenomai native services.<br>
&gt;<br>
&gt; 2. taking timing results using gettimeofday on pandaboard for same tes=
t<br>
&gt; program using linuxthreads.<br>
&gt;<br>
&gt;<br>
&gt; Can i compare these two timing results ?<br>
<br>
</div>your system is likely using nptl, not linuxthreads. And clock_gettime=
<br>
instead of gettimeofday will give you precision down to the nanosecond,<br>
like rt_timer_tsc2ns.<br>
<br>
But yes, you can compare the results, if you bear in mind that real-time<br=
>
is about worst case latencies, so results obtained by running tests for<br>
a few seconds or minutes on an idle machine are meaningless.<br>
<br>
Also note that since Xenomai has a posix api, you can have the exact<br>
same code running with and without xenomai.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0Gilles.<br>
</font></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><br>S=
uresh balijepalli<br>Rosenehim,Baveria.<br>
</div></div>

--20cf307d05e8a6b4c304ab58736e--

