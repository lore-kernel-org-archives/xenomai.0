MIME-Version: 1.0
In-Reply-To: <f8c0c8df-59ae-996f-2ed3-3c3c5ccb6331@xenomai.org>
References: <CADXNiGUNiEC9MaOWTc3UBCNaBMRp2SHbbJ4dsq379QpToBvGcw@mail.gmail.com>
 <f8c0c8df-59ae-996f-2ed3-3c3c5ccb6331@xenomai.org>
From: Jackson Jones <jackson.jones@gmail.com>
Date: Mon, 6 Aug 2018 11:27:13 -0700
Message-ID: <CADXNiGXuuB0-L8W0DwAVExAtVEo2p2h4Db1x_tOFwn0g8TQq3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] System Lockup while idle
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

I tried tried unsetting CONFIG_NO_HZ_IDLE (which sets the
CONFIG_HZ_PERIODIC option), but our app still hung after a while. Below is
our Timer Subsystem configuration, I also put in a snipplet of our code
assigning affinity to tasks:

Our timer subsystem configuration:
#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y

const int XENOMAI_TASK_STACK_SIZE = 0xA0000;
const int XENOMAI_TASK_MODE = 0;
cpu_set_t cpu_mask;

CPU_ZERO(&cpu_mask);
CPU_SET(0,&cpu_mask);
rt_task_spawn(&task1, task1_name, XENOMAI_TASK_STACK_SIZE, 26,
XENOMAI_TASK_MODE, task1_func, NULL);
rt_task_set_affinity(&task1, &cpu_mask);

CPU_ZERO(&cpu_mask);
CPU_SET(0,&cpu_mask);
rt_task_spawn(&task2, task2_name, XENOMAI_TASK_STACK_SIZE, 15,
XENOMAI_TASK_MODE, task2_func, NULL);
rt_task_set_affinity(&task2, &cpu_mask);

CPU_ZERO(&cpu_mask);
CPU_SET(0,&cpu_mask);
rt_task_spawn(&task2, task3_name, XENOMAI_TASK_STACK_SIZE, 23,
XENOMAI_TASK_MODE, task3_func, NULL);
rt_task_set_affinity(&task3, &cpu_mask);

CPU_ZERO(&cpu_mask);
CPU_SET(0,&cpu_mask);
rt_task_spawn(&task2, task4_name, XENOMAI_TASK_STACK_SIZE, 21,
XENOMAI_TASK_MODE, task4_func, NULL);
rt_task_set_affinity(&task4, &cpu_mask);

CPU_ZERO(&cpu_mask);
CPU_SET(1,&cpu_mask);
rt_task_spawn(&task2, task5_name, XENOMAI_TASK_STACK_SIZE, 56,
XENOMAI_TASK_MODE, task5_func, NULL);
rt_task_set_affinity(&task5, &cpu_mask);

CPU_ZERO(&cpu_mask);
CPU_SET(1,&cpu_mask);
rt_task_spawn(&task2, task6_name, XENOMAI_TASK_STACK_SIZE, 54,
XENOMAI_TASK_MODE, task6_func, NULL);
rt_task_set_affinity(&task6, &cpu_mask);

CPU_ZERO(&cpu_mask);
CPU_SET(1,&cpu_mask);
rt_task_spawn(&task2, task7_name, XENOMAI_TASK_STACK_SIZE, 66,
XENOMAI_TASK_MODE, task7_func, NULL);
rt_task_set_affinity(&task7, &cpu_mask);

CPU_ZERO(&cpu_mask);
CPU_SET(2,&cpu_mask);
rt_task_spawn(&task2, task8_name, XENOMAI_TASK_STACK_SIZE, 71,
XENOMAI_TASK_MODE, task8_func, NULL);
rt_task_set_affinity(&task8, &cpu_mask);

CPU_ZERO(&cpu_mask);
CPU_SET(2,&cpu_mask);
rt_task_spawn(&task2, task9_name, XENOMAI_TASK_STACK_SIZE, 70,
XENOMAI_TASK_MODE, task9_func, NULL);
rt_task_set_affinity(&task9, &cpu_mask);

CPU_ZERO(&cpu_mask);
CPU_SET(2,&cpu_mask);
rt_task_spawn(&task2, task10_name, XENOMAI_TASK_STACK_SIZE, 60,
XENOMAI_TASK_MODE, task10_func, NULL);
rt_task_set_affinity(&task10, &cpu_mask);

CPU_ZERO(&cpu_mask);
CPU_SET(2,&cpu_mask);
rt_task_spawn(&task2, task11_name, XENOMAI_TASK_STACK_SIZE, 62,
XENOMAI_TASK_MODE, task11_func, NULL);
rt_task_set_affinity(&task11, &cpu_mask);

CPU_ZERO(&cpu_mask);
CPU_SET(3,&cpu_mask);
rt_task_spawn(&task2, task12_name, XENOMAI_TASK_STACK_SIZE, 64,
XENOMAI_TASK_MODE, task12_func, NULL);
rt_task_set_affinity(&task12, &cpu_mask);

CPU_ZERO(&cpu_mask);
CPU_SET(3,&cpu_mask);
rt_task_spawn(&task2, task13_name, XENOMAI_TASK_STACK_SIZE, 68,
XENOMAI_TASK_MODE, task13_func, NULL);
rt_task_set_affinity(&task13, &cpu_mask);

CPU_ZERO(&cpu_mask);
CPU_SET(3,&cpu_mask);
rt_task_spawn(&task2, task14_name, XENOMAI_TASK_STACK_SIZE, 69,
XENOMAI_TASK_MODE, task14_func, NULL);
rt_task_set_affinity(&task14, &cpu_mask);



On 07/30/2018 09:05 PM, Jackson Jones wrote:
> We have an app running Xenomai 3.0.7 on an i.MX6 quad-core processor.  We
> are using processor affinity to have different tasks bound to different
> cores.
>
> When the app runs on the target and is idle it will freeze the entire
> system after about 8 hours. If we enable these options it no longer locks
> up and runs for days.
>
> CONFIG_LOCKUP_DETECTOR=y
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
> CONFIG_DETECT_HUNG_TASK=y
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
> CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
>

Only guessing at this stage, but maybe the system timer stops ticking on
some CPU and never wakes up for some reason. Enabling the features above
would keep a periodic timer activity running, papering over the issue by
preventing the trigger condition to occur.

Cobalt on i.MX6q is timed by the per-CPU smp_twd timer, which may suffer
the C3STOP mis-feature (some NXP's i.MX6qp SDB do for sure). When CPU
idling is enabled, smp_twd timers may be shut down by the kernel for
entering an idle state, replaced by the global mxc timer acting as a
broadcast device. If/when that happens, Cobalt is not going to be happy,
as it is not smart enough to handle a change of tick device (or device
frequency for that matter).

You could first check whether your device mentions "always-on" as a TWD
property in the DTS. If not, then C3STOP is assumed. It may be worth
testing if disabling the CPU idle feature (NO_HZ_IDLE typically) in the
kernel configuration helps.

> If we run without using processor affinity (all RT tasks will be on the
> same core),  the system will not lock up either.
>

As Greg mentioned earlier, not setting any affinity via
xenomai.supported_cpus actually means including all available cores in
the rt set by default. So your working case seems to be when all CPUs
are available for rt duty.

>
> We are passing in xenomai.supported_cpus=0x0000000f on the command line. I
> noticed the irq-affinity test program assumes at least one non-real time
> cpu. Could having all 4 cores in the RT set be causing the lockups? Should
> we leave one core out of the RT group?
>

No, this is not required.
Philippe.
