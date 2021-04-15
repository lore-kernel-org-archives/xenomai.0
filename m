MIME-Version: 1.0
References: <c78453d7-63ab-f7a5-425f-8ab719e84cb9@siemens.com>
In-Reply-To: <c78453d7-63ab-f7a5-425f-8ab719e84cb9@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 15 Apr 2021 08:54:03 -0400
Message-ID: <CALLqZ8RhA0ZU0zjySM8sPQHh9HWvmK0xasT9GpQ+7JFnCT1MBw@mail.gmail.com>
Subject: Re: Stuck qemuarm target in xenomai-images
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On Thu, Apr 15, 2021 at 8:49 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> Hi Greg,
>
> I debugged a bit between meetings:
>
> (gdb)
> 335             rc =3D dev->set_next_event((unsigned long) clc, dev);
>
> Here we crash in early boot because set_next_event is NULL:
>
> (gdb) p *dev
> $4 =3D {event_handler =3D 0xc03cc2e8 <tick_handle_periodic>, set_next_eve=
nt =3D
> 0x0, set_next_ktime =3D 0x0, next_event =3D 10000000, max_delta_ns =3D
> 34359738352, min_delta_ns =3D 1000, mult =3D 268435456, shift =3D 32,
>   state_use_accessors =3D CLOCK_EVT_STATE_ONESHOT, features =3D 2, retrie=
s =3D
> 0, set_state_periodic =3D 0x0, set_state_oneshot =3D 0x0,
> set_state_oneshot_stopped =3D 0xc0cd1178 <arch_timer_shutdown_virt>,
>   set_state_shutdown =3D 0xc0cd1178 <arch_timer_shutdown_virt>, tick_resu=
me
> =3D 0x0, broadcast =3D 0x0, suspend =3D 0x0, resume =3D 0x0, min_delta_ti=
cks =3D 15,
> max_delta_ticks =3D 2147483647, name =3D 0xc1361bf4 "arch_sys_timer", rat=
ing =3D
> 450,
>   irq =3D 18, bound_on =3D 0, cpumask =3D 0xc0f073f0 <cpu_bit_bitmap+4>, =
list =3D
> {next =3D 0xc17320cc <clockevent_devices>, prev =3D 0xc17320cc
> <clockevent_devices>}, owner =3D 0x0, ipipe_timer =3D 0xef7a6b40, ipipe_s=
tolen
> =3D 0}
> (gdb) bt
> #0  clockevents_program_event (dev=3D0xef7ab340, expires=3D10000000,
> force=3Dfalse) at ../kernel/time/clockevents.c:335
> #1  0xc03cc610 in tick_setup_periodic (broadcast=3D<optimized out>,
> dev=3D<optimized out>) at ../kernel/time/tick-common.c:172
> #2  tick_setup_periodic (dev=3D0xef7ab340, broadcast=3D<optimized out>) a=
t
> ../kernel/time/tick-common.c:149
> #3  0xc03cc8e4 in tick_check_new_device (newdev=3D0xef7ab340) at
> ../kernel/time/tick-common.c:370
> #4  0xc03cb650 in clockevents_register_device (dev=3D0xef7ab340) at
> ../kernel/time/clockevents.c:468
> #5  0xc03cbb54 in clockevents_config_and_register (dev=3D<optimized out>,
> freq=3D<optimized out>, min_delta=3D<optimized out>, max_delta=3D<optimiz=
ed out>)
> at ../kernel/time/clockevents.c:515
> #6  0xc0cd14f4 in __arch_timer_setup (clk=3D<optimized out>, type=3D<opti=
mized
> out>) at ../drivers/clocksource/arm_arch_timer.c:873
> #7  arch_timer_starting_cpu (cpu=3D<optimized out>) at
> ../drivers/clocksource/arm_arch_timer.c:963
> #8  0xc03482b8 in cpuhp_invoke_callback (cpu=3D0,
> state=3DCPUHP_AP_ARM_ARCH_TIMER_STARTING, bringup=3D<optimized out>,
> node=3D<optimized out>, lastp=3D0x0) at ../kernel/cpu.c:173
> #9  0xc0348c28 in cpuhp_invoke_ap_callback (node=3D<optimized out>,
> bringup=3D<optimized out>, state=3D<optimized out>, cpu=3D<optimized out>=
) at
> ../kernel/cpu.c:753
> #10 cpuhp_issue_call (cpu=3D<optimized out>, state=3D<optimized out>,
> bringup=3D<optimized out>, node=3D<optimized out>) at ../kernel/cpu.c:166=
0
> #11 0xc0348f34 in __cpuhp_setup_state_cpuslocked (state=3D<optimized out>=
,
> name=3D<optimized out>, invoke=3D<optimized out>, startup=3D0xc0cd1388
> <arch_timer_starting_cpu>, teardown=3D0xc0cd1244 <arch_timer_dying_cpu>,
>     multi_instance=3D<optimized out>) at ../kernel/cpu.c:1807
> #12 0xc0349128 in __cpuhp_setup_state
> (state=3DCPUHP_AP_ARM_ARCH_TIMER_STARTING, name=3D0xc1361b2c
> "clockevents/arm/arch_timer:starting", invoke=3Dtrue, startup=3D0xc0cd138=
8
> <arch_timer_starting_cpu>, teardown=3D0xc0cd1244 <arch_timer_dying_cpu>,
>     multi_instance=3Dfalse) at ../kernel/cpu.c:1836
> #13 0xc15b1f58 in cpuhp_setup_state (teardown=3D<optimized out>,
> startup=3D<optimized out>, name=3D<optimized out>, state=3D<optimized out=
>) at
> ../include/linux/cpuhotplug.h:213
> #14 arch_timer_register () at ../drivers/clocksource/arm_arch_timer.c:120=
9
> #15 arch_timer_of_init (np=3D<optimized out>) at
> ../drivers/clocksource/arm_arch_timer.c:1386
> #16 0xc15ad7cc in timer_probe () at ../drivers/clocksource/timer-probe.c:=
30
> #17 0xc1500d80 in start_kernel () at ../init/main.c:699
> #18 0x00000000 in ?? ()
> Backtrace stopped: previous frame identical to this frame (corrupt stack?=
)
>
>
> Are we missing some config switch for this virt machine, or is there
> something else in I-pipe broken?
>
> Jan
>
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux


Let me take a quick, look I=E2=80=99m almost back at my desk. I=E2=80=99ll =
get back to you
shortly.

>
>
