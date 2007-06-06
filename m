Message-ID: <4666B6AE.2070209@domain.hid>
Date: Wed, 06 Jun 2007 15:29:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <46649F7E.3060104@domain.hid> <46651F7D.9090702@domain.hid>
	<4666AD52.1050101@domain.hid>
In-Reply-To: <4666AD52.1050101@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH-STACK] Updates, timerstats, rtdm-timers
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
> Jan Kiszka wrote:
> 
>>Jan Kiszka wrote:
>>...
>>
>>>fast-tsc-to-ns-v2.patch
>>>
>>>    [Rebased, improved rounding of least significant digit]
>>
>>Rounding in the fast path for the sake of the last digit was silly.
>>Instead, I'm now addressing the ugly interval printing via
>>xnarch_precise_tsc_to_ns when converting the timer interval back into
>>nanos. -v3 incorporating this has just been uploaded.
>>
> 
> 
> After noticing yesterday that even unpatched Xenomai sometimes converts
> inaccurately when showing small timer intervals under /proc, I just got
> an idea how to address this beautification issue even better: -v4 now
> rounds up in the slow, precise tsc-to-ns path, see
> 
> http://www.rts.uni-hannover.de/rtaddon/patches/xenomai/fast-tsc-to-ns-v4.patch

I am the one who decided of the rounding behaviour of llimd, RTAI
version had the same rounding policy as the one you propose, and I made
it for the following reasons:
- rouding towards 0 is the policy used by the C language, so doing this
for llimd made it consistent with what one expects from C code;
- values computed by llimd are used to program timers, and we prefer the
timer to be programmed for a too short value than for a too long value.

-- 
                                                 Gilles Chanteperdrix

