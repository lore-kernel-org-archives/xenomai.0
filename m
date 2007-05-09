Message-ID: <OF25B7F860.F1C5D4BC-ONC12572D6.0033658D@uk.marconicomms.com>
From: "Markus Osterried" <Markus.Osterried@domain.hid>
Date: Wed, 9 May 2007 11:57:40 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Subject: [Xenomai-core] Antwort: Re: Antwort: Re: Arguments in psos t_start()
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org


Hello Gerum,

actually, when the task's user function (the function which is given in
t_start()) is entered, the arguments have been copied to the new context
and are passed by value.
This is true for real pSOS and also for Xenomai.
But in Xenomai it's the trampoline which acts as a wrapper/prolog and is
created and ready to run in a concurrent context, while still holding a
reference to the arguments in the creator's context.
Real pSOS is a blackbox, so I don't no whether there is a moment in time,
where a new concurrent context is running while still holding a pointer to
old context.
But it's the fact, we have sometimes seen problems with Xenomai, when our
pSOS application changes the arguments value after t_start().
We have never seen this in pSOS.
It's worth to mention, I haven't seen this problem with the newest Xenomai
branch (there was some changes in scheduling?).
But I'm not sure the problem is 100% solved, because with older Xenomai we
have sometimes seen the problem and sometimes not. :-(


Markus





                                                                                                                                               
                              Philippe Gerum                                                                                                   
                              <rpm@xenomai.org         An:      Markus Osterried <Markus.Osterried@domain.hid>                                 
                              g>                      Kopie:   xenomai@xenomai.org                                                            
                              Gesendet von:           Blindkopie:                                                                              
                              xenomai-core-bo         Thema:   Re: [Xenomai-core] Antwort: Re:  Arguments in psos t_start()                    
                              unces@domain.hid                                                                                                    
                                                                                                                                               
                                                                                                                                               
                              09.05.2007                                                                                                       
                              09:55                                                                                                            
                              Bitte antworten                                                                                                  
                              an rpm                                                                                                           
                                                                                                                                               
                                                                                                                                               




On Wed, 2007-05-09 at 09:07 +0200, Markus Osterried wrote:
> Hello Gerum,
>
> sorry for not knowing the details. But there is another question.
> Is it okay to move the pointer to the arguments to the newly created
task?
> Isn't it possible that the task which created the new task is
rescheduled?
> The old task could change the value of the argument and because the new
> task only holds a reference to this argument, the new task is also
> affected.
>

Yes, such side-effect would be possible, not necessarily for the
creator, but for the thread calling t_start() though. The worst case
would happen when calling t_start() with args laid into the caller's
stack space, and the caller unwinding the current frame immediately
since it has a higher priority than the started thread.

This boils down to one question: does actually pSOS pass the argument
array by reference, or by value? In the latter case, the current
implementation would be wrong, otherwise, the side-effect would be
admitted.

--
Philippe.



_______________________________________________
Xenomai-core mailing list
Xenomai-core@domain.hid
https://mail.gna.org/listinfo/xenomai-core







