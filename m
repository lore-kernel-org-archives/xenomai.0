Subject: Re: [Xenomai-core] Problem with periodic timer on PPC40x identified
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45159F4F.3010805@domain.hid>
References: <200609232013.27649.niklaus.giger@domain.hid>
	<45159F4F.3010805@domain.hid>
Content-Type: text/plain
Date: Sat, 23 Sep 2006 23:33:12 +0200
Message-Id: <1159047192.5915.50.camel@domain.hid>
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

On Sat, 2006-09-23 at 22:55 +0200, Wolfgang Grandegger wrote:
> Hi Niklaus,
> Niklaus Giger wrote:
> > Hi
> > 
> > Finally I got some time to debug the whole problem with my BDI.
> > I see that in hal.c thal_set_local_cpu_timer the PIT is loaded with a value of 
> > 568 which is far too low, as the PIT is running at 400 MHz. So it will 
> > trigger an interrupt every 1,4 microsecond and therefore overload the system.
> > 
> > I am not sure about the time units stored in __ipipe_decr_ticks. I tried to 
> > use 400 as my board is running at 400 MHz.
> > A quick breakpoint in ppc4xx_calibrate_decr in the file 
> > arch/syslib/ppc4xx_setup.c verified that bdinfo has the correct value of 
> > 400'000'000 as frequency.
> > 
> > In hal.c and ipipe-core are two occurences of
> >     mtspr(SPRN_PIT, __ipipe_decr_ticks); 
> > which I replaced by the above computed constant
> >     mtspr(SPRN_PIT, __ipipe_decr_ticks * 400); 
> > 
> > Now the the board comes up, but calling in the vxworks skin 
> > taskDelay(sysClkRateGet()*10) delays me only about 5 seconds and not 10 as 
> > expected.
> > 
> > I have one possible explanation that the value of 568 is the result of a 
> > implicit truncation to 32 bits in ipipe_tune_timer. tb_ticks_per_jiffy is 
> > 1600000, sysClkRate is 10000. Therefore a maximal delay of 1 ms = 1000*1000 
> > ns leads to 1000*1000*16000 = 0x25'40BE'4000.
> > 
> > If would be nice if somebode could shed some light on this issue.
> 
> I briefly look why the value of __ipipe_decr_ticks is bogus. Maybe the 
> calculation fails due to 32-bit constraints in 
> arch/ppc/kernel/ipipe-core.c:pipe_tune_timer():
> 

That would make sense, since the issue never happens when the nucleus
noots in oneshot timing mode, just because this code is not used in this
case. Well, I'm really going to kill this ugly hw-managed periodic mode
in the next release, and rebase the periodic timing over the oneshot
mode as we discussed. This code is just silly and error-prone.

>    int ipipe_tune_timer(unsigned long ns, int flags)
>    {
>          unsigned long x, ticks;
> 
>          if (flags & IPIPE_RESET_TIMER)
>                  ticks = tb_ticks_per_jiffy;
>          else {
>                  ticks = ns * tb_ticks_per_jiffy / (1000000000 / HZ);
>   		^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                  if (ticks > tb_ticks_per_jiffy)
>                          return -EINVAL;
>          }
>  
> 
>          x = ipipe_critical_enter(&__ipipe_set_decr); /* Sync with all
>                                                          CPUs */
>          __ipipe_decr_ticks = ticks;
>          __ipipe_set_decr();
>          ipipe_critical_exit(x);
>  
> 
>           return 0;
>   }
>  
> 
> Does replacing the calculation of ticks with
> 
>          ticks = ns * (tb_ticks_per_jiffy / 10000) / (100000 / HZ);
> 
> help. A proper calculation might use mulhwu or rthal_imuldiv.

mulhwu then, because we should not introduce Xenomai HAL level ops in
the Adeos abstraction.

> 
> Wolfgang.
> 
> 
> > 
> > My preliminary patch looked like this, but I am sure that we need quite a 
> > different solution.
> > 
> > +++ ksrc/arch/powerpc/hal.c	(Arbeitskopie)
> > @@ -81,7 +81,9 @@
> >   */
> >  static void rthal_set_local_cpu_timer(void)
> >  {
> > +#ifndef CONFIG_40x
> >      long ticks;
> > +#endif
> >      rthal_declare_cpuid;
> >  
> >      rthal_load_cpuid();
> > @@ -90,7 +92,7 @@
> >  #ifdef CONFIG_40x
> >      /* Enable and set auto-reload. */
> >      mtspr(SPRN_TCR, mfspr(SPRN_TCR) | TCR_ARE);
> > -    mtspr(SPRN_PIT, __ipipe_decr_ticks);
> > +    mtspr(SPRN_PIT, __ipipe_decr_ticks * 400); /* TODO: How do we get this 
> > value from the board info */
> >  #else /* !CONFIG_40x */
> >      ticks = (long)(__ipipe_decr_next[cpuid] - __ipipe_read_timebase());
> >      set_dec(ticks > 0 ? ticks : 0);
> > Index: ksrc/arch/powerpc/patches/adeos-ipipe-2.6.14-ppc-1.4-00.patch
> > ===================================================================
> > --- ksrc/arch/powerpc/patches/adeos-ipipe-2.6.14-ppc-1.4-00.patch	(Revision 
> > 1650)
> > +++ ksrc/arch/powerpc/patches/adeos-ipipe-2.6.14-ppc-1.4-00.patch	
> > (Arbeitskopie)
> > @@ -3581,7 +3581,8 @@
> >  +#ifdef CONFIG_40x
> >  +	/* Enable and set auto-reload. */
> >  +	mtspr(SPRN_TCR, mfspr(SPRN_TCR) | TCR_ARE);
> > -+	mtspr(SPRN_PIT, __ipipe_decr_ticks);
> > ++	mtspr(SPRN_PIT, __ipipe_decr_ticks * 400 ); /* TODO: How do we get this 
> > value from the board info */
> > +
> >  +#else	/* !CONFIG_40x */
> >  +	__ipipe_decr_next[cpuid] = __ipipe_read_timebase() + __ipipe_decr_ticks;
> >  +	set_dec(__ipipe_decr_ticks);
> > 
> > Best regards
> > 
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



