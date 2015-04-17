Date: Fri, 17 Apr 2015 09:32:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150417073221.GM1589@hermes.click-hack.org>
References: <CACreCVJiKuVmA5cnH7sLxK=3-nCJwo=Q-bJFugLgoM8LTDdYWQ@mail.gmail.com>
 <20150416132316.GD1589@hermes.click-hack.org>
 <552FBC6B.4070402@siemens.com>
 <CACreCVLZwXhFiWzpFewR+a6ab6+SyKQnPLFA7=mP5BcwEFzugA@mail.gmail.com>
 <20150416161819.GG1589@hermes.click-hack.org>
 <CACreCVLbXk1M=pf9o0QcRNbYEeoU_BinVHuokXMO2ec00yngNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACreCVLbXk1M=pf9o0QcRNbYEeoU_BinVHuokXMO2ec00yngNQ@mail.gmail.com>
Subject: Re: [Xenomai] CLOCK_HOST_REALTIME failure on Xenomai 3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: GP Orcullo <kinsamanka@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Apr 17, 2015 at 03:01:58PM +0800, GP Orcullo wrote:
> On Fri, Apr 17, 2015 at 12:18 AM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
> > On Fri, Apr 17, 2015 at 12:12:01AM +0800, GP Orcullo wrote:
> >> On Thu, Apr 16, 2015 at 9:43 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >> > On 2015-04-16 15:23, Gilles Chanteperdrix wrote:
> >> >> On Thu, Apr 16, 2015 at 07:20:09PM +0800, GP Orcullo wrote:
> >> >>> Hi,
> >> >>>
> >> >>> I'm trying to run Xenomai 3 on my Cubieboard2 but it fails the clocktest:
> >> >>>
> >> >>> # /usr/xenomai/bin/clocktest -C 42
> >> >>> clock_gettime failed for clock id == Tested clock: 42 (<unknown>)
> >> >>> CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
> >> >>> --- -------------------- ---------------- ---------- --------------42
> >> >>>
> >> >>>   0                  0.0            0.000          0            0.0
> >> >>>   1                  0.0            0.000          0            0.0
> >> >>> clock_gettime failed for clock id 42
> >> >>>
> >> >>> The clock test runs fine on Xenomai 2:
> >> >>>
> >> >>> # clocktest -C 42
> >> >>> == Tested clock: 42 (CLOCK_HOST_REALTIME)
> >> >>> CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
> >> >>> --- -------------------- ---------------- ---------- --------------
> >> >>>   0                  1.0            0.093          0            0.0
> >> >>>   1                  0.8            0.000          0            0.0
> >> >>> ^C
> >> >>
> >> >> CLOCK_HOST_REALTIME is no longer 42 in Xenomai 3 (which is why
> >> >> clocktest tells you that the clockid 42 is unknown, it really is).
> >> >>
> >> >
> >> > CLOCK_HOST_REALTIME is an extension clock, thus you need
> >> >
> >> > clocktest -E -C 42
> >> >
> >> > in Xenomai 3.
> >> >
> >> > Jan
> >> >
> >> > --
> >> > Siemens AG, Corporate Technology, CT RTC ITP SES-DE
> >> > Corporate Competence Center Embedded Linux
> >>
> >> The answer is 32 :)
> >>
> >> # /usr/xenomai/bin/clocktest -D -C 32
> >> hostrt data area is live
> >> sequence counter : 261312
> >> wall_time_sec    : 3698
> >> wall_time_nsec   : 660000622
> >> wall_to_monotonic_sec    : -2392
> >> wall_to_monotonic_nsec   : 103430917
> >> cycle_last       : 31565440899
> >> mask             : 0xffffffffffffffff
> >> mult             : 699050667
> >> shift            : 24
> >>
> >> == Tested clock: 32 (CLOCK_HOST_REALTIME)
> >> CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
> >> --- -------------------- ---------------- ---------- --------------
> >>   0                  1.4           -0.034          0            0.0
> >>   1                  1.4            0.134          0            0.0
> >>
> >>
> >> BTW, any idea on how to diagnose the switchtest issue? The test is
> >> running but it is not generating any output. It looks like "-q -Q"
> >> switches are enabled.
> >
> > It probably failed, then failed to report the error and is just
> > hanging there blocked. You can try and pass command line arguments
> > to reduce the (insane by default) number of tasks it creates, in
> > order to try and reduce the failure to a simple one. The first tasks
> > to avoid are probably kernel tasks.
> >
> > --
> >                                             Gilles.
> 
> The problem was due to uClibc; I was using buildroot for the initramfs.
> 
> Compiling the tools under glibc fixed the switchtest issue.
> 
> Thanks for all the help!

I am not sure xenomai 3.0 should not work with uClibc. Could you
find exactly what uClibc function causes a problem with switchest?
Normally switchtest uses pretty standard stuff, so, there is no
reason.

-- 
					    Gilles.

