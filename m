Subject: Re: [Xenomai-core] Problem with periodic timer on PPC40x solved
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4516F39A.7040603@domain.hid>
References: <200609232013.27649.niklaus.giger@domain.hid>
	<45159F4F.3010805@domain.hid>
	<200609242247.57024.niklaus.giger@domain.hid>
	<4516F39A.7040603@domain.hid>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 17:57:34 +0200
Message-Id: <1159199854.4970.19.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

On Sun, 2006-09-24 at 23:07 +0200, Wolfgang Grandegger wrote:
> Niklaus Giger wrote:
> >  static void rthal_set_local_cpu_timer(void)
> >  {
> > +#ifndef CONFIG_40x
> >      long ticks;
> > +#endif
> >      rthal_declare_cpuid;
> >  
> >      rthal_load_cpuid();
> > @@ -110,7 +112,7 @@
> >      if (ns == 0)
> >          ticks = tb_ticks_per_jiffy;
> >      else {
> > -        ticks = ns * tb_ticks_per_jiffy / (1000000000 / HZ);
> > +	ticks = ns * (tb_ticks_per_jiffy / 10000) / (100000 / HZ);
> >  
> >          if (ticks > tb_ticks_per_jiffy) {
> >              DBG("rthal_set_cpu_timers_unsafe: -EINVAL (%lu)\n", ticks);
> 
> My suggested fix was just to locate the source of the problem. As 
> Philippe suggested, we should use mulhwu (or mulhwu_scale_factor). Have 
> a look to arch/ppc/kernel/time.c for further information.

Ok, we can go for the lazy fix here, since this code is poised to
disappear anyway. I've merged a variant of the above we already use for
the ARM port, which scales down the period to microseconds instead of
losing precision on the count of timebase ticks per jiffy.

- ticks = ns * tb_ticks_per_jiffy / (1000000000 / HZ);
+ ticks = (ns / 1000) * tb_ticks_per_jiffy / (1000000 / HZ);

-- 
Philippe.



