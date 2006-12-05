Message-Id: <s575af89.062@domain.hid>
Date: Tue, 05 Dec 2006 13:33:23 +0100
From: "Nicolas BLANCHARD" <n.blanchard@domain.hid>
Subject: =?ISO-8859-1?Q?Re:=20R=E9p.=20:=20Re:=20[Xenomai-help]=20=20=20S?=
	=?ISO-8859-1?Q?witch=20mode=20with=20x86?=
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid, rpm@xenomai.org
Cc: xenomai@xenomai.org

hello Jan,

>>>> Jan Kiszka <jan.kiszka@domain.hid> 04.12 22:06 >>>
>Jan Kiszka wrote:
>> ...
>> This indicates that we face an I-pipe bug: the scheduled Linux call
on
>> relaxation of TASK2 and then later TASK1 somehow gets lost (there is
no
>> rthal_apc_handler in the remaining trace).
>
>I think I got it. No I-pipe bug, but one in the HAL.
>
>What happened? A weird race caused by the unprotected optimisation to
>only call rthal_schedule_irq() if there is no APC pending yet. This
is
>the constellation I finally worked out via instrumenting and tracing:
>
>PRIO 1:
>rthal_apc_schedule()
>  test&set rthal_apc_pending
>  (but no rthal_schedule_irq() yet)
>
>                       -PREEMPTION-
>
>                                        PRIO 99:
>                                        ...
>                                        rthal_apc_schedule()
>                                          test rthal_apc_pending
>                                          (already set => no
>                                          rthal_schedule_irq()!)
>
>So, no one reported the ACP to I-pipe, and no one ever will in
Nicolas
>scenario - soft lock-up!
>
>Nicolas, please give the attached patch a try. Your test is running
fine
>for me now.

I've applied your patch and it seems to run correctly ...
congratulation.
I've read you discussion about this problem with Gilles, but I've don't
really 
understand how you have solved the problem (and what was exactly the
problem).
If you have time to explain, i'm interested ...

>
>
>At this chance: do we need rthal_apc_schedule() returning the
previous
>state at all? No current caller checks the return value. If it's OK
to
>clean this up, I will post a combined patch.
>
>Jan

An other things with switch mode, sometime i lose my i/o privilege put
with the
system call ioperm (in the main function of my program).
My application stop with a "killed" message in the console and 
in /proc/xenomai/fault i've an "general fault".
To ignore this problem, i use the call system iopl (with full
privilege) or 
recall ioperm before each inb or outb.
But there is a problem, why i/o privilege are losted ?
I've read an similar problem in an archive of Rtai/fusion help
mailing-list ...
If you have an idea.

thanks
nicolas blanchard



