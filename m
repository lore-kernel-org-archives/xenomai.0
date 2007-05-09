From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <OF25B7F860.F1C5D4BC-ONC12572D6.0033658D@uk.marconicomms.com>
References: <OF25B7F860.F1C5D4BC-ONC12572D6.0033658D@uk.marconicomms.com>
Content-Type: text/plain
Date: Wed, 09 May 2007 18:05:12 +0200
Message-Id: <1178726712.11688.26.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Antwort: Re: Antwort: Re: Arguments in
	psos	t_start()
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

On Wed, 2007-05-09 at 11:57 +0200, Markus Osterried wrote:
> Hello Gerum,
> 
> actually, when the task's user function (the function which is given in
> t_start()) is entered, the arguments have been copied to the new context
> and are passed by value.
> This is true for real pSOS and also for Xenomai.
> But in Xenomai it's the trampoline which acts as a wrapper/prolog and is
> created and ready to run in a concurrent context, while still holding a
> reference to the arguments in the creator's context.
> Real pSOS is a blackbox, so I don't no whether there is a moment in time,
> where a new concurrent context is running while still holding a pointer to
> old context.

To explain how the pSOS skin currently works:

starter task:
	== syscall == t_start(targs[] by reference)
		kernel/skin: receives the genuine "targ" _pointer_, and copies it
unmodified to the new task's trampoline code in user-space + wakes up
the new task so that it really starts execution (i.e. it was locked into
the trampoline code).

new task (in trampoline code):
		==syscall== wait on the start barrier
			kernel/skin: makes caller wait until t_start is issued
		receives "targs" pointer verbatim, copied back by the last syscall,
and dereferences it to pass the 4 long words from the targs array to the
callback entry routine of the new task.

So, the issue that could happen, is the caller of the t_start() function
in user-space returning to its own caller, with "targs" being laid into
the stack space being unwound. _That_ would be a rainy day. The only
issue otherwise, is the caller of t_start() modifying the arguments
before or while the resumed task accesses them, but that would be more
of a reasonable side-effect of passing arguments by reference, that a
bug per se. Except of course, if pSOS does differently, and always
copies the argument array in the t_start() syscall.

> But it's the fact, we have sometimes seen problems with Xenomai, when our
> pSOS application changes the arguments value after t_start().
> We have never seen this in pSOS.
> It's worth to mention, I haven't seen this problem with the newest Xenomai
> branch (there was some changes in scheduling?).
> But I'm not sure the problem is 100% solved, because with older Xenomai we
> have sometimes seen the problem and sometimes not. :-(

Please be specific; which are the "older Xenomai" and "newest Xenomai
branch"? i.e. which stable version number or SVN commit number for the
trunk/?

This said, I definitely fixed a scheduling issue due to
primary/secondary mode switches involved in creating new user-space
tasks which has been committed in v2.3.1 (i.e. a major rework of the
so-called "RPI management", after Thomas sent me a test case to
illustrate the issue). This bug, for sure, could have impacted your
application in the situation I described earlier, regarding t_start
arguments laid into the stack space. But I have not enough details to be
100% this was related to your problem though.

> 
> 
> Markus
> 
> 
> 
> 
> 
>                                                                                                                                                
>                               Philippe Gerum                                                                                                   
>                               <rpm@xenomai.org         An:      Markus Osterried <Markus.Osterried@domain.hid>                                 
>                               g>                      Kopie:   xenomai@xenomai.org                                                            
>                               Gesendet von:           Blindkopie:                                                                              
>                               xenomai-core-bo         Thema:   Re: [Xenomai-core] Antwort: Re:  Arguments in psos t_start()                    
>                               unces@domain.hid                                                                                                    
>                                                                                                                                                
>                                                                                                                                                
>                               09.05.2007                                                                                                       
>                               09:55                                                                                                            
>                               Bitte antworten                                                                                                  
>                               an rpm                                                                                                           
>                                                                                                                                                
>                                                                                                                                                
> 
> 
> 
> 
> On Wed, 2007-05-09 at 09:07 +0200, Markus Osterried wrote:
> > Hello Gerum,
> >
> > sorry for not knowing the details. But there is another question.
> > Is it okay to move the pointer to the arguments to the newly created
> task?
> > Isn't it possible that the task which created the new task is
> rescheduled?
> > The old task could change the value of the argument and because the new
> > task only holds a reference to this argument, the new task is also
> > affected.
> >
> 
> Yes, such side-effect would be possible, not necessarily for the
> creator, but for the thread calling t_start() though. The worst case
> would happen when calling t_start() with args laid into the caller's
> stack space, and the caller unwinding the current frame immediately
> since it has a higher priority than the started thread.
> 
> This boils down to one question: does actually pSOS pass the argument
> array by reference, or by value? In the latter case, the current
> implementation would be wrong, otherwise, the side-effect would be
> admitted.
> 
> --
> Philippe.
> 
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 
> 
> 
> 
> 
> 
-- 
Philippe.



