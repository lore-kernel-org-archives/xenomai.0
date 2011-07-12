MIME-Version: 1.0
In-Reply-To: <4E1C28E1.3090906@domain.hid>
References: <CAL+uwv-XzsN_+4MHXTo+SW7jAh98rf22ER4uGb5DV+HXktELOg@domain.hid>
	<4E1B3988.9000907@domain.hid>
	<CAL+uwv_pGnuuWir_qC+sHLn=Te6NFgrO4XUpaXjLpGZ=1-C_JQ@mail.gmail.com>
	<4E1B48B8.4090007@domain.hid>
	<CAL+uwv8yEu92kUAnyCq1Q3LQ9fB0EzFJQA0028nJ-hyWP0m03Q@mail.gmail.com>
	<CAL+uwv90pAbaXS0KvUhzoMz9ns1bsUjx=-WJ_SJUTSBfAuVWpQ@mail.gmail.com>
	<4E1C28E1.3090906@domain.hid>
Date: Tue, 12 Jul 2011 14:12:21 +0200
Message-ID: <CAL+uwv-U=MjdkQaosR72AdVAXY-+7FpU7Brts+_BgLCcC0bWsA@mail.gmail.com>
From: suresh reddy <sureshreddy.balijepalli@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec5016419378e9404a7de36e4
Subject: Re: [Xenomai-help] Fwd: Regarding xeno test (somethign died at 3150)
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

--bcaec5016419378e9404a7de36e4
Content-Type: text/plain; charset=ISO-8859-1

On 12 July 2011 12:58, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 07/12/2011 11:24 AM, suresh reddy wrote:
> > Dear Giles,
> >
> > /usr/bin/latency  results in command not found.
> >
> > ubuntu@domain.hid$ sudo ./clocktest
> > [sudo] password for ubuntu:
> > Xenomai or CONFIG_XENO_OPT_PERVASIVE disabled.
> > (modprobe xeno_nucleus?)
> > ubuntu@domain.hid$ sudo ./latency
> > [sudo] password for ubuntu:
> > Xenomai or CONFIG_XENO_OPT_PERVASIVE disabled.
> > (modprobe xeno_nucleus?)
> > ubuntu@domain.hid$ modprobe xeno_nucleus
> > FATAL: Module xeno_nucleus not found.
> > ubuntu@domain.hid$ cd
> > ubuntu@domain.hid:~$ /usr/bin
> > -bash: /usr/bin: Is a directory
> > ubuntu@domain.hid:~$ cd /usr/bin
> > ubuntu@domain.hid$ sudo ./latency
> > [sudo] password for ubuntu:
> > sudo: ./latency: command not found
> > ubuntu@domain.hid$
> >
> >
> > But the configuration has config_XENO_OPT_PERVASIVE=y
>
> Your user-space support is mis-compiled. See README.INSTALL for an
> explanation of the ARM specific options to be passed to the configure
> script.
>
> --
>                                                                 Gilles.
>

I have passed all the options even they were mentioned weak in documentation
.

/media/disk-5/usr/bin# /home/balijepalli/omap4/xenomai-2.5.6/configure
--build=i486-pc-linux-gnu --host=arm-none-linux-gnueabi
--enable-arm-mach=omap3 --enable-arm-tsc --enable-arm-eabi
--enable-arm-arch=armv7

does this have any error.



-- 

Suresh balijepalli
Rosenehim,Baveria.

--bcaec5016419378e9404a7de36e4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote">On 12 July 2011 12:58, =
Gilles Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chantep=
erdrix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex;">
<div class=3D"im">On 07/12/2011 11:24 AM, suresh reddy wrote:<br>
&gt; Dear Giles,<br>
&gt;<br>
</div><div class=3D"im">&gt; /usr/bin/latency =A0results in command not fou=
nd.<br>
&gt;<br>
&gt; ubuntu@domain.hid$ sudo ./clocktest<br>
&gt; [sudo] password for ubuntu:<br>
&gt; Xenomai or CONFIG_XENO_OPT_PERVASIVE disabled.<br>
&gt; (modprobe xeno_nucleus?)<br>
&gt; ubuntu@domain.hid$ sudo ./latency<br>
&gt; [sudo] password for ubuntu:<br>
&gt; Xenomai or CONFIG_XENO_OPT_PERVASIVE disabled.<br>
&gt; (modprobe xeno_nucleus?)<br>
&gt; ubuntu@domain.hid$ modprobe xeno_nucleus<br>
&gt; FATAL: Module xeno_nucleus not found.<br>
&gt; ubuntu@domain.hid$ cd<br>
&gt; ubuntu@domain.hid:~$ /usr/bin<br>
&gt; -bash: /usr/bin: Is a directory<br>
&gt; ubuntu@domain.hid:~$ cd /usr/bin<br>
&gt; ubuntu@domain.hid$ sudo ./latency<br>
&gt; [sudo] password for ubuntu:<br>
&gt; sudo: ./latency: command not found<br>
&gt; ubuntu@domain.hid$<br>
&gt;<br>
&gt;<br>
&gt; But the configuration has config_XENO_OPT_PERVASIVE=3Dy<br>
<br>
</div>Your user-space support is mis-compiled. See README.INSTALL for an<br=
>
explanation of the ARM specific options to be passed to the configure<br>
script.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0Gilles.<br>
</font></blockquote></div><div><br></div><div>I have passed all the options=
 even they were mentioned weak in documentation .</div><div><br></div><div>=
<div>/media/disk-5/usr/bin# /home/balijepalli/omap4/xenomai-2.5.6/configure=
 --build=3Di486-pc-linux-gnu --host=3Darm-none-linux-gnueabi --enable-arm-m=
ach=3Domap3 --enable-arm-tsc --enable-arm-eabi --enable-arm-arch=3Darmv7</d=
iv>
</div><div><br></div><div>does this have any error.</div><br><br clear=3D"a=
ll"><br>-- <br><br>Suresh balijepalli<br>Rosenehim,Baveria.<br>
</div>

--bcaec5016419378e9404a7de36e4--

