Date: Thu, 14 Oct 2004 09:41:22 -0400 (EDT)
From: Currie Reid <curriereid@domain.hid>
Message-ID: <Pine.LNX.4.44L.0410140906250.1592-100000@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Adeos-main] Behaviour of adeos_catch_event when domain unregistered
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
To: adeos-main@gna.org

Hello all,

I am just trying to understand the underlying behaviour of adeos, and in
my testing I have come across some behaviour that I want to verify is
correct.  If I set a handler for ADEOS_EXIT_PROCESS without registering a
domain, then the handler is in the root domain and behaves as expected
(thank you printk!).  Next, I do a handler in a registered domain for
ADEOS_EXIT_PROCESS and perform 2 tests - 1 where the handler doesn't
propagate the event to the root domain, and one where it does.  These both
behave as expected - when propagated, I see the handler executing once for
each domain.  But when I unload the module and unregister the domain, the
handler in the root domain no longer executes - I would have thought that
the handler would still be in place.

If I register 2 domains and duplicate the test, when the higher priority
domain is unregistered, the lower priority domain starts handling the
events again, as expected.  I haven't delved into to code to see how easy
this is to change - mostly because I'm not sure that this isn't
uninitended behaviour.

I am currently performing testing on a g4 powermac using
adeos-linuxppc-2.6.8rc1-r6c8.patch.

Currie


