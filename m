MIME-Version: 1.0
In-Reply-To: <50453DCE.5020601@xenomai.org>
References: <CAHue_TVRdTsre3E7NxHtb=6XfxkL7_36nsLLxSkiF3kUJAJ5Vw@mail.gmail.com>
	<5022B5E4.7040101@xenomai.org>
	<CAHue_TWodrVNxhsxXZ6_xcOGWHDqVGe41qbY0=R3RhFjBedG+g@mail.gmail.com>
	<50339840.1070202@xenomai.org>
	<CAHue_TVSGuatTqL4fRFoOABo4KTm8dFPmRFp7QJNmpk=ZU7NtQ@mail.gmail.com>
	<CAHue_TUKTiusLqfXK59O+PVoxONKAE2xQyBYOgjDh=dZZ2-b3w@mail.gmail.com>
	<504503DC.4040908@xenomai.org>
	<CAHue_TX3+pr39Mso1SXA83NWVRNoeocD-zDcLPk5mKn-XCkQKQ@mail.gmail.com>
	<50453DCE.5020601@xenomai.org>
Date: Thu, 6 Sep 2012 10:00:54 +0200
Message-ID: <CAHue_TUfY4f4CdCXyEYQ5mPFNiCazwZLgv9yy29W5r78tfftYA@mail.gmail.com>
From: =?ISO-8859-2?Q?Marcin_Ku=B6ka?= <marckuska@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Cortex-a9 - please fix xenomai-fix-lfs-issue.patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> Well, maybe some kernel debug option causes an issue.
>

> Please try disabling oprofile, tracepoints and profiling.
>

oprofile and profiling disabled - tracepoints not set

Never tested that on ARM, always run with VMSPLIT_3G.
>

Changed.


> Disable FTRACE. You should also remove all these kernel debugging
> options, they probably have nothing to do with the issue you are seeing.
>

ftrace disabled and all debug options also.

After disabling all the debugs the xeno-test with a dohell test looks like
this:

(...)

=3D=3D Testing FPU check routines...

d0: 1 !=3D 2

d1: 1 !=3D 2

d2: 1 !=3D 2

d3: 1 !=3D 2

d4: 1 !=3D 2

d5: 1 !=3D 2

d6: 1 !=3D 2

d7: 1 !=3D 2

d8: 1 !=3D 2

d9: 1 !=3D 2

d10: 1 !=3D 2

d11: 1 !=3D 2

d12: 1 !=3D 2

d13: 1 !=3D 2

d14: 1 !=3D 2

d15: 1 !=3D 2

=3D=3D FPU check routines: OK.

=3D=3D Threads: sleeper_ufps0-0 rtk0-1 rtk0-2 rtk_fp0-3 rtk_fp0-4
rtk_fp_ufpp0-5 rtk_fp_ufpp0-6 rtup0-7 rtup0-8 rtup_ufpp0-9 rtup_ufpp0-10
rtus0-11 rtus0-12 rtus_ufps0-13 rtus_ufps0-14 rtuo0-15 rtuo0-16
rtuo_ufpp0-17 rtuo_ufpp0-18 rtuo_ufps0-19 rtuo_ufps0-20 rtuo_ufpp_ufps0-21
rtuo_ufpp_ufps0-22

As you said "A Cortex-A9 (in MP mode) should use the "global timer" clock
source," but in the startup log the twd_timer_setup return a "no clock
found" message.

The code in smp_twd.c:

if (twd_clk =3D=3D NULL) {
        twd_clk =3D clk_get(NULL, "smp_twd");
        if (IS_ERR(twd_clk))
            pr_warn("%s: no clock found\n", __func__);
        else
            clk_enable(twd_clk);
    }

That's probably because the clock is not registered in v2m.c (as I suppose
it should be). The initialization function looks like this:

static void __init v2m_timer_init(void)
{
    u32 scctrl;

    /* Select 1MHz TIMCLK as the reference clock for SP804 timers */
    scctrl =3D readl(MMIO_P2V(V2M_SYSCTL + SCCTRL));
    scctrl |=3D SCCTRL_TIMEREN0SEL_TIMCLK;
    scctrl |=3D SCCTRL_TIMEREN1SEL_TIMCLK;
    writel(scctrl, MMIO_P2V(V2M_SYSCTL + SCCTRL));

    writel(0, MMIO_P2V(V2M_TIMER0) + TIMER_CTRL);
    writel(0, MMIO_P2V(V2M_TIMER1) + TIMER_CTRL);

    sp804_clocksource_init(MMIO_P2V(V2M_TIMER1), V2M_TIMER1, "v2m-timer1");
    sp804_clockevents_init(MMIO_P2V(V2M_TIMER0),
IRQ_V2M_TIMER0,"v2m-timer0");
}

I'm not sure about what addresses should I pass to sp804_clocksource_init()
and sp804_clockevents_init() functions. I tried with v2m-timer2 but it
didn't work.

I also added to v2m.c following code:

static struct clk smp_twd =3D {
    .rate   =3D 2000000,
};

and

static struct clk_lookup v2m_lookups[] =3D {

(...)

{    /* SMP timers */
        .dev_id        =3D "smp_twd",
        .con_id        =3D "smp_twd",
        .clk        =3D &smp_twd,
    },
};

I following the I-pipe-core:ArmPorting document.

--=20
Marcin Ku=B6ka
