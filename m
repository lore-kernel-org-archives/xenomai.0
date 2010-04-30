Date: Fri, 30 Apr 2010 19:34:10 -0400
Message-ID: <20100430233410.GA8991@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
From: Andreas Glatz <andreasglatz@domain.hid>
Subject: [Xenomai-help] Page fault and secondary mode switch on PowerPC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

We are running our tests now where Linux is bombarded with interrupts. Under certain conditions 
we found that we get page faults in IRQ Tasks which cause a secondary mode switch. To my understanding
and what makes things worse is that, ISR tasks always run with the scheduler lock bit set (T_LOCK). 
In our case this means that when we switch to the secondary mode from the ISR Task, all other Xenomai
tasks don't get scheduled until the ISR task returns to primary mode. Since Linux is under heavy 
interrupt load, it takes about 1-2sec for any Xenomai task to start running again.

I attached a LTTng trace where you can see whats going on. Here the short version:

1) IRQ 44 occurs
2) Xenomai kernel-space ISR is called and wakes up the user-space ISR task, called "00000039"
3) We get the page fault just at the start of the user-space ISR:

xn_nucleus.thread_fault: 208.180295561 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { thread = 0xe1075610, thread_name = "00000039", address = 269713436, type = 769 }

Address: 0x1013801c
Type: 0x301 (Data access exception according to PowerPC e300 core manual)

4) Switch to secondary mode
5) After 2sec the task resumes


My research also led me to the following xenomai-help ng post:

http://www.mail-archive.com/xenomai@xenomai.org

Back then (in 2007), Philippe was saying that the Ipipe/powerpc port didn't support disabling of 
the 'demand paging' mechanism. Has someone already implemented this for powerpc?

What other options do we have?

Regards, Andreas

DISASSEMBLY for instruction 0x1013801c:

1013801c:       94 21 ff e0     stwu    r1,-32(r1)
10138020:       7c 08 02 a6     mflr    r0
10138024:       90 01 00 24     stw     r0,36(r1)

TRACE:

