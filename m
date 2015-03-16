Message-ID: <5506EC14.9070302@xenomai.org>
Date: Mon, 16 Mar 2015 15:43:32 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <55005580.6050702@siemens.com>
In-Reply-To: <55005580.6050702@siemens.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 3: smokey test sched_tp causes oops when run
	in gdb
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 03/11/2015 03:47 PM, Jan Kiszka wrote:
> Hi Philippe,
> 
> just happened to trigger the oops below by running
> 
> gdb --args smokey --run=8
> 
> That run already has troubles and generates different output than
> running the test without gdb surveillance, probably due to unexpected
> mode switches.

Clearly, yes. GDB causes the test program to leave primary mode, which
changes the scheduling order, and therefore the output which depends on it.

 But the real problem is that running the test again
> afterwards, with or without gdb, causes the oops. Registers contain
> suspicious "dead" patterns, thus we access invalid list elements. Do we
> miss a cleanup when terminating smokey in the gdb session?
> 

I could not reproduce this bug yet.

There is no reason for ptracing the application to have any impact on
the housekeeping chores when it exits. The backtrace shows that
xnsched_tp_set_schedule() is walking through tp->threads, which seems to
link to a stale tcb. xnsched_tp_forget() would then be called twice,
leading to the fault.

Normally, a thread that undergoes TP scheduling should be automatically
removed from tp->threads upon exit after this sequence took place:

handle_taskexit_event -> __xnthread_cleanup -> cleanup_tcb ->
xnsched_forget -> xnsched_tp_forget

For that bug to happen, either this assumption has to be wrong, or
xnsched_set_policy() is being silly at some point.

Is this 100% reproducible on your end, and does this require the initial
gdb run to show up, or would that break even when running the sched_tp
twice without gdb?

-- 
Philippe.

