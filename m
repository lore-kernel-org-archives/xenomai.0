From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B73318C.3000409@domain.hid>
References: <4B72F360.4050209@domain.hid>
	<1265826669.2368.132.camel@domain.hid>
	<4B73318C.3000409@domain.hid>
Content-Type: text/plain
Date: Thu, 11 Feb 2010 18:05:12 +0100
Message-Id: <1265907912.6542.11.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] S_memLib_NOT_ENOUGH_MEMORY error in
	porting	VxWorks application.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michael Buksas <mwbuksas@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2010-02-10 at 15:22 -0700, Michael Buksas wrote:
> Philippe,
> 
> After the patch, all of the failing tasks return 22: Invalid Argument.
> 
> I can't find anything unique about these three tasks among the many 
> others, however. They're all using 0x8 for options, have similar stack 
> sizes and priorities.

Could you post the failing taskSpawn() call from your application, so
that I could have a look at the argument list?

Additionally, you can use GDB to see what goes wrong; passing
--enable-debug to the configure script will get you the debugging
symbols into the emulator library, and will also disable compiler
optimizations. Then, you should be able to trace the __taskInit()
routine there by setting a breakpoint, and see which statement actually
returns EINVAL.

> 
> Thanks,
> Mike
> 
> 
> Philippe Gerum wrote:
> > On Wed, 2010-02-10 at 10:56 -0700, Michael Buksas wrote:
> >> I'm porting a VxWorks application to Xenomai/SOLO and getting 
> >> S_memLib_NOT_ENOUGH_MEMORY errors from taskSpawn.
> >>
> >> I'm currently running on a desktop Linux system, so I doubt physical 
> >> memory is an issue. Rather, I think it's the allocation of memory for 
> >> tasks, and my crushing ignorance about how to do the same.
> >>
> >> For example, does this occur when the memory needs of the task exceed 
> >> the stack size argument to taskSpawn? Increasing this value does not 
> >> appear to help.
> >>
> >> Can anyone suggest how to further diagnose the memory problem?
> > 
> > Sloppy code at work in the emulator. Could you apply this patch and
> > check the actual return code? If -EPERM, then make sure to run your app
> > with root privileges, since the emulator attempts to create SCHED_FIFO
> > threads.
> > 
> > diff --git a/vxworks/taskLib.c b/vxworks/taskLib.c
> > index a9e12e7..4db2c66 100644
> > --- a/vxworks/taskLib.c
> > +++ b/vxworks/taskLib.c
> > @@ -327,7 +327,7 @@ static STATUS __taskInit(struct wind_task *task,
> >  	ret = pthread_create(&thid, &thattr, &task_trampoline, task);
> >  	pthread_attr_destroy(&thattr);
> >  	if (ret) {
> > -		errno = S_memLib_NOT_ENOUGH_MEMORY;
> > +		errno = ret == -EAGAIN ? S_memLib_NOT_ENOUGH_MEMORY : ret;
> >  		return ERROR;
> >  	}
> >  
> > 
> >> And to address the broader question, where should a raw beginner at 
> >> embedded programming go for documentation on Xenomai/SOLO and guidance 
> >> for the porting process?
> >>
> >> Thanks in advance,
> >> Mike
> >>
> >>
> >> _______________________________________________
> >> Xenomai-help mailing list
> >> Xenomai-help@domain.hid
> >> https://mail.gna.org/listinfo/xenomai-help
> > 
> > 
> 
> 
-- 


