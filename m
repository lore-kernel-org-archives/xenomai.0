Subject: Re: Stuck qemuarm target in xenomai-images
References: <c78453d7-63ab-f7a5-425f-8ab719e84cb9@siemens.com>
 <CALLqZ8RhA0ZU0zjySM8sPQHh9HWvmK0xasT9GpQ+7JFnCT1MBw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a14e1419-74a9-9282-6800-d1abcd7e167a@siemens.com>
Date: Fri, 16 Apr 2021 08:39:41 +0200
MIME-Version: 1.0
In-Reply-To: <CALLqZ8RhA0ZU0zjySM8sPQHh9HWvmK0xasT9GpQ+7JFnCT1MBw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: Xenomai <xenomai@xenomai.org>

On 15.04.21 14:54, Greg Gallagher wrote:
> 
> 
> On Thu, Apr 15, 2021 at 8:49 AM Jan Kiszka <jan.kiszka@siemens.com
> <mailto:jan.kiszka@siemens.com>> wrote:
> 
>     Hi Greg,
> 
>     I debugged a bit between meetings:
> 
>     (gdb)
>     335             rc = dev->set_next_event((unsigned long) clc, dev);
> 
>     Here we crash in early boot because set_next_event is NULL:
> 
>     (gdb) p *dev
>     $4 = {event_handler = 0xc03cc2e8 <tick_handle_periodic>,
>     set_next_event = 0x0, set_next_ktime = 0x0, next_event = 10000000,
>     max_delta_ns = 34359738352, min_delta_ns = 1000, mult = 268435456,
>     shift = 32,
>       state_use_accessors = CLOCK_EVT_STATE_ONESHOT, features = 2,
>     retries = 0, set_state_periodic = 0x0, set_state_oneshot = 0x0,
>     set_state_oneshot_stopped = 0xc0cd1178 <arch_timer_shutdown_virt>,
>       set_state_shutdown = 0xc0cd1178 <arch_timer_shutdown_virt>,
>     tick_resume = 0x0, broadcast = 0x0, suspend = 0x0, resume = 0x0,
>     min_delta_ticks = 15, max_delta_ticks = 2147483647, name =
>     0xc1361bf4 "arch_sys_timer", rating = 450,
>       irq = 18, bound_on = 0, cpumask = 0xc0f073f0 <cpu_bit_bitmap+4>,
>     list = {next = 0xc17320cc <clockevent_devices>, prev = 0xc17320cc
>     <clockevent_devices>}, owner = 0x0, ipipe_timer = 0xef7a6b40,
>     ipipe_stolen = 0}
>     (gdb) bt
>     #0  clockevents_program_event (dev=0xef7ab340, expires=10000000,
>     force=false) at ../kernel/time/clockevents.c:335
>     #1  0xc03cc610 in tick_setup_periodic (broadcast=<optimized out>,
>     dev=<optimized out>) at ../kernel/time/tick-common.c:172
>     #2  tick_setup_periodic (dev=0xef7ab340, broadcast=<optimized out>)
>     at ../kernel/time/tick-common.c:149
>     #3  0xc03cc8e4 in tick_check_new_device (newdev=0xef7ab340) at
>     ../kernel/time/tick-common.c:370
>     #4  0xc03cb650 in clockevents_register_device (dev=0xef7ab340) at
>     ../kernel/time/clockevents.c:468
>     #5  0xc03cbb54 in clockevents_config_and_register (dev=<optimized
>     out>, freq=<optimized out>, min_delta=<optimized out>,
>     max_delta=<optimized out>) at ../kernel/time/clockevents.c:515
>     #6  0xc0cd14f4 in __arch_timer_setup (clk=<optimized out>,
>     type=<optimized out>) at ../drivers/clocksource/arm_arch_timer.c:873
>     #7  arch_timer_starting_cpu (cpu=<optimized out>) at
>     ../drivers/clocksource/arm_arch_timer.c:963
>     #8  0xc03482b8 in cpuhp_invoke_callback (cpu=0,
>     state=CPUHP_AP_ARM_ARCH_TIMER_STARTING, bringup=<optimized out>,
>     node=<optimized out>, lastp=0x0) at ../kernel/cpu.c:173
>     #9  0xc0348c28 in cpuhp_invoke_ap_callback (node=<optimized out>,
>     bringup=<optimized out>, state=<optimized out>, cpu=<optimized out>)
>     at ../kernel/cpu.c:753
>     #10 cpuhp_issue_call (cpu=<optimized out>, state=<optimized out>,
>     bringup=<optimized out>, node=<optimized out>) at ../kernel/cpu.c:1660
>     #11 0xc0348f34 in __cpuhp_setup_state_cpuslocked (state=<optimized
>     out>, name=<optimized out>, invoke=<optimized out>,
>     startup=0xc0cd1388 <arch_timer_starting_cpu>, teardown=0xc0cd1244
>     <arch_timer_dying_cpu>,
>         multi_instance=<optimized out>) at ../kernel/cpu.c:1807
>     #12 0xc0349128 in __cpuhp_setup_state
>     (state=CPUHP_AP_ARM_ARCH_TIMER_STARTING, name=0xc1361b2c
>     "clockevents/arm/arch_timer:starting", invoke=true,
>     startup=0xc0cd1388 <arch_timer_starting_cpu>, teardown=0xc0cd1244
>     <arch_timer_dying_cpu>,
>         multi_instance=false) at ../kernel/cpu.c:1836
>     #13 0xc15b1f58 in cpuhp_setup_state (teardown=<optimized out>,
>     startup=<optimized out>, name=<optimized out>, state=<optimized
>     out>) at ../include/linux/cpuhotplug.h:213
>     #14 arch_timer_register () at
>     ../drivers/clocksource/arm_arch_timer.c:1209
>     #15 arch_timer_of_init (np=<optimized out>) at
>     ../drivers/clocksource/arm_arch_timer.c:1386
>     #16 0xc15ad7cc in timer_probe () at
>     ../drivers/clocksource/timer-probe.c:30
>     #17 0xc1500d80 in start_kernel () at ../init/main.c:699
>     #18 0x00000000 in ?? ()
>     Backtrace stopped: previous frame identical to this frame (corrupt
>     stack?)
> 
> 
>     Are we missing some config switch for this virt machine, or is there
>     something else in I-pipe broken?
> 
>     Jan
> 
>     -- 
>     Siemens AG, T RDA IOT
>     Corporate Competence Center Embedded Linux
> 
> 
> Let me take a quick, look I’m almost back at my desk. I’ll get back to
> you shortly.
> 
> 