xn_nucleus.irq_enter: 208.180238651 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { irq = 44 }
xn_nucleus.synch_flush: 208.180241531 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { synch = 0xe1075470, reason = 0 }
xn_nucleus.thread_resume: 208.180244846 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { thread = 0xe1075610, thread_name = "00000039", mask = 2 }
xn_nucleus.sched: 208.180249196 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL
xn_nucleus.sched_switch: 208.180252586 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { thread_out = 0xc0443bc0, thread_out_name = "ROOT", thread_in = 0xe1075610, thread_in_name = "00000039" }
xn_nucleus.irq_enter: 208.180271486 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { irq = 43 }
xn_nucleus.synch_flush: 208.180274111 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { synch = 0xe1070770, reason = 0 }
xn_nucleus.thread_resume: 208.180277036 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { thread = 0xe1071010, thread_name = "00000014", mask = 2 }
xn_nucleus.sched: 208.180279706 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL
xn_nucleus.irq_exit: 208.180281431 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { irq = 43 }
xn_nucleus.thread_fault: 208.180295561 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { thread = 0xe1075610, thread_name = "00000039", address = 269713436, type = 769 }
xn_nucleus.shadow_gorelax: 208.180300931 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { thread = 0xe1075610, thread_name = "00000039" }
xn_nucleus.sched_fast: 208.180311431 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL
xn_nucleus.thread_suspend: 208.180317416 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { thread = 0xe1075610, thread_name = "00000039", mask = 512, timeout = 0, timeout_mode = 0, wchan = 0x0 }
xn_nucleus.sched: 208.180321091 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL
xn_nucleus.sched_switch: 208.180324436 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { thread_out = 0xe1075610, thread_out_name = "00000039", thread_in = 0xc0443bc0, thread_in_name = "ROOT" }
xn_nucleus.irq_exit: 208.180329731 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { irq = 44 }
xn_nucleus.irq_enter: 208.180602806 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.tbase_tick: 208.180609691 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { base = "master" }
xn_nucleus.timer_expire: 208.180613696 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { timer = 0xc0443f28 }
xn_nucleus.irq_exit: 208.180622216 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.irq_enter: 208.215940257 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.tbase_tick: 208.215951687 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { base = "master" }
xn_nucleus.timer_expire: 208.215956757 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { timer = 0xe107c7d8 }
xn_nucleus.thread_resume: 208.215964647 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { thread = 0xe107c610, thread_name = "L3Switch_LX0", mask = 4 }
xn_nucleus.sched: 208.215974082 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ
xn_nucleus.irq_exit: 208.215977772 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.irq_enter: 208.241844132 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.tbase_tick: 208.241855112 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { base = "master" }
xn_nucleus.timer_expire: 208.241859117 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { timer = 0xe109bdd8 }
xn_nucleus.thread_resume: 208.241866692 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { thread = 0xe109bc10, thread_name = "Forwarding", mask = 4 }
xn_nucleus.sched: 208.241875707 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ
xn_nucleus.irq_exit: 208.241879472 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.irq_enter: 208.242283347 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.tbase_tick: 208.242288117 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { base = "master" }
xn_nucleus.timer_expire: 208.242291672 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { timer = 0xe109c5d8 }
xn_nucleus.thread_resume: 208.242297117 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { thread = 0xe109c410, thread_name = "DhcpListener", mask = 4 }
xn_nucleus.sched: 208.242303942 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ
xn_nucleus.irq_exit: 208.242306792 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.irq_enter: 208.259857167 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, IRQ { irq = 512 }
xn_nucleus.tbase_tick: 208.259868057 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, IRQ { base = "master" }
xn_nucleus.timer_expire: 208.259871942 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, IRQ { timer = 0xe10979d8 }
xn_nucleus.thread_resume: 208.259879037 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, IRQ { thread = 0xe1097810, thread_name = "MF:TimeoutH", mask = 4 }
xn_nucleus.sched: 208.259893932 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, IRQ
xn_nucleus.irq_exit: 208.259898267 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, IRQ { irq = 512 }
xn_nucleus.irq_enter: 208.269028722 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.tbase_tick: 208.269038937 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { base = "master" }
xn_nucleus.timer_expire: 208.269043662 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { timer = 0xe109a1d8 }
xn_nucleus.thread_resume: 208.269050097 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { thread = 0xe109a010, thread_name = "GVRP TimerTask", mask = 4 }
xn_nucleus.sched: 208.269058797 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ
xn_nucleus.irq_exit: 208.269062097 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.irq_enter: 208.328089138 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { irq = 512 }
xn_nucleus.tbase_tick: 208.328101033 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { base = "master" }
xn_nucleus.timer_expire: 208.328105323 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { timer = 0xe108a3d8 }
xn_nucleus.thread_resume: 208.328111488 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { thread = 0xe108a210, thread_name = "MSTP_Timers", mask = 4 }
xn_nucleus.sched: 208.328119303 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL
xn_nucleus.irq_exit: 208.328124118 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { irq = 512 }
xn_nucleus.irq_enter: 208.411448234 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.tbase_tick: 208.411458989 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { base = "master" }
xn_nucleus.timer_expire: 208.411463279 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { timer = 0xe1086dd8 }
xn_nucleus.thread_resume: 208.411470629 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { thread = 0xe1086c10, thread_name = "Port Security Task", mask = 4 }
xn_nucleus.synch_forget: 208.411475609 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { thread = 0xe1086c10, thread_name = "Port Security Task", synch = 0xe1087204 }
xn_nucleus.sched: 208.411485959 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ
xn_nucleus.irq_exit: 208.411489724 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.irq_enter: 208.505765145 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.tbase_tick: 208.505776620 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { base = "master" }
xn_nucleus.timer_expire: 208.505781105 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { timer = 0xe107ffd8 }
xn_nucleus.thread_resume: 208.505789910 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { thread = 0xe107fe10, thread_name = "LinkTask0", mask = 4 }
xn_nucleus.synch_forget: 208.505795325 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { thread = 0xe107fe10, thread_name = "LinkTask0", synch = 0xe107fc84 }
xn_nucleus.sched: 208.505803950 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ
xn_nucleus.irq_exit: 208.505808690 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.irq_enter: 208.520140590 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { irq = 512 }
xn_nucleus.tbase_tick: 208.520151375 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { base = "master" }
xn_nucleus.timer_expire: 208.520156055 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { timer = 0xe109f1d8 }
xn_nucleus.thread_resume: 208.520162250 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { thread = 0xe109f010, thread_name = "UI_System_4", mask = 4 }
xn_nucleus.sched: 208.520170080 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL
xn_nucleus.irq_exit: 208.520174265 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { irq = 512 }
xn_nucleus.irq_enter: 208.520654775 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.tbase_tick: 208.520661090 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { base = "master" }
xn_nucleus.timer_expire: 208.520665575 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { timer = 0xe109cdd8 }
xn_nucleus.thread_resume: 208.520671290 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { thread = 0xe109cc10, thread_name = "UI_System_0", mask = 4 }
xn_nucleus.sched: 208.520679060 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ
xn_nucleus.irq_exit: 208.520681775 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.irq_enter: 208.521819615 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.tbase_tick: 208.521827700 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { base = "master" }
xn_nucleus.timer_expire: 208.521831720 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { timer = 0xe109d5d8 }
xn_nucleus.thread_resume: 208.521836895 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { thread = 0xe109d410, thread_name = "UI_System_1", mask = 4 }
xn_nucleus.sched: 208.521846000 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ
xn_nucleus.irq_exit: 208.521849255 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.irq_enter: 208.522322700 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.tbase_tick: 208.522329000 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { base = "master" }
xn_nucleus.timer_expire: 208.522332360 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { timer = 0xe109dfd8 }
xn_nucleus.thread_resume: 208.522338645 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { thread = 0xe109de10, thread_name = "UI_System_2", mask = 4 }
xn_nucleus.sched: 208.522345470 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ
xn_nucleus.irq_exit: 208.522348365 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.irq_enter: 208.522848855 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.tbase_tick: 208.522854495 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { base = "master" }
xn_nucleus.timer_expire: 208.522858245 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { timer = 0xe109e7d8 }
xn_nucleus.thread_resume: 208.522863120 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { thread = 0xe109e610, thread_name = "UI_System_3", mask = 4 }
xn_nucleus.sched: 208.522870875 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ
xn_nucleus.irq_exit: 208.522874010 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.irq_enter: 208.537373295 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.tbase_tick: 208.537382865 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { base = "master" }
xn_nucleus.timer_expire: 208.537387785 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { timer = 0xe1097fd8 }
xn_nucleus.thread_resume: 208.537395390 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { thread = 0xe1097e10, thread_name = "MF:TimeoutL", mask = 4 }
xn_nucleus.sched: 208.537403715 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ
xn_nucleus.irq_exit: 208.537407975 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.irq_enter: 208.578408135 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.tbase_tick: 208.578418185 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { base = "master" }
xn_nucleus.timer_expire: 208.578422625 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { timer = 0xe1071fd8 }
xn_nucleus.thread_resume: 208.578429000 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { thread = 0xe1071e10, thread_name = "bgndT40_1", mask = 4 }
xn_nucleus.sched: 208.578438300 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ
xn_nucleus.irq_exit: 208.578441735 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.irq_enter: 208.578550410 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.tbase_tick: 208.578554025 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { base = "master" }
xn_nucleus.timer_expire: 208.578557085 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { timer = 0xe10865d8 }
xn_nucleus.thread_resume: 208.578562515 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { thread = 0xe1086410, thread_name = "IEEE802.1X Timer", mask = 4 }
xn_nucleus.sched: 208.578568890 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ
xn_nucleus.irq_exit: 208.578571230 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.irq_enter: 208.578681150 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { irq = 512 }
xn_nucleus.tbase_tick: 208.578684600 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { base = "master" }
xn_nucleus.timer_expire: 208.578687735 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { timer = 0xe1085fd8 }
xn_nucleus.thread_resume: 208.578691695 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { thread = 0xe1085e10, thread_name = "IEEE802.1X ServerRx", mask = 4 }
xn_nucleus.sched: 208.578698010 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL
xn_nucleus.irq_exit: 208.578700065 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { irq = 512 }
xn_nucleus.irq_enter: 208.681855831 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.tbase_tick: 208.681866406 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { base = "master" }
xn_nucleus.timer_expire: 208.681871281 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { timer = 0xe108d1d8 }
xn_nucleus.thread_resume: 208.681877221 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { thread = 0xe108d010, thread_name = "MSTP_StatsUpdate", mask = 4 }
xn_nucleus.sched: 208.681888561 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ
xn_nucleus.irq_exit: 208.681892386 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.irq_enter: 209.036829815 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.tbase_tick: 209.036840315 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { base = "master" }
xn_nucleus.timer_expire: 209.036844770 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { timer = 0xe106fdd8 }
xn_nucleus.thread_resume: 209.036851790 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { thread = 0xe106fc10, thread_name = "SYS_Watchdog", mask = 4 }
xn_nucleus.sched: 209.036860895 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ
xn_nucleus.irq_exit: 209.036864885 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.irq_enter: 209.141706486 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.tbase_tick: 209.141716746 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { base = "master" }
xn_nucleus.timer_expire: 209.141721306 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { timer = 0xe107f7d8 }
xn_nucleus.thread_resume: 209.141728011 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { thread = 0xe107f610, thread_name = "Link Monitor", mask = 4 }
xn_nucleus.sched: 209.141736861 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ
xn_nucleus.irq_exit: 209.141741196 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.irq_enter: 209.167343646 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.tbase_tick: 209.167353246 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { base = "master" }
xn_nucleus.timer_expire: 209.167358466 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { timer = 0xe1081bd8 }
xn_nucleus.thread_resume: 209.167365516 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { thread = 0xe1081a10, thread_name = "LinkTask2", mask = 4 }
xn_nucleus.synch_forget: 209.167370496 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { thread = 0xe1081a10, thread_name = "LinkTask2", synch = 0xe1081284 }
xn_nucleus.sched: 209.167380486 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ
xn_nucleus.irq_exit: 209.167384776 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.irq_enter: 209.180182806 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.tbase_tick: 209.180192601 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { base = "master" }
xn_nucleus.timer_expire: 209.180197251 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { timer = 0xe10727d8 }
xn_nucleus.thread_resume: 209.180203881 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { thread = 0xe1072610, thread_name = "bgndT0_3", mask = 4 }
xn_nucleus.synch_forget: 209.180208516 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { thread = 0xe1072610, thread_name = "bgndT0_3", synch = 0xe1074804 }
xn_nucleus.sched: 209.180217651 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ
xn_nucleus.irq_exit: 209.180221716 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.irq_enter: 209.216718157 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.tbase_tick: 209.216728132 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { base = "master" }
xn_nucleus.timer_expire: 209.216733202 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { timer = 0xe10829d8 }
xn_nucleus.thread_resume: 209.216741047 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { thread = 0xe1082810, thread_name = "LinkTask3", mask = 4 }
xn_nucleus.synch_forget: 209.216746717 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { thread = 0xe1082810, thread_name = "LinkTask3", synch = 0xe1082084 }
xn_nucleus.sched: 209.216755687 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ
xn_nucleus.irq_exit: 209.216760217 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.irq_enter: 209.664293456 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.tbase_tick: 209.664307451 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { base = "master" }
xn_nucleus.timer_expire: 209.664313031 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { timer = 0xe107afd8 }
xn_nucleus.thread_resume: 209.664320321 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { thread = 0xe107ae10, thread_name = "vlanCleanup", mask = 4 }
xn_nucleus.sched: 209.664329636 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ
xn_nucleus.irq_exit: 209.664333791 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SOFTIRQ { irq = 512 }
xn_nucleus.timer_start: 210.988277019 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, TRAP { timer = 0xc0443f28, base = "master", value = 1791687, interval = 0, mode = 0 }
xn_nucleus.lostage_work: 210.988668324 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { reqnum = 12, comm = "00000039", pid = 3182 }
xn_nucleus.sched_fast: 210.988674444 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL
xn_nucleus.sched_remote: 210.988696959 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL
xn_nucleus.sched: 210.988698849 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL
xn_nucleus.sched_switch: 210.988705569 (/tmp/trace-ktrigger1/xn_nucleus_0), 4, 4, events/0, , 2, 0x0, SYSCALL { thread_out = 0xc0443bc0, thread_out_name = "ROOT", thread_in = 0xe1071010, thread_in_name = "00000014" }

