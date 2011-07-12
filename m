MIME-Version: 1.0
In-Reply-To: <CAL+uwv8yEu92kUAnyCq1Q3LQ9fB0EzFJQA0028nJ-hyWP0m03Q@mail.gmail.com>
References: <CAL+uwv-XzsN_+4MHXTo+SW7jAh98rf22ER4uGb5DV+HXktELOg@domain.hid>
	<4E1B3988.9000907@domain.hid>
	<CAL+uwv_pGnuuWir_qC+sHLn=Te6NFgrO4XUpaXjLpGZ=1-C_JQ@mail.gmail.com>
	<4E1B48B8.4090007@domain.hid>
	<CAL+uwv8yEu92kUAnyCq1Q3LQ9fB0EzFJQA0028nJ-hyWP0m03Q@mail.gmail.com>
Date: Tue, 12 Jul 2011 11:24:15 +0200
Message-ID: <CAL+uwv90pAbaXS0KvUhzoMz9ns1bsUjx=-WJ_SJUTSBfAuVWpQ@mail.gmail.com>
From: suresh reddy <sureshreddy.balijepalli@domain.hid>
Content-Type: multipart/alternative; boundary=20cf3071c80416fb1004a7dbdd63
Subject: [Xenomai-help] Fwd:  Regarding xeno test (somethign died at 3150)
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

--20cf3071c80416fb1004a7dbdd63
Content-Type: text/plain; charset=ISO-8859-1

Dear Giles,

/usr/bin/latency  results in command not found.

ubuntu@domain.hid$ sudo ./clocktest
[sudo] password for ubuntu:
Xenomai or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_nucleus?)
ubuntu@domain.hid$ sudo ./latency
[sudo] password for ubuntu:
Xenomai or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_nucleus?)
ubuntu@domain.hid$ modprobe xeno_nucleus
FATAL: Module xeno_nucleus not found.
ubuntu@domain.hid$ cd
ubuntu@domain.hid:~$ /usr/bin
-bash: /usr/bin: Is a directory
ubuntu@domain.hid:~$ cd /usr/bin
ubuntu@domain.hid$ sudo ./latency
[sudo] password for ubuntu:
sudo: ./latency: command not found
ubuntu@domain.hid$


But the configuration has config_XENO_OPT_PERVASIVE=y













On 11 July 2011 21:02, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 07/11/2011 08:59 PM, suresh reddy wrote:
> > Dear Giles,
> >
> > i have another doubt regarding configuration of kernel.
> >
> > as far as i see you did not configure any pandaboard display options . i
> > mean hdmi kind of optins . so we can acces only through console??
>
> Configuring the kernel for your particular needs is your job. The
> configuration I sent you is the one which suits my needs.
>
> --
>                                                                 Gilles.
>



-- 

Suresh balijepalli
Rosenehim,Baveria.



-- 

Suresh balijepalli
Rosenehim,Baveria.

--20cf3071c80416fb1004a7dbdd63
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr"><div>D=
ear Giles,</div><div><br></div><div>/usr/bin/latency =A0results in command =
not found.</div><div><br></div><div><div>ubuntu@domain.hid$ sudo=
 ./clocktest</div>
<div>[sudo] password for ubuntu:</div><div>Xenomai or CONFIG_XENO_OPT_PERVA=
SIVE disabled.</div><div>(modprobe xeno_nucleus?)</div><div>ubuntu@domain.hid=
r/xenomai/bin$ sudo ./latency</div><div>[sudo] password for ubuntu:</div>
<div>Xenomai or CONFIG_XENO_OPT_PERVASIVE disabled.</div><div>(modprobe xen=
o_nucleus?)</div><div>ubuntu@domain.hid$ modprobe xeno_nucleus</=
div><div>FATAL: Module xeno_nucleus not found.</div><div>ubuntu@domain.hid=
enomai/bin$ cd</div>
<div>ubuntu@domain.hid:~$ /usr/bin</div><div>-bash: /usr/bin: Is a directory</div=
><div>ubuntu@domain.hid:~$ cd /usr/bin</div><div>ubuntu@domain.hid$ sudo ./lat=
ency</div><div>[sudo] password for ubuntu:</div><div>sudo: ./latency: comma=
nd not found</div>
<div>ubuntu@domain.hid$</div></div><div><br></div><div><br></div><div>Bu=
t the configuration has config_XENO_OPT_PERVASIVE=3Dy</div><div><br></div><=
div><br></div><div><br></div><div><br></div><div><br></div><div><div><br>
</div></div><div><div></div><div class=3D"h5"><div><br></div><div><br></div=
><div><br></div><div><br></div><div><br></div><br><br>
<div class=3D"gmail_quote">On 11 July 2011 21:02, Gilles Chanteperdrix <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org" targe=
t=3D"_blank">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">

<div>On 07/11/2011 08:59 PM, suresh reddy wrote:<br>
&gt; Dear Giles,<br>
&gt;<br>
&gt; i have another doubt regarding configuration of kernel.<br>
&gt;<br>
&gt; as far as i see you did not configure any pandaboard display options .=
 i<br>
&gt; mean hdmi kind of optins . so we can acces only through console??<br>
<br>
</div>Configuring the kernel for your particular needs is your job. The<br>
configuration I sent you is the one which suits my needs.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0Gilles.<br>
</font></blockquote></div><br><br clear=3D"all"><br></div></div>-- <br><br>=
Suresh balijepalli<br>Rosenehim,Baveria.<br>
</div>
</div><br><br clear=3D"all"><br>-- <br><br>Suresh balijepalli<br>Rosenehim,=
Baveria.<br>
</div>

--20cf3071c80416fb1004a7dbdd63--

