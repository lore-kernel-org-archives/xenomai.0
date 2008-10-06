Message-ID: <48E9FECF.1070005@domain.hid>
Date: Mon, 06 Oct 2008 14:04:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48E76494.9030901@domain.hid>
In-Reply-To: <48E76494.9030901@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] gdb lockup on multi-threaded process exit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> I'm banging my head against this issue for several days now, first
> trying to sort out an unrelated bug I also came across at this chance,
> then trying to understand what happens, and finally getting mad about
> why this may only happen with Xenomai:
> 
> One process, two threads, running under gdb control (no breakpoints,
> just the automatically set ones that track thread creation/destruction).
> All happens already with only one CPU. The first thread decides to issue
> exit() exactly while the second one is on its way from primary to
> secondary mode due to running on a breakpoint (int3 -> xnpod_trap_fault
> -> xnshadow_relax...). The group exit of thread A causes SIGKILL to be
> set in thread B, but triggers no further actions due to B already being
> awake and on its way to queue and handle the other signal (SIGTRAP). Now
> when B comes to dequeue the next signal it finds SIGTRAP and SIGKILL
> set, but picks up SIGTRAP due to its lower number. Now ptrace causes B
> to stop, gdb gets confused, sends A, which is already a zombie, a
> SIGSTOP and waits on it to confirm this stop - which never happens. If
> someone is interested, I can provide an LTTng dump of this scenario.
> 
> My problem is now that I still don't understand what prevents this
> deadlock on vanilla Linux. Does Xenomai create a thread schedule here
> that is impossible there? Or does it only widens an otherwise very
> small race window that also exists with mainline? Before making a fool
> of my self on LKML, I would like to collect some further ideas on the
> workaround or fix(?) below that cures this deadlock for me.

After reading this comment

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=3d749b9e676b26584a47e75c235aa6f69d0697ae

I'm now about to escalate the issue to LKML. This really looks like a
mainline bug, probably just triggered more quickly by the large latency
between signal queuing and receiver scheduling that the
primary->secondary mode switch introduces.

Jan

PS: Gilles, Oleg's patch actually removed the SIGKILL-blocked checked in
2.6.27.

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

