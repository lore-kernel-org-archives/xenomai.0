Subject: Re: [Xenomai-help] problem with installation
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44E45645.10106@domain.hid>
References: <20060816190510.20935.qmail@domain.hid>
	<44E36F6A.7060004@domain.hid> <200608162137.09103.nicola17@domain.hid>
	<44E37823.8080407@domain.hid>
	<33646.155.98.4.150.1155767832.squirrel@domain.hid>
	<1155803145.4356.33.camel@domain.hid>  <44E42BE3.1060709@domain.hid>
	<1155814285.4366.22.camel@domain.hid>  <44E45645.10106@domain.hid>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 14:32:17 +0200
Message-Id: <1155817937.4366.29.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2006-08-17 at 13:43 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Thu, 2006-08-17 at 10:42 +0200, Jan Kiszka wrote:
> >> Philippe Gerum wrote:
> >>> On Wed, 2006-08-16 at 16:37 -0600, Brandt Erickson wrote:
> >>>> So, perhaps I spoke too soon.  The system does boot, but I just looked in
> >>>> the syslog and found this:
> >>>>
> >>>> 16 16:08:49 dewback kernel: [4294670.201000] I-pipe: Domain Xenomai
> >>>> registered.
> >>>> Aug 16 16:08:49 dewback kernel: [4294670.201000] Xenomai: hal/x86 started.
> >>>> Aug 16 16:08:49 dewback kernel: [4294670.231000] Xenomai: real-time
> >>>> nucleus v2.2 (Engines Of Creation) loaded.
> >>>> Aug 16 16:08:49 dewback kernel: [4294670.232000] Xenomai: starting native
> >>>> API services.
> >>>> Aug 16 16:08:49 dewback kernel: [4294670.232000] Xenomai: starting POSIX
> >>>> services.
> >>>> Aug 16 16:08:49 dewback kernel: [4294670.232000] Xenomai: starting RTDM
> >>>> services.
> >>>> Aug 16 16:08:49 dewback kernel: [4294670.232000] Xenomai: incompatible
> >>>> timer mode (aperiodic found, need periodic).
> >>>> Aug 16 16:08:49 dewback kernel: [4294670.232000] Xenomai: VxWorks skin
> >>>> init failed, code -16.
> >>>>
> >>>> my .config is attached.  As far as I can tell, my timer is periodic and
> >>>> not aperiodic.  My kernel is 2.6.16 patched with xenomai-2.2.0 from the
> >>>> download page and not the trunk.
> >>> You need to build the native and POSIX skins as modules, so that they do
> >>> not override the timing mode (they both request aperiodic mode to the
> >>> nucleus, which conflicts with the VxWorks skin initializing after them).
> >>>
> >> Mmh, not on my test setup: once you set a reasonable period, all skins
> >> boot into periodic mode.
> > 
> > That is the point: all skins are going to use the periodic mode, but not
> > all applications are able to handle this. E.g. the latency test will
> > force the timing to oneshot using rt_timer_setmode(), but the cyclic
> > test won't, so you end up with funky results such as multi-ms latencies
> > with the latter, albeit the real figure - would the timing mode be
> > aperiodic as assumed - should be a handful of us. In the same vein,
> > running the latency test first, then VxWorks's satch demo on your config
> > would break the box, since the latter does not force the timing mode
> > back to periodic (actually, there is even no interface to do so, except
> > linking the VxWorks app against the native lib to get rt_timer_setmode).
> > 
> > Having all skins as modules (RTDM included) is the way to go whenever
> > using oneshot and periodic modes alternately depending on the loaded
> > application is required. This way, the timer is shut off upon skin
> > unloading, which prevents any conflict and makes sure that the next skin
> > will obtain the required mode. I'm not saying that such approach is
> > intuitive though, but only that it voids a fair number of potential
> > issues.
> > 
> > Of course, if only VxWorks is needed, then one just needs to disable the
> > other skins, which would also solve the issue the eager way.
> > 
> 
> That all sounds a bit fragile configuration-wise, also given that native
> and posix skins are on by default and that you can enable vxworks
> without having to switch on periodic timer support (BTW, are the other
> legacy RTOS skins with this dependency?).
> 

Yes. Most of traditional RTOSes deal with periodic ticks.

> I would suggest to enforce the later and maybe enhance the timer
> initialisation interface in a way that a user/skin can request to lock
> the mode if it only supports one.

This is a LART, not a fix.

>  Than the latency test should fail to
> start, thus indicating a wrong usage. Or we "hack" periodic support over
> aperiodic mode, but that's a different topic.
> 

This would not be a hack, but the real fix. Keeping the periodic timing
handled as a separate hw-dependent mode is the real problem and the
source of fragility, which does not buy us anything now that we have a
scalable aperiodic timer management code.

> Jan
> 
-- 
Philippe.



