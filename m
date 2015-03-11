Message-ID: <55005B48.8080302@xenomai.org>
Date: Wed, 11 Mar 2015 16:12:08 +0100
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


Hi Jan,

On 03/11/2015 03:47 PM, Jan Kiszka wrote:
> Hi Philippe,
> 
> just happened to trigger the oops below by running
> 
> gdb --args smokey --run=8
> 
> That run already has troubles and generates different output than
> running the test without gdb surveillance, probably due to unexpected
> mode switches. But the real problem is that running the test again
> afterwards, with or without gdb, causes the oops. Registers contain
> suspicious "dead" patterns, thus we access invalid list elements. Do we
> miss a cleanup when terminating smokey in the gdb session?
> 
> [  307.480013]  [<ffffffff8114b20f>] xnsched_tp_set_schedule+0x7f/0x100
> [  307.480013]  [<ffffffff8117787f>] __cobalt_sched_setconfig_np+0x2ff/0x1020

Looks like some TCBs were left in the TP queue of the scheduler slot
after exit (xnsched->tp). Normally, xnsched_tp_forget() should pull any
exiting thread which undergoes SCHED_TP from that queue. Now, it looks
like some code somewhere does not actually share this comfortable
assumption.

I won't be able to debug until next week, but for sure this needs
fixing. Btw, I'll push a general fix for the shared heap issue (broken
inter-process binding to shared objects) when I'm back. Brown paper bag
issue.

-- 
Philippe.

