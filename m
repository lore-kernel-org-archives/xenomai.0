Message-ID: <b647ffbd0608301436l431b0256k129a9000df7636db@domain.hid>
Date: Wed, 30 Aug 2006 23:36:12 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <1156286237.4319.124.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_30868_13111041.1156973772112"
References: <b647ffbd0608221412s3167e49fx843da826f870b03c@domain.hid>
	<1156286237.4319.124.camel@domain.hid>
Subject: [Xenomai-core] Re: [patch,
	minor] irq proc output + ipipe_unregister_domain()
	vs. ipipe_sync_stage()
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

------=_Part_30868_13111041.1156973772112
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I cc'ed the list.


> Probably the only sane way (at least as I can see now) to implement
> > xnintr_irq_proc() safely for non-shared case is also to make use of
> > nklock + irq off (as it should be synched wrt the primary domain) and
> > then the same should be done in xnintr_attach/detach(). In non shared
> > case, these 2 ones are safe wrt each other as both are directly mapped
> > on ipipe_virtualize_irq(). So nklock is only required for the safe
> > synch wrt xnintr_irq_proc() and that's something I don't like.
> >
>
> Well, the major issue I'd see is about calling sprintf() within the
> superlock protection, which makes me a bit nervous latency-wise, but I
> don't see any other solution right now.



btw, all primitives of the native skin make use of sprintf() in
__primitive_read_proc().

e.g.

the impact of __mutex_read_proc() can be much higher than of
xnintr_irq_proc() with the same approach. Basically it's O(N) where N is a
number of names to be printed. And a worst case situation for
__mutex_read_proc [ when a number of blocked threads (__mutex_read_proc) > a
number of registered IRQ handlers on the same line (xnintr_irq_proc) ] is
much likely to happen.

In case of strings, e.g.

__mutex_read_proc :

p += sprintf(p, "+%s\n", xnthread_name(sleeper));

(similar in xnintr_irq_proc())

we could do

*(p++) = '+';
p += our_strcpy(p, some_name);

char *our_strcpy(char *dest, const char *src)
{
        char *tmp = dest;

        while ((*dest++ = *src++) != '\0')
                /* nothing */;
        return dest - tmp;
}

it's different from standard strcpy() in the way that it returns a number of
written symbols and that's what we need here to update "p".

There is also standard strlcpy() but it

first calls (1) strlen() and then (2) memove() which is seemingly less
optimal but OTOH both (1) and (2) are normally available in CPU-optimized
variants. So I don't want to speculate which one is better, tests would
reveal.

vsnprintf(), which is called by snprintf() consumes about 1,5 kb of code on
my machine.

So ok, it's lickely less cache friendly (cache-friendly? de-ja-vu indeed :)
but maybe it's not that important here as a linux application (e.g. cat
/proc/xenomai/something) that calls it likely disturbed the cache already
quite a lot.
Pure execution time vs. e.g. our_strcpy() should be likely longer so we may
win something indeed.

Any thoughts?



--
> Philippe.
>
>

-- 
Best regards,
Dmitry Adamushko

------=_Part_30868_13111041.1156973772112
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I cc'ed the list.<br>
<br><br>
<div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; Probably the only sane way (at least as I can see now) to implement<br>&gt; xnintr_irq_proc() safely for non-shared case is also to make use of
<br>&gt; nklock + irq off (as it should be synched wrt the primary domain) and<br>&gt; then the same should be done in xnintr_attach/detach(). In non shared<br>&gt; case, these 2 ones are safe wrt each other as both are directly mapped
<br>&gt; on ipipe_virtualize_irq(). So nklock is only required for the safe<br>&gt; synch wrt xnintr_irq_proc() and that's something I don't like.<br>&gt;<br><br>Well, the major issue I'd see is about calling sprintf() within the
<br>superlock protection, which makes me a bit nervous latency-wise, but I<br>don't see any other solution right now.</blockquote><div><br>
<br>
btw, all primitives of the native skin make use of sprintf() in __primitive_read_proc().<br>
<br>
e.g.<br>
<br>
the impact of __mutex_read_proc() can be much higher than of
xnintr_irq_proc() with the same approach. Basically it's O(N) where N
is a number of names to be printed. And a worst case situation for
__mutex_read_proc [ when a number of blocked threads
(__mutex_read_proc) &gt; a number of registered IRQ handlers on the
same line (xnintr_irq_proc) ] is much likely to happen.<br>
<br>
In case of strings, e.g.<br>
<br>
__mutex_read_proc :<br>
<br>
p += sprintf(p, &quot;+%s\n&quot;, xnthread_name(sleeper));<br>
<br>
</div>(similar in xnintr_irq_proc())<br>
<br>
we could do <br>
<br>
*(p++) = '+';<br>
p += our_strcpy(p, some_name);<br>
<br>
char *our_strcpy(char *dest, const char *src)<br>
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *tmp = dest;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while ((*dest++ = *src++) != '\0')<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* nothing */;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return dest - tmp;<br>
}<br>
<br>
it's different from standard strcpy() in the way that it returns a
number of written symbols and that's what we need here to update &quot;p&quot;.<br>
<br>
There is also standard strlcpy() but it <br>
<br>
first calls (1) strlen() and then (2) memove() which is seemingly less
optimal but OTOH both (1) and (2) are normally available in
CPU-optimized variants. So I don't want to speculate which one is
better, tests would reveal.<br>
<br>
vsnprintf(), which is called by snprintf() consumes about 1,5 kb of code on my machine.<br>
<br>
So ok, it's lickely less cache friendly (cache-friendly? de-ja-vu
indeed :) but maybe it's not that important here as a linux application
(e.g. cat /proc/xenomai/something) that calls it likely disturbed the
cache already quite a lot.<br>
Pure execution time vs. e.g. our_strcpy() should be likely longer so we may win something indeed.<br>
<br>
Any thoughts?<br>
<br>
<br>
<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">--<br>Philippe.<br><br></blockquote></div><br><br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_30868_13111041.1156973772112--

