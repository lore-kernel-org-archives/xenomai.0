Subject: Re: Re: Antwort: Re: [Xenomai-help] pSOS skin questions
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <OFB0A28393.8487AFE6-ONC12571EE.0042036D@uk.marconicomms.com>
References: <OFB0A28393.8487AFE6-ONC12571EE.0042036D@uk.marconicomms.com>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 14:19:54 +0200
Message-Id: <1158754795.5094.8.camel@domain.hid>
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

On Wed, 2006-09-20 at 13:07 +0200, Thomas Necker wrote:
> > If you want to do that right now, you could override the initial timer
> > setup using xnpod_stop_timer(), then install your primary handler using
> > xnpod_start_timer() again from your app init code, then make sure to
> > call XNPOD_DEFAULT_TICKHANDLER at the end of your primary handler. It's
> > a hack, but this should work, including over the UVM.
> 
> Yes, that meanwhile works. Thanks.
> 
> So the program behaves much better now. However, I still have two major
> problems.
> 
> 1) The program segfaults sometimes. It's not predictable whether
>    it'll happen or not. Starting the same program 10 times may
>    result in some segfaults and some complete runs. Adding a printf
>    for error checking can massively alter the crash likelyhood. When
>    it crashes, its always the same picture: A pSOS event is sent
>    from one task to another. The receiveing task is released from its
>    blocking ev_receive and continues. However, if this now running task
>    calls psos_current_task() it gets the id of the task the event has
>    been sent from! Somehow something seems to be completely mixed up
>    in the nucleus. After two days of search I'm running out of ideas
>    what to look for.

Try raising the size of the task stacks. If printf() increases the
occurences of faults, then it's likely related to a stack overflow.

>  I'd be thankful for some ideas where to place
>    some hooks to identify the problem. Things get complicated because
>    program changes (I tried to reduce the problem to a simple example)
>    ususally make the problem go away and debugging hardly works, see 2)
> 2) I have lots of problems with gdb 6.5. When stepping through the program
>    I sooner or later get the following error:
> 
>         UVM fatal: attempt to suspend root thread ROOT
>          CPU  PID    PRI      TIMEOUT  STAT      NAME
>        >  0  0        0      0        01000080  ROOT
>           0  0       50      999      00020084  MAIN
>           0  0       90      999      00000084  TOSV
>           0  0       80      999      00000084  LHTX
>           0  0       80      0        00000082  LHRX
>           0  0       70      999      00000084  LHWT
>        Timer: periodic [tickval=1000000 ns, elapsed=4]
> 
> 
>        Child exited with retcode = 63
> 
>        Child exited with status 99
>        GDBserver exiting
> 
>    Sometimes I also get:
>         UVM fatal: suspensive call issued while the scheduler was locked
> 
>    Any ideas, how to avoid this?
> 

The UVM has some known issues when traced over GDB, which do not exist
when running over a direct call interface, like POSIX, VxWorks or the
native skin. Ok, this is not going to help you since such interface is
not available yet for the pSOS skin, but that's a known issue. I'll try
to have a look when time allows.

> 
> Thanks,
> Thomas
-- 
Philippe.



