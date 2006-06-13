Message-ID: <448EB038.8070802@domain.hid>
Date: Tue, 13 Jun 2006 14:31:52 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] ns vs. tsc as internal timer base
References: <448E98A3.6080707@domain.hid> <448E9E8B.70809@domain.hid>
	<448EA7F7.5000802@domain.hid>
In-Reply-To: <448EA7F7.5000802@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>Jan Kiszka wrote:
>>
>>>Hi,
>>>
>>>between some football half-times of the last days ;), I played a bit
>>>with a hand-optimised xnarch_tsc_to_ns() for x86. Using scaled math, I
>>>achieved between 3 (P-I 133 MHz) to 4 times (P-M 1.3 GHz) faster
>>>conversions than with the current variant. While this optimisation only
>>>saves a few ten nanoseconds on high-end, slow processors can gain
>>>several hundreds of nanos per conversion (my P-133: -600 ns).
>>>
>>
>>I did exactely the same a few weeks ago, based on Anzinger's scaled math
> 
> 
> :) We should coordinate better.
> 

The answer is published roadmap + todo list, but this requires some 
organisation we have not been able to setup yet.

> 
>>from i386/kernel/timers/timer_tsc.c. And indeed, I had x 20 performance
>>improvements in some cases.
> 
> 
> Oops, that sounds like a bit too extreme optimisations. Is the original
> version varying that much? I didn't observe this.
> 
> Here is my current version, BTW:
> 
> long tsc_scale;
> unsigned int tsc_shift = 31;
> 
> static inline long long fast_tsc_to_ns(long long ts)
> {
>     long long ret;
> 
>     __asm__ (
>         /* HI = HIWORD(ts) * tsc_scale */
>         "mov  %%eax,%%ebx\n\t"
>         "mov  %%edx,%%eax\n\t"
>         "imull %2\n\t"
>         "mov  %%eax,%%esi\n\t"
>         "mov  %%edx,%%edi\n\t"
> 
>         /* LO = LOWORD(ts) * tsc_scale */
>         "mov  %%ebx,%%eax\n\t"
>         "mull %2\n\t"
> 
>         /* ret = (HI << 32) + LO */
>         "add  %%esi,%%edx\n\t"
>         "adc  $0,%%edi\n\t"
> 
>         /* ret = ret >> tsc_shift */
>         "shrd %%cl,%%edx,%%eax\n\t"
>         "shrd %%cl,%%edi,%%edx\n\t"
>         : "=A"(ret)
>         : "A" (ts), "m" (tsc_scale), "c" (tsc_shift)
>         : "ebx", "esi", "edi");
> 
>     return ret;
> }
> 
> void init_tsc(unsigned long cpu_freq)
> {
>     unsigned long long scale;
> 
>     while (1) {
>         scale = do_div(1000000000LL << tsc_shift, cpu_freq);
>         if (scale <= 0x7FFFFFFF)
>             break;
>         tsc_shift--;
>     }
>     tsc_scale = scale;
> }
> 
> This version will use 31 (GHz cpu_freq) to 26 (~32 MHz) shifts, i.e. a
> bit more than the Linux kernel's 22 bits.
>

Here is likely why we have different levels of accuracy and performance, 
  firstly my version is bluntly based on the khz freq, secondly it 
calculates the other way around, i.e. ns2tsc, so that tsc are keep in 
the inner code, but more efficiently converted from ns counts passed to 
the outer interface:

static unsigned long ns2cyc_scale;
#define NS2CYC_SCALE_FACTOR 10 /* 2^10, carefully chosen */

static inline void set_ns2cyc_scale(unsigned long cpu_khz)
{
     ns2cyc_scale = (cpu_khz << NS2CYC_SCALE_FACTOR) / 1000000;
}

static inline unsigned long long ns_2_cycles(unsigned long long ns)
{
     return ns * ns2cyc_scale >> NS2CYC_SCALE_FACTOR;
}

>>
>>TSC are not the whole nucleus time base, but only the timer management
>>one. The motivation to use TSCs in nucleus/timer.c was to pick a unit
>>which would not require any conversion beyond the initial one in
>>xntimer_start.
> 
> 
> That helps strictly periodic application timers, not aperiodic ones like
> timeouts.
>

It depends, periodic timers usually exhibit larger delays, so the gain 
is more significant with oneshot timings incurring smaller delays, hence 
a higher number of calculations.

> 
>>>Any pitfalls down the road (except introducing regressions)?
>>
>>Well, pitfalls expected from changing the core idea of time of the timer
>>management code... :o>
>>
> 
> You mean turning
> 
> rthal_timer_program_shot(rthal_imuldiv(delay,RTHAL_TIMER_FREQ,RTHAL_CPU_FREQ));
> 
> into
> 
> rthal_timer_program_shot(rthal_imuldiv(delay,RTHAL_TIMER_FREQ,1000000000));
> 

Not really, it was a general remark about changing a code that might 
have some assumtions on using TSCs. Additionally, only x86 needs to 
rescale TSC values to the timer frequency, other archs use the same unit 
on both sides, and such unit might even have nothing to do with any CPU 
accounting (e.g. blackfin uses a free running timer, ppc uses the 
internal timebase, etc).

This said, it should not have that many assumptions, and in any case, 
they should be confined to nucleus/timers.c. I think we should give this 
kind of optimization a try.

-- 

Philippe.

