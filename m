Date: Thu, 14 Oct 2004 14:13:50 -0400 (EDT)
From: Currie Reid <curriereid@domain.hid>
Subject: Re: [Adeos-main] Behaviour of adeos_catch_event when domain unregistered
In-Reply-To: <1097771420.668.5.camel@domain.hid>
Message-ID: <Pine.LNX.4.44L.0410141400240.1592-100000@domain.hid>
References: <Pine.LNX.4.44L.0410140906250.1592-100000@domain.hid>
 <1097771420.668.5.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org

Hello Philippe,

The patch works, but raises one or two questions (sorry!).  First, I
understood what you meant about the disappearing handler crashing the box,
so what I did in the root level domain is on module unloading I reset the
handler to null -

static void __exit my_cleanup( void ){

   adeos_catch_event( ADEOS_EXIT_PROCESS, 0 );
   adeos_unregister_domain( &domain_desc );
}

which works in the root domain.  So I figured that this might be a proper
clean-up procedure in higher priority domains.  So I did the same thing in
the module cleanup routine when registering a domain for the same event.
When this module is unloaded, the handler does not default back to the
root domain handler.  Without the cleanup, it works as I would have
expected, but if I reset the handler in the higher priority domain, it
seems to wipe out the handler further down the pipe.  Again, I don't know
if this is intended behaviour, but I would have thought that setting the
event handler in a higher priority domain to null would have no affect on
lower priority (or root) domains.  These lower priority domains would
retain the handler attributed to them at the time of their entry.

Currie


On Thu, 14 Oct 2004, Philippe Gerum wrote:

> On Thu, 2004-10-14 at 15:41, Currie Reid wrote:
> > Hello all,
> >
> > I am just trying to understand the underlying behaviour of adeos, and in
> > my testing I have come across some behaviour that I want to verify is
> > correct.  If I set a handler for ADEOS_EXIT_PROCESS without registering a
> > domain, then the handler is in the root domain and behaves as expected
> > (thank you printk!).  Next, I do a handler in a registered domain for
> > ADEOS_EXIT_PROCESS and perform 2 tests - 1 where the handler doesn't
> > propagate the event to the root domain, and one where it does.  These both
> > behave as expected - when propagated, I see the handler executing once for
> > each domain.  But when I unload the module and unregister the domain, the
> > handler in the root domain no longer executes - I would have thought that
> > the handler would still be in place.
> >
> > If I register 2 domains and duplicate the test, when the higher priority
> > domain is unregistered, the lower priority domain starts handling the
> > events again, as expected.  I haven't delved into to code to see how easy
> > this is to change - mostly because I'm not sure that this isn't
> > uninitended behaviour.
> >
>
> Actually, this is. I mean: a bug. Please try applying the following
> patch to adeos/generic.c and let me know of the outcome. This said, keep
> in mind that fixing this bug will make your box crash if you intend to
> keep a handler attached which ends up disappearing from the address
> space after the module is unloaded.
> Thanks for the report.
>
> --- generic.c	4 Oct 2004 17:34:19 -0000	1.17
> +++ generic.c	14 Oct 2004 16:24:53 -0000
> @@ -173,7 +173,7 @@
>
>      for (event = 0; event < ADEOS_NR_EVENTS; event++)
>  	/* Need this to update the monitor count. */
> -	adeos_catch_event(event,NULL);
> +	adeos_catch_event_from(adp,event,NULL);
>
>  #ifdef CONFIG_SMP
>      {
> --
>
> Philippe.
>
>


