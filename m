Subject: Re: Antwort: Re: [Xenomai-core] Found bug in pSOS ev_receive()
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <OF091718EC.A0DD90B3-ONC125727B.00407462@domain.hid>
References: <OF091718EC.A0DD90B3-ONC125727B.00407462@domain.hid>
Content-Type: text/plain
Date: Wed, 07 Feb 2007 14:22:40 +0100
Message-Id: <1170854560.21675.11.camel@domain.hid>
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

On Wed, 2007-02-07 at 12:51 +0100, Markus Osterried wrote:
> In timeout case events_r is don't care.

I would swear having seen a copy back being documented in the timeout
case in some oldish pSOS 2.3 manual a looong time ago, but since I don't
have it at hand anymore, maybe it's just -ENOBRAIN on my side.

> When using pSOS skin in user space, __ev_receive() in syscall.c copy
> events_r to user space only when ev_receive was successful.
> But this comply with pSOS manual: "If successful, ev_receive() returns the
> actual events captured by the call in the
> location pointed to by events_r."

Good. Thanks.

> 
> 
> 
> 
>                                                                                                                                                
>                               Philippe Gerum                                                                                                   
>                               <rpm@xenomai.org         An:      Markus Osterried <Markus.Osterried@domain.hid>                                 
>                               g>                      Kopie:   xenomai@xenomai.org                                                            
>                               Gesendet von:           Blindkopie:                                                                              
>                               Philippe Gerum          Thema:   Re: [Xenomai-core] Found bug in pSOS ev_receive()                               
>                               <philippe.gerum                                                                                                  
>                               @gmail.com>                                                                                                      
>                                                                                                                                                
>                                                                                                                                                
>                               07.02.2007                                                                                                       
>                               12:15                                                                                                            
>                               Bitte antworten                                                                                                  
>                               an rpm                                                                                                           
>                                                                                                                                                
>                                                                                                                                                
> 
> 
> 
> 
> On Wed, 2007-02-07 at 11:57 +0100, Philippe Gerum wrote:
> > On Wed, 2007-02-07 at 11:36 +0100, Markus Osterried wrote:
> > > Hello,
> > >
> > > in pSOS skin function ev_receive() in file event.c I've found a bug.
> > > When  ev_receive() is called with EV_WAIT and an event is received, the
> > > task is unblocked and everything is okay, then in this case the copy of
> the
> > > actual received events into *events_r is missing.
> >
> > Confirmed and fixed, thanks.
> >
> > --- ksrc/skins/psos+/event.c             (revision 2108)
> > +++ ksrc/skins/psos+/event.c             (working copy)
> > @@ -79,9 +79,10 @@
> >
> >            if (xnthread_test_info(&task->threadbase, XNBREAK))
> >                        err = -EINTR;
> > -          else if (xnthread_test_info(&task->threadbase, XNTIMEO)) {
> > +          else {
> >                        *events_r = task->waitargs.evgroup.events;
> > -                      err = ERR_TIMEOUT;
> > +                      if (xnthread_test_info(&task->threadbase,
> XNTIMEO))
> > +                                  err = ERR_TIMEOUT;
> >            }
> >
> >        unlock_and_exit:
> >
> 
> Actually, there was a second bug hiding in the timeout case, where the
> copy back value was wrong, we should have returned the current state of
> the event flag group and we returned the pended event mask instead. The
> following patch against 2.3.0 fixes both issues.
> 
> --- ksrc/skins/psos+/event.c         (revision 2134)
> +++ ksrc/skins/psos+/event.c         (working copy)
> @@ -80,9 +80,10 @@
>              if (xnthread_test_info(&task->threadbase, XNBREAK))
>                          err = -EINTR;
>              else if (xnthread_test_info(&task->threadbase, XNTIMEO)) {
> +                        err = ERR_TIMEOUT;
> +                        *events_r = evgroup->events;
> +            } else
>                          *events_r = task->waitargs.evgroup.events;
> -                        err = ERR_TIMEOUT;
> -            }
> 
>        unlock_and_exit:
> 
> 
> --
> Philippe.
> 
> 
> 
> 
> 
> 
> 
> 
-- 
Philippe.



