Date: Tue, 1 Jun 2010 15:50:05 +0200
From: Tschaeche IT-Services <services@domain.hid>
Message-ID: <20100601135005.GA5483@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai-help] Handling Linux Signals in primary domain context
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

we have the following scenario:

A high priority periodic primary domain task (H), which calls
rt_task_suspend(L) in each even period and rt_task_resume(L)
in each odd period on a low priority primary domain task (L).
L-task consumes all available CPU resources (while(1)).
Thus, the rest of each cycle (after H has got the CPU) is used
alternately by L-task, ROOT-task, L-task,...

In our debugging implementation, we send a SIGTRAP to L-task.
H-task recognizes this by reporting EINTR when calling rt_task_suspend(L).
But, the while(1) in L-task is not interrupted although there is a SIGTRAP
pending.

Our workaround could be, to send a rt_signal when rt_task_suspend()
returns EINTR and, then, in the rt-signal handler migrate L-task
to secondary domain (calling rt_task_set_mode(T_PRIMARY,0))
initiating the Linux scheduler, which, then, initiates the SIGTRAP handling
in secondary domain context.

Is there a simpler way to get primary domain tasks interrupted
by Linux signals? Xenomai already knows about the pending signal
and, maybe, could initiate the secondary domain switch on a primary scheduler
event.

Thanks,

	Olli

