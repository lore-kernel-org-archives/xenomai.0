Message-ID: <496DEECF.1070407@domain.hid>
Date: Wed, 14 Jan 2009 13:55:27 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <496DEB16.5060803@domain.hid> <496DEDBB.8000204@domain.hid>
In-Reply-To: <496DEDBB.8000204@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Clock drift.
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
Cc: Xenomai core <Xenomai-core@domain.hid>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Hi,
>>
>> I run clocktest on a system here, not running NTP, using
>> CONFIG_GENERIC_CLOCKEVENT, with a systematic drift of 3us/s. How can
>> this happen? Does it come from the error due to the multiply and shift
>> used for tsc to/from ns conversions ?
> 
> What clocksource is used by Linux? Also tsc?

It is an ARM, but yes, the timer used to emulate the tsc is also used by
Linux. Here is the relevant code:

notrace unsigned long long __ipipe_mach_get_tsc(void)
{
        if (likely(ixp4xx_timer_initialized)) {
                union tsc_reg *local_tsc, result;
                unsigned long stamp;

                local_tsc = &tsc[ipipe_processor_id()];

                __asm__ ("ldmia %1, %M0\n":
                         "=r"(result.full): "r"(local_tsc),
"m"(*local_tsc));
                barrier();
                stamp = *IXP4XX_OSTS;
                if (unlikely(stamp < result.low))
                        /* 32 bit counter wrapped, increment high word. */
                        result.high++;
                result.low = stamp;
                return result.full;
        }

        return 0;
}

cycle_t ixp4xx_get_cycles(void)
{
        return *IXP4XX_OSTS;
}

static struct clocksource clocksource_ixp4xx = {
        .name           = "OSTS",
        .rating         = 200,
        .read           = ixp4xx_get_cycles,
        .mask           = CLOCKSOURCE_MASK(32),
        .shift          = 20,
        .flags          = CLOCK_SOURCE_IS_CONTINUOUS,
};

unsigned long ixp4xx_timer_freq = FREQ;
static int __init ixp4xx_clocksource_init(void)
{
        clocksource_ixp4xx.mult =
                clocksource_hz2mult(ixp4xx_timer_freq,
                                    clocksource_ixp4xx.shift);
        clocksource_register(&clocksource_ixp4xx);

        return 0;
}


-- 
                                                 Gilles.

