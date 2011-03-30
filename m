MIME-Version: 1.0
Sender: madjsw@domain.hid
In-Reply-To: <4D89A334.4090802@domain.hid>
References: <AANLkTi=LM5LNr1mT-f3xY-w-ATzRNPZX3hPVsFpG=TnC@mail.gmail.com>
	<4D89A334.4090802@domain.hid>
Date: Wed, 30 Mar 2011 16:56:30 -0500
Message-ID: <AANLkTikiEN7Pd-F2FqgXf9MGSTqg1wq_KxsumfZeR5xX@mail.gmail.com>
From: Jeff Weber <jwamsc@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6db2942cfaa74049fba3f11
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

--0016e6db2942cfaa74049fba3f11
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Mar 23, 2011 at 2:37 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Jeff Weber wrote:
> > I need to timetag events from a realtime context with a NPT-synchronized
> > system clock.  This topic comes up periodically on the mailing list.
>  Last I
> > recall, there was talk of adding the capability via an alternate
> > (non-CLOCK_REALTIME) clock_id. What is the status of this topic?
>
> The CLOCK_HOST_REALTIME is available in the xenomai-head branch (to be
> 2.6 branch, soon). It requires modifications of the I-pipe patch which
> are available, at least, on x86, but are probably not really hard to
> implement on other platforms.
>

 clock_gettime(CLOCK_HOST_REALTIME) fails when called from kernel, and from
clocktest.  Any ideas why?
Does the CLOCK_HOST_REALTIME need to be initialized in some way?
Test and config follow.

TIA,
Jeff



# /usr/xenomai/bin/clocktest -D -C 42
hostrt data area is not live
clock_gettime failed for clock id 42
hostrt data area is not live

# grep -rw CLOCK_HOST_REALTIME /usr/xenomai/include/
/usr/xenomai/include/posix/time.h:#define CLOCK_HOST_REALTIME 42

 # zgrep HOSTRT /proc/config.gz
CONFIG_XENO_OPT_HOSTRT=y
CONFIG_HAVE_IPIPE_HOSTRT=y

# cat /proc/xenomai/version
2.5.90

# cat /proc/ipipe/version
2.9-00

# uname -r
2.6.37.3-xeno-head-smp

Architecture is x86 32-bit SMP with TSC.

--0016e6db2942cfaa74049fba3f11
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 23, 2011 at 2:37 AM, Gilles Chanteperdrix <span dir=3D"ltr">&lt=
;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org=
enomai.org</a>&gt;</span> wrote:<br><div class=3D"gmail_quote"><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex;">
<div><div></div><div class=3D"h5">Jeff Weber wrote:<br>
&gt; I need to timetag events from a realtime context with a NPT-synchroniz=
ed<br>
&gt; system clock. =A0This topic comes up periodically on the mailing list.=
 =A0Last I<br>
&gt; recall, there was talk of adding the capability via an alternate<br>
&gt; (non-CLOCK_REALTIME) clock_id. What is the status of this topic?<br>
<br>
</div></div>The CLOCK_HOST_REALTIME is available in the xenomai-head branch=
 (to be<br>
2.6 branch, soon). It requires modifications of the I-pipe patch which<br>
are available, at least, on x86, but are probably not really hard to<br>
implement on other platforms.<br></blockquote><div><br></div><div>=A0clock_=
gettime(CLOCK_HOST_REALTIME) fails when called from kernel, and from clockt=
est. =A0Any ideas why?</div><div>Does the=A0CLOCK_HOST_REALTIME need to be =
initialized in some way?</div>
<div>Test and config follow.</div><div><br></div><div>TIA,</div><div>Jeff</=
div><div><br></div><div><br></div><div><br></div></div><div># /usr/xenomai/=
bin/clocktest -D -C 42</div><div>hostrt data area is not live</div><div>
clock_gettime failed for clock id 42</div><div>hostrt data area is not live=
</div><div><br></div><div><div># grep -rw CLOCK_HOST_REALTIME /usr/xenomai/=
include/</div><div>/usr/xenomai/include/posix/time.h:#define CLOCK_HOST_REA=
LTIME 42</div>
</div><div><br></div><div><div>=A0# zgrep HOSTRT /proc/config.gz</div><div>=
CONFIG_XENO_OPT_HOSTRT=3Dy</div><div>CONFIG_HAVE_IPIPE_HOSTRT=3Dy</div></di=
v><div><br></div><div><div># cat /proc/xenomai/version</div><div>2.5.90</di=
v>
</div><div><br></div><div><div># cat /proc/ipipe/version</div><div>2.9-00</=
div></div><div><br></div><div><div># uname -r</div><div>2.6.37.3-xeno-head-=
smp</div></div><div><br></div><div>Architecture is x86 32-bit SMP with TSC.=
</div>
<div><br></div>

--0016e6db2942cfaa74049fba3f11--

