From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <b647ffbd0608301436l431b0256k129a9000df7636db@domain.hid>
References: <b647ffbd0608221412s3167e49fx843da826f870b03c@domain.hid>
	<1156286237.4319.124.camel@domain.hid>
	<b647ffbd0608301436l431b0256k129a9000df7636db@domain.hid>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 00:21:20 +0200
Message-Id: <1156976481.28417.43.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [patch,
	minor] irq proc output + ipipe_unregister_domain() vs.
	ipipe_sync_stage()
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
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2006-08-30 at 23:36 +0200, Dmitry Adamushko wrote:
> I cc'ed the list.
> 
> 
>         > Probably the only sane way (at least as I can see now) to
>         implement
>         > xnintr_irq_proc() safely for non-shared case is also to make
>         use of 
>         > nklock + irq off (as it should be synched wrt the primary
>         domain) and
>         > then the same should be done in xnintr_attach/detach(). In
>         non shared
>         > case, these 2 ones are safe wrt each other as both are
>         directly mapped 
>         > on ipipe_virtualize_irq(). So nklock is only required for
>         the safe
>         > synch wrt xnintr_irq_proc() and that's something I don't
>         like.
>         >
>         
>         Well, the major issue I'd see is about calling sprintf()
>         within the 
>         superlock protection, which makes me a bit nervous
>         latency-wise, but I
>         don't see any other solution right now.
> 
> 
> btw, all primitives of the native skin make use of sprintf() in
> __primitive_read_proc().
> 
> e.g.
> 
> the impact of __mutex_read_proc() can be much higher than of
> xnintr_irq_proc() with the same approach. Basically it's O(N) where N
> is a number of names to be printed. And a worst case situation for
> __mutex_read_proc [ when a number of blocked threads
> (__mutex_read_proc) > a number of registered IRQ handlers on the same
> line (xnintr_irq_proc) ] is much likely to happen.
> 

This is why I said that using sprintf() in such context makes me
nervous, but since I did not have a low cost replacement for keeping the
list consistent while walking through it, I used this dumb approach.

> In case of strings, e.g.
> 
> __mutex_read_proc :
> 
> p += sprintf(p, "+%s\n", xnthread_name(sleeper));
> 
> 
> (similar in xnintr_irq_proc())
> 
> we could do 
> 
> *(p++) = '+';
> p += our_strcpy(p, some_name);
> 
> char *our_strcpy(char *dest, const char *src)
> {
>         char *tmp = dest;
> 
>         while ((*dest++ = *src++) != '\0')
>                 /* nothing */;
>         return dest - tmp;
> }
> 
> it's different from standard strcpy() in the way that it returns a
> number of written symbols and that's what we need here to update "p".
> 
> There is also standard strlcpy() but it 
> 
> first calls (1) strlen() and then (2) memove() which is seemingly less
> optimal but OTOH both (1) and (2) are normally available in
> CPU-optimized variants. So I don't want to speculate which one is
> better, tests would reveal.
> 
> vsnprintf(), which is called by snprintf() consumes about 1,5 kb of
> code on my machine.
> 
> So ok, it's lickely less cache friendly (cache-friendly? de-ja-vu
> indeed :) but maybe it's not that important here as a linux
> application (e.g. cat /proc/xenomai/something) that calls it likely
> disturbed the cache already quite a lot.
> Pure execution time vs. e.g. our_strcpy() should be likely longer so
> we may win something indeed.
> 

We should not care of cache issues there. We are running in a non
real-time context, and before we run our /proc routines, most of the
usual cache trashing the regular kernel imposes on the real-time
sub-system has already taken place, and which in any case, is several
order of magnitude higher than what our /proc formatting routine
actually costs. So...

> Any thoughts?
> 

A way to solve this would be to have a transaction identifier into each
object descriptor, that is incremented each time the object's internal
state is altered (e.g. removal/insertion of some element from/to the
pendq and so on). Each /proc routine would:

1- get the lock
2- read the transaction identifier from the object
3- release the lock
4- sprintf() as much as it needs in loop
5- re-acquire the lock
6a- revalidate the object (deleted?)
6b- re-read the transaction identifier from the object
7- restart from #3 if identifiers do not match.

It's basically the same approach Jan used for fixing
the /proc/xenomai/sched and /stat routines.

> 
> 
>         --
>         Philippe.
>         
> 
> 
> -- 
> Best regards,
> Dmitry Adamushko
-- 
Philippe.



