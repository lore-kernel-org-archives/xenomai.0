Message-ID: <536A7341.9050007@xenomai.org>
Date: Wed, 07 May 2014 19:54:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <53661901.8090400@cantastic.org> <53666383.9010302@xenomai.org>
 <536741B1.8010800@cantastic.org> <53676D14.4050502@xenomai.org>
 <536775E4.3080309@cantastic.org> <536779B2.9090506@xenomai.org>
 <536A6B76.5070503@cantastic.org>
In-Reply-To: <536A6B76.5070503@cantastic.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Testing on Freescale i.MX6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?UmFsZiBSw7ZzY2g=?= <xenomai@cantastic.org>, xenomai@xenomai.org

On 05/07/2014 07:20 PM, Ralf Rösch wrote:
>
> Am 05.05.2014 13:44, schrieb Gilles Chanteperdrix:
>> Unfortunately, I have not experienced the high latencies myself,
>> probably because I tested the system without display. Anyway, from
>> what I understood, if you want good latencies, you have to disable the
>> L2 cache write-allocate policy.
>>
> which is default in >= 3.10?

It is modified in the git for 3.10, but the patch has not been generated 
I believe.

> I found a hack which solves my problem:
>
> diff --git a/arch/arm/kernel/ipipe_tsc.c b/arch/arm/kernel/ipipe_tsc.c
> index 4eb5050..f759a20 100644
> --- a/arch/arm/kernel/ipipe_tsc.c
> +++ b/arch/arm/kernel/ipipe_tsc.c
> @@ -132,6 +132,11 @@ void __init __ipipe_tsc_register(struct
> __ipipe_tscinfo *info)
>                              (unsigned long)(tsc_area + 0x80));
>           hard_local_irq_restore(flags);
>
> +#ifdef CONFIG_CPU_FREQ_GOV_PERFORMANCE
> +       if (registered)
> +               tsc_info.freq = 498000000;
> +#endif
> +
>           printk(KERN_INFO "I-pipe, %u.%03u MHz clocksource\n",
>                  tsc_info.freq / 1000000, (tsc_info.freq % 1000000) / 1000);
>           if (!registered)

To do the same thing cleanly, you should call ipipe_tsc_register again 
when the frequency changes, unfortunately, it does not fix the timer 
frequency, so, you will experience a lot of useless timer interrupts.
IOW, the problem is not really solved. The best workaround I found for 
the freescale kernel 3.0 is to start the processor directly with the 
target frequency (people want fast boots usually, so booting with the 
highest frequency makes more sense anyway), this also avoids having to 
enable cpufreq. Which is why I told you to look at this patch for the 
solution to your problem.

> In Kernel 3.10 (Freescale) I did not observe this type of error (i have
> tested for about 2 days).
> Do you know how much the max. latency could be involved when this sort
> of error is triggered?

This error probably has nothing to do with latency (interrupt latency or 
scheduling latency, as returned by cyclictest or the latency test as 
what we mean on this list when we say latency without precising latency 
of what). You may want to look at the freescale kernel to see if it does 
not have any patch regarding mmc.

>
> [3]
> BTW i have attached an other patch which might be helpful.

Thanks, will merge.



-- 
					    Gilles.

