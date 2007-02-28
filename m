Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] Kernel-OOps
Date: Wed, 28 Feb 2007 14:25:58 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB01B539F4@domain.hid>
In-Reply-To: <1172658914.23961.9.camel@domain.hid>
References: <DD39B5C3F4963040ADC9768BE7E430CB01B5368C@is-hdq-exchange.marel.net>
	<DD39B5C3F4963040ADC9768BE7E430CB01B536B3@domain.hid>
	<1172587094.27967.10.camel@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01B53705@domain.hid>
	<1172603004.10171.24.camel@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01B5387C@is-hdq-exchange.marel.net>
	<1172658914.23961.9.camel@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Philippe Gerum wrote:
>=20
> In theory, you might be right. In practice, there is no way to be
> 100% sure that under such situation, the wipe out would succeed,
> _that_ is the problem. We could devise something with a watermark,
> starting to spam the syslog with warning messages after some pressure
> level is reached, but even the wipe out operation would have to
> follow the OOM "strategy", i.e. not necessarily killing the real
> offending application but any random thread which happens to be
> registered in the drop queue, which is terminally useless when
> debugging.       =20
>=20
> Again, the situation you encounter is a sign of a patent
> dysfunctioning due to a design issue in your application. We could
> raise the limit so that statistically, the issue would not even
> trigger in your case, like it never triggered for anyone else for the
> last two years. But, for that particular issue occurring in sched.c,
> there is nothing 100% safe and sane we could do to recover such
> situation, so let's not pretend that a system works just because it
> does not run into any BUG_ON(). As it is, your application is living
> on the edge, and this is what you need to solve, and for that
> purpose, a BUG_ON() which points you at the problem immediately
> during the testing phase is much better that killing any thread
> around randomly while in production, just for the purpose of "being
> graceful". This would not be graceful, at all.           =20

Well I am still not having an idea what you mean that the application is
"on the edge". Ok, there is a bunch of threads initialized with a number
of message queues, semaphores, condition variables, probably most things
the POSIX interface provides, accumulating in a heap size of more than
130 KB. I configured a heap size of 512KB. These threads are doing most
of the time nothing. According to /proc/xenomai/stat only seldom mode
changes happen. There are a few timer threads doing clock_nanosleep(),
sending some messages around to some threads if some timer expire. A
maximum of 16 tasks could have some steady activity which lead to CSW's
but as I said almost no MSW's happen.
I think one might break up the one process / 50 threads model to
something like more processes / less threads, but this is existing
software coming from a PSOS background and at first the software has to
be ported (to POSIX) and afterwards some redesign will probably happen.
Could you maybe give a more general view on what the application should
not do in the mentioned case, so a later redesign could consider your
recommendations ?

BTW, the application runs very nicely so far. We are pleased with
Xenomai's performance. This is our second application we are porting to
Xenomai and it's the biggest we have. So far only the Kernel oops was
sort of annoying, but at least we know now how to work around it.


Best regards,

Daniel Schnell.