I compared arm_arch_timer.c to the upstream version and spotted 
something which I would consider a mismerge of the I-pipe patch:

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 6da6a12f6e2f..e6fc1c7e5fc8 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -838,18 +838,7 @@ static void __arch_timer_setup(unsigned type,
 			BUG();
 		}
 
-		arch_timer_check_ool_workaround(ate_match_local_cap_id, NULL);
-#ifdef CONFIG_IPIPE
-		clk->ipipe_timer = raw_cpu_ptr(&arch_itimer);
-		if (arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI) {
-			clk->ipipe_timer->irq = arch_timer_ppi[ARCH_TIMER_VIRT_PPI];
-			clk->ipipe_timer->ack = arch_itimer_ack_virt;
-		} else {
-			clk->ipipe_timer->irq = arch_timer_ppi[ARCH_TIMER_PHYS_SECURE_PPI];
-			clk->ipipe_timer->ack = arch_itimer_ack_phys;
-		}
-		clk->ipipe_timer->freq = arch_timer_rate;
-#endif
+		clk->set_next_event = sne;
 	} else {
 		clk->features |= CLOCK_EVT_FEAT_DYNIRQ;
 		clk->name = "arch_mem_timer";

With that, I'm able to boot now.

Please double-check that file. I'll throw that hunk into CI now.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

