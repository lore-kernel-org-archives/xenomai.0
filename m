From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1078462.1185791528606.JavaMail.ngmail@domain.hid>
References: <1078462.1185791528606.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Mon, 30 Jul 2007 12:58:05 +0200
Message-Id: <1185793085.6611.42.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] V2.3.3 and kernel 2.6.22?
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2007-07-30 at 12:32 +0200, M. Koehrer wrote:
> Hi everybody,
> 
> I want to know if it is possible to use Xenomai 2.3.3 with the Adeos patch
> adeos-ipipe-2.6.22-i386-1.9-01.patch (e.g. from the Xenomai svn trunk)?

No. 2.6.22/x86 introduces some drastic changes into the timer
infrastructure Xenomai needs to cope with. Since v2.3.x is a stable
series, it would not be possible to change its core the way Linux
requires for supporting 2.6.22 and beyond; the changes would be too
significant. So adeos-2.6.22 is only available starting from 2.4-rc1,
because we may change the core Xenomai infrastructure appropriately
there, and did so.

> Or is the 2.3.3 limited to those Adeos patches that are part of the 2.3.3 release?
> 

v2.3.3 is limited to 2.6.20 and earlier for x86. The situation may be
different for other archs, like powerpc for instance which may use more
recent kernels.

> If it is possible to use the adeos-ipipe-2.6.22 patch, what risks could be caused by this
> "not official" patch?

Which patch are you referring too? Xenomai always uses official Adeos
patches, and 2.6.22-1.9-01 is also available from the official Adeos
download area. Those are the very same patches.

> 
> Or more general: What is the relation between Xenomai and Adeos patches?
> Are the Adeos patches used (and tested) somewhere outside of Xenomai? 
> Or is it always the bundle Adeos + Xenomai?
> 

Adeos and Xenomai projects have the same lead maintainer, i.e. /me,
which somehow simplifies a number of things for users since I tend to
make sure Adeos will always fullfil Xenomai's needs, but makes them
conversely complex for me.

This said, Xenomai and Adeos are distinct projects founded at different
times, even if in practice, Xenomai is Adeos's privileged user. I know
of several projects using Adeos or part of under the hood, with or
without RT extension on top, but patch validation is always conducted
with Xenomai on top.

> Thanks for a clarification.
> 
> Regards
> 
> Mathias
> 
> 
> 
> 
> 
-- 
Philippe.



