MIME-Version: 1.0
In-Reply-To: <44k2rqz38u.fsf@be-well.ilk.org>
References: <CAFkYNwaqLYu7vAAyAt6Q9qfKL4iBa+N1BuzgJWhN6z4NfA5U=g@mail.gmail.com>
 <44k2rqz38u.fsf@be-well.ilk.org>
Date: Fri, 18 Sep 2015 01:02:53 +1200
Message-ID: <CAFkYNwYJ7ah+U97Pwuqwf9Phg=J0rTjr1txfGtg0FuoN2oP7cg@mail.gmail.com>
From: vibnwis <vibnwis@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Error code -19
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lowell Gilbert <kludge@be-well.ilk.org>
Cc: xenomai@xenomai.org

I tried my best to understand what is being described in

----------------------
The Cortex-A9 case.
Starting with Linux 3.8, this clock frequency may be passed through the
device tree if the smp_twd timer is registered through the device tree. If
the timer is registered statically, starting with Linux 3.3 the smp_twd
timer could get the frequency from a clock named =E2=80=9Csmp_twd=E2=80=9D.
------------------------
Here are things I found in my LInux kernel source.

"smp_twd.c"

static void twd_timer_setup(void) {
struct clock_event_device *clk =3D __this_cpu_ptr(twd_evt);
----------
#if defined(CONFIG_IPIPE) && defined(CONFIG_SMP)
    printk(KERN_INFO "I-pipe, %lu.%03lu MHz timer\n",
           twd_timer_rate / 1000000,
           (twd_timer_rate % 1000000) / 1000);
    clk->ipipe_timer =3D __this_cpu_ptr(&twd_itimer);
    clk->ipipe_timer->irq =3D clk->irq;
    clk->ipipe_timer->ack =3D twd_ack;
    clk->ipipe_timer->min_delay_ticks =3D 0xf;
#endif
----------
}

".config"
CONFIG_HAVE_SMP=3Dy
CONFIG_SMP=3Dy          <---- Enabled
CONFIG_SMP_ON_UP=3Dy

....

# CONFIG_ARM_PSCI is not set
CONFIG_ARCH_NR_GPIO=3D512
CONFIG_IPIPE=3Dy          <---- Enabled
# CONFIG_IPIPE_LEGACY is not set


smp_twd.c
#if defined(CONFIG_IPIPE) && defined(CONFIG_SMP)
    printk(KERN_INFO "I-pipe, %lu.%03lu MHz timer\n",
           twd_timer_rate / 1000000,
           (twd_timer_rate % 1000000) / 1000);
    clk->ipipe_timer =3D __this_cpu_ptr(&twd_itimer);
    clk->ipipe_timer->irq =3D clk->irq;
    clk->ipipe_timer->ack =3D twd_ack;
    clk->ipipe_timer->min_delay_ticks =3D 0xf;
#endif

CONFIG_HAVE_SMP=3Dy
CONFIG_SMP=3Dy          <---- Enabled
CONFIG_SMP_ON_UP=3Dy

....

# CONFIG_ARM_PSCI is not set
CONFIG_ARCH_NR_GPIO=3D512
CONFIG_IPIPE=3Dy          <---- Enabled
# CONFIG_IPIPE_LEGACY is not set

twd_timer_setup(void) has been registered.

However, I could not the timer is passed through device tree
"omap4-panda-es.dts", but I found the following, in omap4.dtsi. omap4.dtsi
is "included" in omap4460,dtsi.

local-timer@48240600 {
        compatible =3D "arm,cortex-a9-twd-timer";
        clocks =3D <&mpu_periphclk>;
        reg =3D <0x48240600 0x20>;
        interrupts =3D <GIC_PPI 13 (GIC_CPU_MASK_RAW(3) |
IRQ_TYPE_LEVEL_HIGH)>;
    };

"omap4-panda-es.dts"
#include "omap4460.dtsi
#include "omap4-panda-common.dtsi"
...............

However, I don't quite understand it thoroughly, Hence, I can really tell
if these are ok.

Can anyone help what could possibly go wrong my my Xenomai, please?




On 17 September 2015 at 05:24, Lowell Gilbert <kludge@be-well.ilk.org>
wrote:

> vibnwis <vibnwis@gmail.com> writes:
>
> > I am a newbie and I believe code -19 has been asked before.
>
> That is just reporting ENODEV.
>
> It doesn't tell you much, although it usually means a missing timer.
>
> > My system is made of
> >
> > arch =3D arm
> > board =3D PandaBoard ES
> > Kernel =3D 3.18.12
> > Patch  =3D
> > xenomai-3/kernel/cobalt/arch/arm/patches/ipipe-core-3.18.12-arm-4.patch
> >
> > output of dmesg | grep -i xenomai:
> > [    1.733825] [Xenomai] scheduling class idle registered.
> > [    1.733856] [Xenomai] scheduling class rt registered.
> > [    1.734588] [Xenomai] init failed, code -19
>
> If I-pipe reports finding a suitable timer, it may just be having
> problems registering it. Look for I-pipe and scheduler messages in your
> boot log.
>
> Your board has some kind of OMAP processor. It's a Cortex-A9 CPU core,
> so it should work without much problem. The example at
>
> http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/#=
The_Cortex-A9_case
> is dealing with an extremely similar chip.
>
