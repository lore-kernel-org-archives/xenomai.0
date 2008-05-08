Message-ID: <48230CAF.2060207@domain.hid>
Date: Thu, 08 May 2008 16:22:39 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4822C686.1090300@domain.hid>
In-Reply-To: <4822C686.1090300@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] LTT with Xenomai - how to correct visualize the
 Xenomai Events
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefano Babic <stefano.babic@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Stefano Babic wrote:
> Hi all,
> 
> I have some questions regarding context switching in Xenomai and how
> adding LTT support with older Kernel.
> 
> We have a project based on 2.4 Kernel (CPU MPC5200-Kernel 2.4.25) and
> Xenomai 2.3.5 (adeos-ipipe-2.4.25-ppc-CVS-20070325-1.2-01.patch).
> 
> Because it was not possible to upgrade to the 2.6 Kernel, there was the
> decision to use LTT (and not LTT-ng) to trace the system behavior. The
> consequence was to add support for Xenomai in LTT.
> 
> I prepared a patch for the 2.4 Kernel (based on a old RTAI-Patch) and I
> slightly modified the Xenomai code to wrap the xnltt_log_event to call
> the corresponding LTT trace function.
> Because the events are already set in Xenomai, I only mapped them with
> LTT Custom Events. In this way, it is very simple to change Xenomai
> version because the changes in Xenomai are really minimal. I can easy
> replace in the same way the calling to the trace_mark() function in
> Xenomai 2.4 if an upgrade to the newer version is desired.
> 
> I can start the tracedaemon application on the target and collect all
> events. Everything seems fine and consistent.
> With the Visualizer I can obtain the raw dump of all events as ASCII text.
> 
> However, I adapted the LTT-Visualizer to get a visualization of the
> events. I added (if you know as the RTAI-Tasks were added to the
> LTT-Visualizer, I did it in the same way) the Xenomai tasks to the
> visualizer on the bottom of the graph and I wanted to display when a
> task-switch happens.
> 
> To do this, I am searching for all Xenomai ctxsw events to understand
> which tasks are involved. I have an example running at the same time the
> latency test (with -t1 to generate a Xenomai task in kernel) and the
> trivial-periodic provided with Xenomai code.
> 
> Here some sequences I get it, I would like to know how I have to display
> them.
> 
> For example:
> 
> Xenomai i-enter    223,663,358 0    27 irq=256
> Xenomai timer tick 223,663,362 0    34 runthread=ROOT
> Xenomai thread resu223,663,366 0    47 thread=timerbench, mask=0x4
> Xenomai resched    223,663,370 0    20
> Xenomai ctxsw      223,663,375 0    46 ROOT(0) -> timerbench(-1)
> 
> This sequence means for me (but please correct me if I am wrong !) that
> there is a context switch from Xenomai Core (ROOT(0))

ROOT is the placeholder for any regular Linux activity, i.e. non-Xenomai. The
index following it is the CPU number; there is one placeholder per CPU.

 and the Xenomai
> task "timerbench" in Kernel. The values in parenthesis are the pids from
> xnthread_user_task(threadout) and xnthread_user_task(threadin) that I
> have added to the trace. (-1=user_task is set to null)
>

Correct.

> Xenomai thread susp 221,481,424 397 79 thread=timerbench, mask=0x4,
> Xenomai resched 221,481,432 397 20
> Xenomai ctxsw   221,481,437 397 48  timerbench(-1) -> ROOT(397)
> Xenomai i-exit         221,481,441      397     27      irq=256
> 
> This was for me a context switch from the Xenomai Kernel task
> "timerbench" to the Process with PID=397, that I see is a Linux Process.
> Then I draw a line (that is, a task/process switch) from the Xenomai
> task "timerbench" to the linux process with PID=397.
> Am I wrong ?

No, that's correct.

> 
> Xenomai thread resu 223,695,395 0 48 thread=display-369, mask=0x2
> Xenomai resched     223,695,398 0 20
> Xenomai thread susp 223,695,408 0 79 thread=timerbench, mask=0x4
> Xenomai resched     223,695,414 0 20
> Xenomai ctxsw       223,695,419 0 55 timerbench(-1) -> display-369(371)
> 
> This is a context switch between two Xenomai tasks, if I understand well.
>

Correct. Kernel-based Xenomai thread to user-space Xenomai thread.

> I have not considered the modex2 and modex1 events and I am not sure
> about them. However, I have noted that modex2 is collected with a Linux
> "Sched change" event and I can consider only the last one to understand
> if a Linux process is running, for example I see:
> 
> Xenomai i-exit 221,695,618 0 27 irq=256
> Xenomai lohandler 221,695,631 0 54 type=10, task=display-369, pid=371
> Process      221,695,634      0 16 WAKEUP PID : 371; STATE : 1
> Sched change 221,695,653    371 19   IN : 371; OUT : 0; STATE : 0
> Xenomai modex2 221,695,666  371 38      thread=display-369
> 
> In my IMHO it is enough to get the "Sched change" event to understand
> that the system is switching to Linux and that a Linux process is
> currently scheduled. In this case, the linux process with PID=371 is
> scheduled.
> 
> However, I got also these events, where the lohandler event is not traced:
> 
> Xenomai ctxsw 223,695,419 0 55 timerbench(-1) -> display-369(371)
> Xenomai modsw2 223,695,573 0 38 thread=display-369
> 
> At the moment, I display only the modex event, but I do not take any
> decision about it. I draw only a context switch between the two Xenomai
> tasks "timerbench" and "display-369".

modsw[1/2] tags the prologue of a mode switch to primary/secondary mode. (e.g.
modsw2 means that some userland Xenomai thread is about to move to Linux mode).
This is why you always get a Linux sched change after both, because they incur a
Linux rescheduling to perform the transition (sw1 = wakeup gatekeeper + suspend
current and reschedule atomically, the gatekeeper will resume the thread for the
nucleus), sw2 = send a virtual IRQ to Linux + suspend the current Xenomai
thread, Linux will run our lostage VIRQ handler later on, to wakeup the mated
Linux task).

modx[1/2] tags the epilogue of the mode switch; modx1 means that we are now
running in primary mode, and conversely, modx2 means that we are now running in
secondary mode.


> 
> Thanks,
> Stefano
> 
> 


-- 
Philippe.

