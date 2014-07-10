Date: Thu, 10 Jul 2014 17:05:40 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
Message-ID: <20140710150540.GE27469@lukather>
References: <1404210421-17081-1-git-send-email-maxime.ripard@free-electrons.com>
 <53B294A7.5010803@xenomai.org> <20140701141536.GN28647@lukather>
 <53B30D96.60500@xenomai.org> <20140704092736.GC13487@lukather>
 <53B7B3BF.3090807@xenomai.org> <20140707160239.GF13423@lukather>
 <53BAC5C4.5060704@xenomai.org> <20140708125505.GN13423@lukather>
 <53BC2AB5.4050801@xenomai.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53BC2AB5.4050801@xenomai.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] AT91: SAMA5D3: Adapt Ipipe for AIC5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Thomas Petazzoni <thomas@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Boris Brezillon <boris@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, xenomai@xenomai.org

On Tue, Jul 08, 2014 at 07:30:29PM +0200, Gilles Chanteperdrix wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 07/08/2014 02:55 PM, Maxime Ripard wrote:
> > On Mon, Jul 07, 2014 at 06:07:32PM +0200, Gilles Chanteperdrix
> > wrote:
> >> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
> >> 
> >> On 07/07/2014 06:02 PM, Maxime Ripard wrote:
> >>> On Sat, Jul 05, 2014 at 10:13:51AM +0200, Gilles Chanteperdrix 
> >>> wrote:
> >>>>>>> Ok, so, with the changes you mentionned, I can't make
> >>>>>>> the system crash anymore (or at least, not as easily as
> >>>>>>> it used to be).
> >>>>>>> 
> >>>>>>> But: - whenever the program mentionned above calls
> >>>>>>> exit(), it stalls. However, ctrl+c makes the program
> >>>>>>> exit properly, and everything seems fine otherwise -
> >>>>>>> whenever we don't link it against xenomai, it just
> >>>>>>> hangs. I've not figured out why yet
> >>>>>>> 
> >>>>>>> With CONFIG_XENOMAI and CONFIG_IPIPE disabled, it
> >>>>>>> works fine.
> >>>>>> 
> >>>>>> My answer was wrong, you probably need to keep the 
> >>>>>> set_backup/clear_backup calls in he ->hold and ->release 
> >>>>>> callbacks, as the linux interrupt may expect the backup
> >>>>>> areas to be in sync. Did you do this, or did you go for
> >>>>>> the alternative?
> >>>>> 
> >>>>> I went for the alternative. I'm sending you a v2 with what
> >>>>> I have so far, that shows the behaviour I was describing.
> >>>> 
> >>>> Could you try the following patch?
> >>> 
> >>> It actually works much better, thanks!
> >>> 
> >>> The above mentionned issues are gone, there's only one last
> >>> glitch I guess. The max latency under load is around a few
> >>> 100's of ms (while idle, it's actually around 200-300us, which
> >>> seems more reasonable.
> >> 
> >> 200us or 300us seems high for a last generation cortex.
> >> milliseconds issues indicate an issue, does the msw column in
> >> latency increment?
> > 
> > Ok, so after spending more time running xeno-test and latency
> > 
> > * xeno-test -l "dohell -s 192.168.0.42 -p 5566 -b
> > /usr/bin/hackbench 60" - the average latency measured is 37us, with
> > a max at 53
> > 
> > * If I just use the same load generator program I was using 
> > previously (which basically just run hackbench, dohell, do some dd,
> > output some data through netcat, etc.), and latency, for 45 
> > minutes, I get an average latency at 35us, and a max latency at
> > 60.
> > 
> > So the issue seems to lie in something related to our test
> > program.
> > 
> > It's actually using CLOCK_MONOTONIC. When running just Xenomai's 
> > clocktest program, the drift is OK, but the ToD offset is quite
> > huge and varies slightly from one run to another. This also happens
> > using CLOCK_REALTIME.
> > 
> > From what I understand of the POSIX clocks, gettimeofday is always 
> > using EPOCH as a starting point, while POSIX clocks can pick
> > whatever fixed starting point, so an offset might be expected.
> > What's weird is that it whenever you use the CLOCK_HOST_REALTIME,
> > which is used by xeno-test, and should be in sync with the Linux
> > clock, this offset is no longer there.
> > 
> > That's the only meaningful difference I could spot between the two 
> > programs (ours vs clocktest).
> 
> The test you are interested in is latency, not clocktest. The main
> differences between latency and the test you run are:
> - - the "period" (which BTW, in your case would only be a real period if
> you removed the call to clock_gettime at the beginning of the loop,
> only keeping the one before the loop), which is 1ms in latency case,
> 100us in your case

I don't really get what you mean here. If we don't call gettime at the
beginning of the loop, but only outside, how are we supposed to get
the next sleep expiration time?

> - - the fact that your function timespec_diff returns unsigned value, so
> in case of early shot, you will get a very large value instead of a
> negative ones.
> 
> As a general rule, we prefer Xenomai users to use the latency test,
> because this is the one we collectively spent time debugging, so it
> has more chances to be correct, and if you find a bug, everyone
> benefits from the fix.

Yes, I don't doubt that latency is much more tested and reliable.

The thing is, as you probably know, we're also a training company, and
we're using this script in our training to give an idea of the latency
on a regular linux kernel, and then on xenomai. It also have the
benefit of being simple enough for the trainees to be able to
understand it rather quickly.

I don't think latency fits both these criterias, that are quite
essential for us. But if you have any better solution that might,
we're definitely open to suggestions :)

> As for the question of the clocks:
> - - for POSIX, CLOCK_REALTIME and gettimeofday use the same time base
> - - CLOCK_MONOTONIC may use whatever they want, but usually are the time
> from boot or from the clocksource start;
> - - CLOCK_HOST_REALTIME should be synchronized with Linux
> CLOCK_REALTIME, that is the aim of CLOCK_HOST_REALTIME;
> - - CLOCK_REALTIME in the case of Xenomai is not near Linux
> CLOCK_REALTIME because the xenomai base time is initialized before
> your board sets its base, by whatever mean (hwclock, ntp, ntpdate,
> rdate, etc...), you can avoid that by using clock_settime to set
> Xenomai clock base, but the clock will drift away from Linux
> CLOCK_REALTIME anyway, so you will need to call clock_settime from
> time to time to keep them more or less in sync. This early
> synchronization is arguably broken, in fact it made sense when xenomai
> was compiled as a module, and loaded later on, but probably no longer
> makes sense for built-in configurations, which are now the default.

Thanks for this explanation :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140710/d89e634e/attachment.sig>
