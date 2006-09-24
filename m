Message-ID: <4516F39A.7040603@domain.hid>
Date: Sun, 24 Sep 2006 23:07:38 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Problem with periodic timer on PPC40x solved
References: <200609232013.27649.niklaus.giger@domain.hid>
	<45159F4F.3010805@domain.hid>
	<200609242247.57024.niklaus.giger@domain.hid>
In-Reply-To: <200609242247.57024.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

Niklaus Giger wrote:
> Am Samstag, 23. September 2006 22:55 schrieb Wolfgang Grandegger:
>> Hi Niklaus,
>>
>> Niklaus Giger wrote:
> <..>
>>          if (flags & IPIPE_RESET_TIMER)
>>                  ticks = tb_ticks_per_jiffy;
>>          else {
>>                  ticks = ns * tb_ticks_per_jiffy / (1000000000 / HZ);
>>   		^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>                  if (ticks > tb_ticks_per_jiffy)
>>                          return -EINVAL;
> <..>
>> Does replacing the calculation of ticks with
>>
>>          ticks = ns * (tb_ticks_per_jiffy / 10000) / (100000 / HZ);
>>
>> help. A proper calculation might use mulhwu or rthal_imuldiv.
> Yes. I does. There are two occurrences fixed with the attached patch (+ one 
> small ifdef to eliminate a compiler warning in the PPC40x case).
> Timing is okay as tested with a small vxworks test program.
> 
> Could someone please apply it?
> 
> Thanks for your cooperation. 
> 
> Best regards
> 
> 
> 
> ------------------------------------------------------------------------
> 
> Index: ksrc/arch/powerpc/patches/adeos-ipipe-2.6.14-ppc-1.4-00.patch
> ===================================================================
> --- ksrc/arch/powerpc/patches/adeos-ipipe-2.6.14-ppc-1.4-00.patch	(Revision 1650)
> +++ ksrc/arch/powerpc/patches/adeos-ipipe-2.6.14-ppc-1.4-00.patch	(Arbeitskopie)
> @@ -3595,7 +3595,7 @@
>  +	if (flags & IPIPE_RESET_TIMER)
>  +		ticks = tb_ticks_per_jiffy;
>  +	else {
> -+		ticks = ns * tb_ticks_per_jiffy / (1000000000 / HZ);
> ++		ticks = ns * (tb_ticks_per_jiffy / 10000) / (100000 / HZ);
>  +
>  +		if (ticks > tb_ticks_per_jiffy)
>  +			return -EINVAL;
> Index: ksrc/arch/powerpc/hal.c
> ===================================================================
> --- ksrc/arch/powerpc/hal.c	(Revision 1650)
> +++ ksrc/arch/powerpc/hal.c	(Arbeitskopie)
> @@ -81,7 +81,9 @@
>   */
>  static void rthal_set_local_cpu_timer(void)
>  {
> +#ifndef CONFIG_40x
>      long ticks;
> +#endif
>      rthal_declare_cpuid;
>  
>      rthal_load_cpuid();
> @@ -110,7 +112,7 @@
>      if (ns == 0)
>          ticks = tb_ticks_per_jiffy;
>      else {
> -        ticks = ns * tb_ticks_per_jiffy / (1000000000 / HZ);
> +	ticks = ns * (tb_ticks_per_jiffy / 10000) / (100000 / HZ);
>  
>          if (ticks > tb_ticks_per_jiffy) {
>              DBG("rthal_set_cpu_timers_unsafe: -EINVAL (%lu)\n", ticks);

My suggested fix was just to locate the source of the problem. As 
Philippe suggested, we should use mulhwu (or mulhwu_scale_factor). Have 
a look to arch/ppc/kernel/time.c for further information.

Wolfgang.

