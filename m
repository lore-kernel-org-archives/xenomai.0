From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20100601135005.GA5483@domain.hid>
References: <20100601135005.GA5483@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 01 Jun 2010 16:32:37 +0200
Message-ID: <1275402757.27918.151.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Handling Linux Signals in primary domain context
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tschaeche IT-Services <services@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2010-06-01 at 15:50 +0200, Tschaeche IT-Services wrote:
> Hi,
> 
> we have the following scenario:
> 
> A high priority periodic primary domain task (H), which calls
> rt_task_suspend(L) in each even period and rt_task_resume(L)
> in each odd period on a low priority primary domain task (L).
> L-task consumes all available CPU resources (while(1)).
> Thus, the rest of each cycle (after H has got the CPU) is used
> alternately by L-task, ROOT-task, L-task,...
> 
> In our debugging implementation, we send a SIGTRAP to L-task.
> H-task recognizes this by reporting EINTR when calling rt_task_suspend(L).
> But, the while(1) in L-task is not interrupted although there is a SIGTRAP
> pending.

Using SIGTRAP will badly conflict with GDB. Hope this is ok.

> 
> Our workaround could be, to send a rt_signal when rt_task_suspend()
> returns EINTR and, then, in the rt-signal handler migrate L-task
> to secondary domain (calling rt_task_set_mode(T_PRIMARY,0))
> initiating the Linux scheduler, which, then, initiates the SIGTRAP handling
> in secondary domain context.
> 
> Is there a simpler way to get primary domain tasks interrupted
> by Linux signals? Xenomai already knows about the pending signal
> and, maybe, could initiate the secondary domain switch on a primary scheduler
> event.

Not in the absence of syscall. We thought about this once already, when
considering how a watchdog preempting a runaway task in primary mode
could force a secondary mode switch: there is no sane and easy solution
to this unfortunately.

If the basic idea is about throttling the activity of the L-task, then
you could use the sporadic server policy (enabled via
pthread_setschedparam_ex()).

> 
> Thanks,
> 
> 	Olli
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.



