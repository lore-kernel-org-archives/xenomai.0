Subject: Re: [Adeos-main] Behaviour of adeos_catch_event when domain
	unregistered
From: Philippe Gerum <rpm@xenomai.org>
Reply-To: rpm@xenomai.org
In-Reply-To: <Pine.LNX.4.44L.0410140906250.1592-100000@domain.hid>
References: 
	 <Pine.LNX.4.44L.0410140906250.1592-100000@domain.hid>
Content-Type: text/plain
Message-Id: <1097771420.668.5.camel@domain.hid>
Mime-Version: 1.0
Date: Thu, 14 Oct 2004 18:30:20 +0200
Content-Transfer-Encoding: 7bit
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
To: Currie Reid <curriereid@domain.hid>
Cc: adeos-main@gna.org

On Thu, 2004-10-14 at 15:41, Currie Reid wrote:
> Hello all,
> 
> I am just trying to understand the underlying behaviour of adeos, and in
> my testing I have come across some behaviour that I want to verify is
> correct.  If I set a handler for ADEOS_EXIT_PROCESS without registering a
> domain, then the handler is in the root domain and behaves as expected
> (thank you printk!).  Next, I do a handler in a registered domain for
> ADEOS_EXIT_PROCESS and perform 2 tests - 1 where the handler doesn't
> propagate the event to the root domain, and one where it does.  These both
> behave as expected - when propagated, I see the handler executing once for
> each domain.  But when I unload the module and unregister the domain, the
> handler in the root domain no longer executes - I would have thought that
> the handler would still be in place.
> 
> If I register 2 domains and duplicate the test, when the higher priority
> domain is unregistered, the lower priority domain starts handling the
> events again, as expected.  I haven't delved into to code to see how easy
> this is to change - mostly because I'm not sure that this isn't
> uninitended behaviour.
> 

Actually, this is. I mean: a bug. Please try applying the following
patch to adeos/generic.c and let me know of the outcome. This said, keep
in mind that fixing this bug will make your box crash if you intend to
keep a handler attached which ends up disappearing from the address
space after the module is unloaded.
Thanks for the report.

--- generic.c	4 Oct 2004 17:34:19 -0000	1.17
+++ generic.c	14 Oct 2004 16:24:53 -0000
@@ -173,7 +173,7 @@
 
     for (event = 0; event < ADEOS_NR_EVENTS; event++)
 	/* Need this to update the monitor count. */
-	adeos_catch_event(event,NULL);
+	adeos_catch_event_from(adp,event,NULL);
 
 #ifdef CONFIG_SMP
     {
-- 

Philippe.


