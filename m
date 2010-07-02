MIME-Version: 1.0
Date: Fri, 2 Jul 2010 13:20:46 -0700
Message-ID: <AANLkTimOQfrs56FSp2JQUWtD7wDACYRmCrX6AF-pU3RC@mail.gmail.com>
From: Jeremy Brown <jhbrown@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] kernel warnings and oopses calling gpiolib functions
	from xenomai kernel space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

We're having what we suspect are related problems with two simple
xenomai experiments.  Has anyone here seen these, and/or have a
workaround?

---------------
Problem 1:

Trying to set the value of a GPIO pin from a periodic RT task in a
kernel module, we're getting a kernel warning.  (This is on an
ARM-based BeagleBoard.)   The task function is simple:
void timer_func(void* arg) {
  rt_task_set_periodic(NULL, TM_NOW, (period_usecs / 2) * 1000LL);
  while (1) {
    rt_task_wait_period(NULL);
    output_value = !output_value;
    gpio_set_value(gpio_out, output_value);
  }
}

The warning is:
[ 1411.807952] ------------[ cut here ]------------
[ 1411.812652] WARNING: at kernel/sched.c:5377 gpio_set+0x38/0xac()
[ 1411.818695] Modules linked in: xk_gpio_writer mailbox_mach rtc_twl
pegasus mailbox rtc_core sg [last unloaded: xuk_gpio_driver]
[ 1411.830383] [<c00448d0>] (unwind_backtrace+0x0/0xe8) from
[<c006bce0>] (warn_slowpath_common+0x48/0x60)
[ 1411.839874] [<c006bce0>] (warn_slowpath_common+0x48/0x60) from
[<c0056b18>] (gpio_set+0x38/0xac)
[ 1411.848754] [<c0056b18>] (gpio_set+0x38/0xac) from [<c0321084>]
(__gpio_set_value+0x30/0x34)
[ 1411.857269] [<c0321084>] (__gpio_set_value+0x30/0x34) from
[<bf0411b4>] (timer_func+0x58/0x64 [xk_gpio_writer])
[ 1411.867462] [<bf0411b4>] (timer_func+0x58/0x64 [xk_gpio_writer])
from [<c00c29d8>] (xnarch_thread_trampoline+0x20/0x2c)
[ 1411.878356] [<c00c29d8>] (xnarch_thread_trampoline+0x20/0x2c) from
[<c00c155c>] (__xnpod_schedule+0x290/0x818)
[ 1411.888427] [<c00c155c>] (__xnpod_schedule+0x290/0x818) from
[<ffffffff>] (0xffffffff)
[ 1411.896423] ---[ end trace 3a72a39f63a09558 ]---

We have verified that gpio_cansleep is 0 for the selected GPIO, so it
should be safe to use it from an interrupt context.   We also have a
similar non-xenomai kernel module that uses an hrtimer, and it causes
no warnings.  The period_usecs we use is 7071us for both experiments.

--------------
Problem 2:

Trying to read or set the value of GPIO pins from an RT kernel module
interrupt handler, we get occasional kernel oopses which get
attributed to randomly-selected processes.  We believe this is
happening under heavy IRQ pressure.

The code is:
int irq_func(rtdm_irq_t *irq_handle) {
  int output_value = gpio_get_value(gpio_in);
  gpio_set_value(gpio_out, output_value);
  return RTDM_IRQ_HANDLED;
}

An example oops, which happened to a /bin/sleep process, is:
[16163.048004] Unable to handle kernel paging request at virtual
address 40076f4c
[16163.055328] pgd = c1300000
[16163.058074] [40076f4c] *pgd=86bd6031, *pte=00000000, *ppte=00000000
[16163.064422] Internal error: Oops: 80000007 [#1] PREEMPT
[16163.069671] last sysfs file: /sys/class/gpio/unexport
[16163.074768] Modules linked in: xk_gpio_responder rtc_twl
mailbox_mach pegasus mailbox rtc_core sg [last unloaded:
xuk_gpio_driver]
[16163.086669] CPU: 0    Tainted: G        W   (2.6.33.5-l3rix20100618 #3)
[16163.093353] PC is at 0x40076f4c
[16163.096527] LR is at 0xa5b9
[16163.099334] pc : [<40076f4c>]    lr : [<0000a5b9>]    psr: 20000030
[16163.099334] sp : beaa06e8  ip : 40076f4d  fp : 00000000
[16163.110900] r10: 00000001  r9 : 00000000  r8 : beaa0730
[16163.116180] r7 : 40113c10  r6 : 40113000  r5 : 40113454  r4 : 401135d0
[16163.122741] r3 : 000150f4  r2 : 00000004  r1 : 00000000  r0 : 401135d0
[16163.129333] Flags: nzCv  IRQs on  FIQs on  Mode USER_32  ISA Thumb
Segment user
[16163.136779] Control: 10c5387d  Table: 81300019  DAC: 00000015
[16163.142578] Process sleep (pid: 20005, stack limit = 0xc136e2f0)
[16163.148620] ---[ end trace fb7968b6c29437fc ]---
[16163.153289] note: sleep[20005] exited with preempt_count 1

Again, a similar non-xenomai linux interrupt handler does not seem to
cause this problem under the same IRQ load.

--------------
System info:
uname -a:
"Linux beagleboard 2.6.33-5-l3rix20100618 #3 PREEMPT Fri Jun 18
17:00:34 EDT 2010 armv7l GNU/Linux"
Xenomai version is a git checkout, master branch of
git://xenomai.org/xenomai-2.5.git
commit a85eb493aad1dd9712be657cd397833f2ae8e9e4
committed on 2010-05-26

--------------

Thanks in advance for any and all help!

Jeremy

