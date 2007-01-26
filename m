Subject: Re: [Xenomai-core] Questions about pSOS task mode and task priority
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <OF08EED954.3DF48206-ONC125726F.004BA080@domain.hid>
References: <OF08EED954.3DF48206-ONC125726F.004BA080@domain.hid>
Content-Type: text/plain
Date: Fri, 26 Jan 2007 17:01:48 +0100
Message-Id: <1169827308.3346.55.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Markus Osterried <Markus.Osterried@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2007-01-26 at 15:34 +0100, Markus Osterried wrote:
> Hello,
> 
> I work together with Thomas Necker on a legacy pSOS project to get it
> ported to Xenomai.
> I have already ported a great amount of code and most of it works fine.
> 
> But we have a pSOS task which (sometimes) works in non-preemptive mode
> (T_NOPREEMPT).
> When this task calls ev_receive() it gets back the error code -EPERM from
> underlying xnpod_unblockable_p().
> It seems to be not allowed in Xenomai to call a blockable syscall in
> non-preemptive mode.
> With original pSOS this was allowed and "non-preemptive" meant that a
> runnable task cannot be preempted by other tasks but can block itself.
> Why is this different in Xenomai and is it possible to implement the same
> behaviour in Xenomai core?
> 

Xenomai implements the non-preemptible mode as most RTOSes implement
scheduling locks. From this POV, allowing a non-preemptible task to
block makes no sense, and doing so usually either locks up the board, or
causes an API error.

It could be possible to switch the preemption bit on before entering a
blocking state only for pSOS tasks, then reinstate it when the task
wakes up, though. However, before going down that path, is there any
pSOS documentation that clearly states that such behaviour is to be
expected (i.e. that blocking calls _may_ be called in non-preemptible
mode)?

Or did you benefit from an undocumented and fortunate side-effect of the
pSOS implementation when relying on such behaviour?

> Another problem is that we have a root task creating and starting some
> other tasks.
> The new tasks are mostly created with prio 80 and the root task wants to
> run the new tasks until their first blocking syscall.
> Therefore the root task lowers its priority to one less the priority of the
> new task, i.e. 79.
> Then the root task raise its prio back to 240.
> Immediately after lowering its prio, the root task should be preempted and
> the new task should run.
> But this doesn't happen. Why not?
> 

Please send a code snippet that exhibit this behaviour. I'll look at it
asap.

> Thank you.
> 
> Regards
> Markus
> 
> 
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



