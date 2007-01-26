Message-ID: <OF08EED954.3DF48206-ONC125726F.004BA080@domain.hid>
From: "Markus Osterried" <Markus.Osterried@domain.hid>
Date: Fri, 26 Jan 2007 15:34:39 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Subject: [Xenomai-core] Questions about pSOS task mode and task priority
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hello,

I work together with Thomas Necker on a legacy pSOS project to get it
ported to Xenomai.
I have already ported a great amount of code and most of it works fine.

But we have a pSOS task which (sometimes) works in non-preemptive mode
(T_NOPREEMPT).
When this task calls ev_receive() it gets back the error code -EPERM from
underlying xnpod_unblockable_p().
It seems to be not allowed in Xenomai to call a blockable syscall in
non-preemptive mode.
With original pSOS this was allowed and "non-preemptive" meant that a
runnable task cannot be preempted by other tasks but can block itself.
Why is this different in Xenomai and is it possible to implement the same
behaviour in Xenomai core?

Another problem is that we have a root task creating and starting some
other tasks.
The new tasks are mostly created with prio 80 and the root task wants to
run the new tasks until their first blocking syscall.
Therefore the root task lowers its priority to one less the priority of the
new task, i.e. 79.
Then the root task raise its prio back to 240.
Immediately after lowering its prio, the root task should be preempted and
the new task should run.
But this doesn't happen. Why not?

Thank you.

Regards
Markus




