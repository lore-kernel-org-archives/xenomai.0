MIME-Version: 1.0
In-Reply-To: <4C23682A.8060505@domain.hid>
References: <AANLkTikU5zPKew64ZxWGokwh5R5F-sNegWdDzOENWdzB@mail.gmail.com>
	<4C1B7EB1.2040006@domain.hid>
	<AANLkTinABTK2nMI0QfZVaULQ4OKwF0678PKOBc_OMIn1@domain.hid>
	<AANLkTiklRlwsIJfelo0eT2GZDvI6PtDAwc4qluLCr6R5@domain.hid>
	<4C1B8C04.3010900@domain.hid> <4C1BCCBF.7010400@domain.hid>
	<AANLkTilBt1fx4MFJ_Tmuz-fUl1D190u_FYDfLn09JaA3@domain.hid>
	<1277330401.2453.145.camel@domain.hid>
	<AANLkTincrp1q4RbmCoijrummF3IS_tfBJ-YGZnGFbpw0@domain.hid>
	<4C234679.10209@domain.hid>
	<AANLkTilPgVl1k1TUWBjwmT969SL5ga227so3x8VSqXtP@mail.gmail.com>
	<4C23682A.8060505@domain.hid>
Date: Mon, 28 Jun 2010 23:23:01 +0530
Message-ID: <AANLkTiki3aaq9r2y_GYKqp7EURyavyEhFk6oD90hvFrK@mail.gmail.com>
From: Nero Fernandez <grimlynch@domain.hid>
Content-Type: multipart/alternative; boundary=0016e64ccb26b316a5048a1acac5
Subject: Re: [Xenomai-core] Fwd: problem in pthread_mutex_lock/unlock
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--0016e64ccb26b316a5048a1acac5
Content-Type: text/plain; charset=ISO-8859-1

Thanks for the rootfs, Gilles.
Although i am unable to use it directly (i get 'illegal instruction'
error while running any application/busybox-applet), i will try
to construct a similar test-setup for further testing.

On Thu, Jun 24, 2010 at 7:44 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Nero Fernandez wrote:
> >
> > Yes, the measurements are on no-load scenarios.
> > I will try to repeat my measurements with system-loads as you suggest.
>
> You can find a working root filesystem image with Xenomai 2.5.3 compiled
> here:
> http://www.xenomai.org/~gch/pub/rootfs-arm926-ejs.tar.bz2<http://www.xenomai.org/%7Egch/pub/rootfs-arm926-ejs.tar.bz2>
>
> The root password is empty, the system launches a telnet daemon, so you
> can log on the board via telnet.
>
> To run the tests, launch in a first telnet session:
> echo 0 > /proc/xenomai/latency
> latency -T 2 -H
> in a second telnet sesssion, launch:
> dohell
> When you see "Listening on any address 5566", run on the host:
> netcat <target-name-or-IP> 5566
>
> where <target-name-or-IP> is the name of your arm board in the host
> /etc/hosts file or its IP address.
>
> Now, you can let the system run as long as the latency test prints
> message. When the dohell script is done, it will kill the latency test,
> which will cause it to print the histogram values and exit.
>
> --
>                                             Gilles.
>

--0016e64ccb26b316a5048a1acac5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks for the rootfs, Gilles.<br>Although i am unable to use it directly (=
i get &#39;illegal instruction&#39; <br>error while running any application=
/busybox-applet), i will try <br>to construct a similar test-setup for furt=
her testing.<br>
<br><div class=3D"gmail_quote">On Thu, Jun 24, 2010 at 7:44 PM, Gilles Chan=
teperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
mai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204=
); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">Nero Fernandez wrote:<br>
&gt;<br>
&gt; Yes, the measurements are on no-load scenarios.<br>
&gt; I will try to repeat my measurements with system-loads as you suggest.=
<br>
<br>
</div>You can find a working root filesystem image with Xenomai 2.5.3 compi=
led<br>
here:<br>
<a href=3D"http://www.xenomai.org/%7Egch/pub/rootfs-arm926-ejs.tar.bz2" tar=
get=3D"_blank">http://www.xenomai.org/~gch/pub/rootfs-arm926-ejs.tar.bz2</a=
><br>
<br>
The root password is empty, the system launches a telnet daemon, so you<br>
can log on the board via telnet.<br>
<br>
To run the tests, launch in a first telnet session:<br>
echo 0 &gt; /proc/xenomai/latency<br>
latency -T 2 -H<br>
in a second telnet sesssion, launch:<br>
dohell<br>
When you see &quot;Listening on any address 5566&quot;, run on the host:<br=
>
netcat &lt;target-name-or-IP&gt; 5566<br>
<br>
where &lt;target-name-or-IP&gt; is the name of your arm board in the host<b=
r>
/etc/hosts file or its IP address.<br>
<br>
Now, you can let the system run as long as the latency test prints<br>
message. When the dohell script is done, it will kill the latency test,<br>
which will cause it to print the histogram values and exit.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br>

--0016e64ccb26b316a5048a1acac5--

