Subject: Re: Re: Re: Antwort: Re: [Xenomai-help] pSOS skin questions
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1158760460.5094.40.camel@domain.hid>
References: <OFED2D8080.907D82EC-ONC12571EF.0047B742@domain.hid>
	<1158760460.5094.40.camel@domain.hid>
Content-Type: text/plain
Date: Sun, 24 Sep 2006 20:28:16 +0200
Message-Id: <1159122496.4971.42.camel@domain.hid>
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

On Wed, 2006-09-20 at 15:54 +0200, Philippe Gerum wrote:
> On Wed, 2006-09-20 at 15:21 +0200, Thomas Necker wrote:
> > >> 1) The program segfaults sometimes. It's not predictable whether
> > >>    it'll happen or not. Starting the same program 10 times may
> > >>    result in some segfaults and some complete runs. Adding a printf
> > >>    for error checking can massively alter the crash likelyhood. When
> > >>    it crashes, its always the same picture: A pSOS event is sent
> > >>    from one task to another. The receiveing task is released from its
> > >>    blocking ev_receive and continues. However, if this now running task
> > >>    calls psos_current_task() it gets the id of the task the event has
> > >>    been sent from! Somehow something seems to be completely mixed up
> > >>    in the nucleus. After two days of search I'm running out of ideas
> > >>    what to look for.
> > >
> > >Try raising the size of the task stacks. If printf() increases the
> > >occurences of faults, then it's likely related to a stack overflow.
> > >
> > >>  I'd be thankful for some ideas where to place
> > >>    some hooks to identify the problem. Things get complicated because
> > >>    program changes (I tried to reduce the problem to a simple example)
> > >>    ususally make the problem go away and debugging hardly works, see 2)
> > 
> > I raised the stack to 40k each task, which is ten times as much as under
> > original pSOS - still segfaults. Also, printfs rather *reduce* the 
> > likelyhood
> 
> Ok, so it's probably an internal sync problem affecting the UVM. The
> beast is particularly prone to that over the LinuxThreads,
> unfortunately. Actually, what you describe rings a bell now; if you
> could reduce the odd behaviour to a simple test case, I would look at it
> asap.

Thanks for test case, it helped a lot. Here is a fix for an internal
scheduling bug affecting the UVM, especially over GDB:

--- ksrc/nucleus/shadow.c	(revision 1663)
+++ ksrc/nucleus/shadow.c	(working copy)
@@ -1794,7 +1794,7 @@
 
 	if (testbits(thread->status, XNSUSP)) {
 		xnpod_resume_thread(thread, XNSUSP);
-		__setbits(thread->status, XNKICKED);
+		__setbits(thread->status, XNBREAK|XNKICKED);
 	}
 
 	/* If we are kicking a shadow thread, make sure Linux won't

-- 
Philippe.



