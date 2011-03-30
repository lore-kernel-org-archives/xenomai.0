MIME-Version: 1.0
Sender: madjsw@domain.hid
In-Reply-To: <4D93A7F9.8060108@domain.hid>
References: <AANLkTi=LM5LNr1mT-f3xY-w-ATzRNPZX3hPVsFpG=TnC@mail.gmail.com>
	<4D89A334.4090802@domain.hid>
	<AANLkTikiEN7Pd-F2FqgXf9MGSTqg1wq_KxsumfZeR5xX@mail.gmail.com>
	<4D93A7F9.8060108@domain.hid>
Date: Wed, 30 Mar 2011 17:05:43 -0500
Message-ID: <AANLkTinmEU=a6SP4yf_jVDSVS8gTuNH-6N5ALT7aT4uT@mail.gmail.com>
From: Jeff Weber <jwamsc@domain.hid>
Content-Type: multipart/alternative; boundary=e0cb4e3851a8d1feb8049fba600b
Subject: Re: [Xenomai-help] CLOCK_REALTIME synchronized to NTP
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
Cc: xenomai@xenomai.org

--e0cb4e3851a8d1feb8049fba600b
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Mar 30, 2011 at 5:00 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Jeff Weber wrote:
> > On Wed, Mar 23, 2011 at 2:37 AM, Gilles Chanteperdrix <
> > gilles.chanteperdrix@xenomai.org> wrote:
> >
> >> Jeff Weber wrote:
> >>> I need to timetag events from a realtime context with a
> NPT-synchronized
> >>> system clock.  This topic comes up periodically on the mailing list.
> >>  Last I
> >>> recall, there was talk of adding the capability via an alternate
> >>> (non-CLOCK_REALTIME) clock_id. What is the status of this topic?
> >> The CLOCK_HOST_REALTIME is available in the xenomai-head branch (to be
> >> 2.6 branch, soon). It requires modifications of the I-pipe patch which
> >> are available, at least, on x86, but are probably not really hard to
> >> implement on other platforms.
> >>
> >
> >  clock_gettime(CLOCK_HOST_REALTIME) fails when called from kernel, and
> from
> > clocktest.  Any ideas why?
> > Does the CLOCK_HOST_REALTIME need to be initialized in some way?
> > Test and config follow.
> >
> > TIA,
> > Jeff
> >
> >
> >
> > # /usr/xenomai/bin/clocktest -D -C 42
> > hostrt data area is not live
> > clock_gettime failed for clock id 42
> > hostrt data area is not live
> >
> > # grep -rw CLOCK_HOST_REALTIME /usr/xenomai/include/
> > /usr/xenomai/include/posix/time.h:#define CLOCK_HOST_REALTIME 42
> >
> >  # zgrep HOSTRT /proc/config.gz
> > CONFIG_XENO_OPT_HOSTRT=y
> > CONFIG_HAVE_IPIPE_HOSTRT=y
> >
> > # cat /proc/xenomai/version
> > 2.5.90
> >
> > # cat /proc/ipipe/version
> > 2.9-00
> >
> > # uname -r
> > 2.6.37.3-xeno-head-smp
> >
> > Architecture is x86 32-bit SMP with TSC.
>
> CLOCK_HOST_REALTIME will work, only if the Linux kernel also uses the
> TSC as its clocksource. So, check the "Switching to clocksource"
> messages, or "disabling.*tsc" in the kernel log to see if the kernel has
> not decided to use another clock source.
>
>
The kernel is using the TSC:

 # dmesg  | grep -i -e tsc -e clock -e switching
[    0.000000] Fast TSC calibration using PIT
[    0.204507] Switching to clocksource tsc
[    2.602836] rtc_cmos 00:06: setting system clock to 2011-03-30 19:24:03
UTC (1301513043)

Jeff

--e0cb4e3851a8d1feb8049fba600b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Mar 30, 2011 at 5:00 PM, Gilles =
Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@=
xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex;">
<div><div></div><div class=3D"h5">Jeff Weber wrote:<br>
&gt; On Wed, Mar 23, 2011 at 2:37 AM, Gilles Chanteperdrix &lt;<br>
&gt; <a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdr=
ix@domain.hid</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; Jeff Weber wrote:<br>
&gt;&gt;&gt; I need to timetag events from a realtime context with a NPT-sy=
nchronized<br>
&gt;&gt;&gt; system clock. =A0This topic comes up periodically on the maili=
ng list.<br>
&gt;&gt; =A0Last I<br>
&gt;&gt;&gt; recall, there was talk of adding the capability via an alterna=
te<br>
&gt;&gt;&gt; (non-CLOCK_REALTIME) clock_id. What is the status of this topi=
c?<br>
&gt;&gt; The CLOCK_HOST_REALTIME is available in the xenomai-head branch (t=
o be<br>
&gt;&gt; 2.6 branch, soon). It requires modifications of the I-pipe patch w=
hich<br>
&gt;&gt; are available, at least, on x86, but are probably not really hard =
to<br>
&gt;&gt; implement on other platforms.<br>
&gt;&gt;<br>
&gt;<br>
&gt; =A0clock_gettime(CLOCK_HOST_REALTIME) fails when called from kernel, a=
nd from<br>
&gt; clocktest. =A0Any ideas why?<br>
&gt; Does the CLOCK_HOST_REALTIME need to be initialized in some way?<br>
&gt; Test and config follow.<br>
&gt;<br>
&gt; TIA,<br>
&gt; Jeff<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; # /usr/xenomai/bin/clocktest -D -C 42<br>
&gt; hostrt data area is not live<br>
&gt; clock_gettime failed for clock id 42<br>
&gt; hostrt data area is not live<br>
&gt;<br>
&gt; # grep -rw CLOCK_HOST_REALTIME /usr/xenomai/include/<br>
&gt; /usr/xenomai/include/posix/time.h:#define CLOCK_HOST_REALTIME 42<br>
&gt;<br>
&gt; =A0# zgrep HOSTRT /proc/config.gz<br>
&gt; CONFIG_XENO_OPT_HOSTRT=3Dy<br>
&gt; CONFIG_HAVE_IPIPE_HOSTRT=3Dy<br>
&gt;<br>
&gt; # cat /proc/xenomai/version<br>
&gt; 2.5.90<br>
&gt;<br>
&gt; # cat /proc/ipipe/version<br>
&gt; 2.9-00<br>
&gt;<br>
&gt; # uname -r<br>
&gt; 2.6.37.3-xeno-head-smp<br>
&gt;<br>
&gt; Architecture is x86 32-bit SMP with TSC.<br>
<br>
</div></div>CLOCK_HOST_REALTIME will work, only if the Linux kernel also us=
es the<br>
TSC as its clocksource. So, check the &quot;Switching to clocksource&quot;<=
br>
messages, or &quot;disabling.*tsc&quot; in the kernel log to see if the ker=
nel has<br>
not decided to use another clock source.<br>
<font color=3D"#888888"><br></font></blockquote><div><br></div><div>The ker=
nel is using the TSC:</div><div><br></div><div>=A0# dmesg =A0| grep -i -e t=
sc -e clock -e switching</div><div>[ =A0 =A00.000000] Fast TSC calibration =
using PIT</div>
<div>[ =A0 =A00.204507] Switching to clocksource tsc</div><div>[ =A0 =A02.6=
02836] rtc_cmos 00:06: setting system clock to 2011-03-30 19:24:03 UTC (130=
1513043)</div><div><br></div></div>Jeff

--e0cb4e3851a8d1feb8049fba600b--

