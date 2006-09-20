Subject: Re: Re: Re: Antwort: Re: [Xenomai-help] pSOS skin questions
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <OFED2D8080.907D82EC-ONC12571EF.0047B742@domain.hid>
References: <OFED2D8080.907D82EC-ONC12571EF.0047B742@domain.hid>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 15:54:20 +0200
Message-Id: <1158760460.5094.40.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Thomas Necker <Thomas.Necker@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2006-09-20 at 15:21 +0200, Thomas Necker wrote:
> >> 1) The program segfaults sometimes. It's not predictable whether
> >>    it'll happen or not. Starting the same program 10 times may
> >>    result in some segfaults and some complete runs. Adding a printf
> >>    for error checking can massively alter the crash likelyhood. When
> >>    it crashes, its always the same picture: A pSOS event is sent
> >>    from one task to another. The receiveing task is released from its
> >>    blocking ev_receive and continues. However, if this now running task
> >>    calls psos_current_task() it gets the id of the task the event has
> >>    been sent from! Somehow something seems to be completely mixed up
> >>    in the nucleus. After two days of search I'm running out of ideas
> >>    what to look for.
> >
> >Try raising the size of the task stacks. If printf() increases the
> >occurences of faults, then it's likely related to a stack overflow.
> >
> >>  I'd be thankful for some ideas where to place
> >>    some hooks to identify the problem. Things get complicated because
> >>    program changes (I tried to reduce the problem to a simple example)
> >>    ususally make the problem go away and debugging hardly works, see 2)
> 
> I raised the stack to 40k each task, which is ten times as much as under
> original pSOS - still segfaults. Also, printfs rather *reduce* the 
> likelyhood

Ok, so it's probably an internal sync problem affecting the UVM. The
beast is particularly prone to that over the LinuxThreads,
unfortunately. Actually, what you describe rings a bell now; if you
could reduce the odd behaviour to a simple test case, I would look at it
asap.

> of a crash - maybe because of timing changes. I don't think, I'm going to 
> make
> progress without understanding some of the Xenomai internals. Where is the
> best place when I want to trace the "firing" of an event?
> 

ev_receive -> xnsynch_sleep_on
ev_send -> xnsync_wakeup_one_sleeper, which subsequently resumes the
blocked task from xnsynch_sleep_on.

> >The UVM has some known issues when traced over GDB, which do not exist
> >when running over a direct call interface, like POSIX, VxWorks or the
> >native skin. Ok, this is not going to help you since such interface is
> >not available yet for the pSOS skin, but that's a known issue. I'll try
> >to have a look when time allows.
> 
> I already wondered that UVM support is "deprecated" according to the 
> config file.
> What are the plans here: have a pSOS direct call interface, get rid of 
> pSOS
> support or keep the UVM but unmaintained?
> 

The UVM support is being deprecated because it has always been some kind
of hack, aimed at allowing people to run skins, which did not have a
direct syscall interface to the kernel, in user-space context. The nice
idea is that it's a sandboxed environment that did not require us to
write any syscall interface to reach the skin module, the pain is that
1) sandboxing means that interacting with other skins using a direct
call interface is error-prone and even barely usable, 2) it works much
better over the NPTL than the old LinuxThreads, just because the actions
involved in controlling the thread context are much less twisted in the
former.

The plan is to remove the UVM support from 2.3, only keeping it alive
and maintained in the 2.2.x series, and substitute it with a direct
syscall interface for the skins that don't have one yet, thus solving
all issues the UVM suffers in the same move.

Moving from the UVM to the direct syscall interface only means changing
the Makefile, and not using RTOS hacks such as kernel hooks (e.g.
tdelete, tcreate and tswitch funkiness) and timer interposition, since
this would not be available from user-space. This said, nothing would
prevent having a pSOS-based kernel module talking to a pSOS application
in user-space, since pSOS objects have unique abstract identifiers (i.e.
we could share them across kernel/user boundaries).

> Thomas
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



