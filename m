Message-ID: <b647ffbd0608220147r225dcd07of8c6952ad27b788b@domain.hid>
Date: Tue, 22 Aug 2006 10:47:59 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <44EAB53C.1020705@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_45441_25690815.1156236479538"
References: <b647ffbd0608212353u13a450f4w16069329cea3966a@domain.hid>
	<44EAB53C.1020705@domain.hid>
Subject: [Xenomai-core] Re: [patch, minor] irq proc output in intr.c
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_45441_25690815.1156236479538
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 22/08/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Dmitry Adamushko wrote:
> .....
> >
> > diff -urp xenomai-SVN/include/nucleus/intr.h
> xenomai-a/include/nucleus/intr.h
> > --- xenomai-SVN/include/nucleus/intr.h        2006-07-20 11:09:
> 01.000000000 +0200
> > +++ xenomai-a/include/nucleus/intr.h  2006-08-22 09:32:24.000000000+0200
> > @@ -71,7 +71,9 @@ int xnintr_mount(void);
> >
> >  void xnintr_clock_handler(void);
> >
> > +#if defined(CONFIG_PROC_FS) && defined(__KERNEL__)
> >  int xnintr_irq_proc(unsigned int irq, char *str);
> > +#endif /* CONFIG_PROC_FS && __KERNEL__ */
> >
> >      /* Public interface. */
> >
> > diff -urp xenomai-SVN/ksrc/nucleus/intr.c xenomai-a/ksrc/nucleus/intr.c
> > --- xenomai-SVN/ksrc/nucleus/intr.c   2006-07-20 12:35:40.000000000+0200
> > +++ xenomai-a/ksrc/nucleus/intr.c     2006-08-22 09:34:28.000000000+0200
> > @@ -691,6 +691,7 @@ int xnintr_mount(void)
> >       return 0;
> >  }
> >
> > +#if defined(CONFIG_PROC_FS) && defined(__KERNEL__)
> >  int xnintr_irq_proc(unsigned int irq, char *str)
> >  {
> >       xnintr_shirq_t *shirq;
> > @@ -727,6 +728,7 @@ int xnintr_irq_proc(unsigned int irq, ch
> >
> >       return p - str;
> >  }
> > +#endif /* CONFIG_PROC_FS && __KERNEL__ */
> >
> >  #else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL && !CONFIG_XENO_OPT_SHIRQ_EDGE */
> >
> > @@ -735,10 +737,31 @@ int xnintr_mount(void)
> >       return 0;
> >  }
> >
> > +#if defined(CONFIG_PROC_FS) && defined(__KERNEL__)
> >  int xnintr_irq_proc(unsigned int irq, char *str)
> >  {
> > -     return 0;
> > +     xnintr_t *intr;
> > +     char *p = str;
>
> +       spl_t s;



My bad. I run diff with an older version, the correct one was in another
directory.


> +
> > +     if (rthal_virtual_irq_p(irq)) {
> > +             p += sprintf(p, "         [virtual]");
> > +             return p - str;
> > +     } else if (irq == XNARCH_TIMER_IRQ) {
> > +             p += sprintf(p, "         %s", nkclock.name);
> > +             return p - str;
> > +     }
> > +
> > +     xnlock_get_irqsave(&nklock, s);
>
> What's the idea of this lock? I'm asking as xnintr_attach/detach should
> not run under nklock, right? So, how can it protect us then?



They can as rthal_critical_enter/exit() is no longer used in
rthal_irq_request().

Now I actually recall why I have not used a cookie field to store a
corresponding xnintr_shirq_t object. It's not safe wrt detach ops. and there
is no way to implement correct synchronization involving only the nucleus
layer.
Ok, it's possible to use something similar to xnintr_shirq_lonk/unlock() but
that would require the per-irq array also for non-irq-shared case and that's
something I wanted to avoid in the first instance. Hmm.. but maybe it's
actually not that bad...

So the problem is that the "xnint_t" object we have got as a cookie can be
deleted at any time while we are using it.

intr = rthal_irq_cookie(&rthal_domain, irq);
if (intr && *(intr->name))
            p += sprintf(p, "        %s", intr->name);


Hm.. if I am not wrong, the same problem is true for xnintr_irq_handler().

Have to think a bit more on this...



Jan
>
>

-- 
Best regards,
Dmitry Adamushko

------=_Part_45441_25690815.1156236479538
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><div><span class="gmail_quote">On 22/08/06, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Dmitry Adamushko wrote:<br>.....<br>&gt;<br>&gt; diff -urp xenomai-SVN/include/nucleus/intr.h xenomai-a/include/nucleus/intr.h<br>&gt; --- xenomai-SVN/include/nucleus/intr.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2006-07-20 11:09:01.000000000 +0200<br>&gt; +++ xenomai-a/include/nucleus/intr.h&nbsp;&nbsp;2006-08-22 09:32:
24.000000000 +0200<br>&gt; @@ -71,7 +71,9 @@ int xnintr_mount(void);<br>&gt;<br>&gt;&nbsp;&nbsp;void xnintr_clock_handler(void);<br>&gt;<br>&gt; +#if defined(CONFIG_PROC_FS) &amp;&amp; defined(__KERNEL__)<br>&gt;&nbsp;&nbsp;int xnintr_irq_proc(unsigned int irq, char *str);
<br>&gt; +#endif /* CONFIG_PROC_FS &amp;&amp; __KERNEL__ */<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* Public interface. */<br>&gt;<br>&gt; diff -urp xenomai-SVN/ksrc/nucleus/intr.c xenomai-a/ksrc/nucleus/intr.c<br>&gt; --- xenomai-SVN/ksrc/nucleus/intr.c&nbsp;&nbsp; 2006-07-20 12:35:
40.000000000 +0200<br>&gt; +++ xenomai-a/ksrc/nucleus/intr.c&nbsp;&nbsp;&nbsp;&nbsp; 2006-08-22 09:34:28.000000000 +0200<br>&gt; @@ -691,6 +691,7 @@ int xnintr_mount(void)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>&gt;&nbsp;&nbsp;}<br>&gt;<br>&gt; +#if defined(CONFIG_PROC_FS) &amp;&amp; defined(__KERNEL__)
<br>&gt;&nbsp;&nbsp;int xnintr_irq_proc(unsigned int irq, char *str)<br>&gt;&nbsp;&nbsp;{<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnintr_shirq_t *shirq;<br>&gt; @@ -727,6 +728,7 @@ int xnintr_irq_proc(unsigned int irq, ch<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return p - str;<br>&gt;&nbsp;&nbsp;}
<br>&gt; +#endif /* CONFIG_PROC_FS &amp;&amp; __KERNEL__ */<br>&gt;<br>&gt;&nbsp;&nbsp;#else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL &amp;&amp; !CONFIG_XENO_OPT_SHIRQ_EDGE */<br>&gt;<br>&gt; @@ -735,10 +737,31 @@ int xnintr_mount(void)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>&gt;&nbsp;&nbsp;}<br>&gt;<br>&gt; +#if defined(CONFIG_PROC_FS) &amp;&amp; defined(__KERNEL__)<br>&gt;&nbsp;&nbsp;int xnintr_irq_proc(unsigned int irq, char *str)<br>&gt;&nbsp;&nbsp;{<br>&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp; xnintr_t *intr;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp; char *p = str;<br><br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spl_t s;</blockquote><div><br>
<br>
My bad. I run diff with an older version, the correct one was in another directory.<br>
<br>
</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (rthal_virtual_irq_p(irq)) {<br>&gt;
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
p += sprintf(p, &quot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
[virtual]&quot;);<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return p - str;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else if (irq == XNARCH_TIMER_IRQ) {<br>&gt;
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
p += sprintf(p, &quot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; %s&quot;,
<a href="http://nkclock.name">nkclock.name</a>);<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return p - str;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp; xnlock_get_irqsave(&amp;nklock, s);<br><br>What's the idea of this lock? I'm asking as xnintr_attach/detach should
<br>not run under nklock, right? So, how can it protect us then?</blockquote><div><br>
<br>
They can as rthal_critical_enter/exit() is no longer used in rthal_irq_request().<br>
<br>
Now I actually recall why I have not used a cookie field to store a
corresponding xnintr_shirq_t object. It's not safe wrt detach ops. and
there is no way to implement correct synchronization involving only the
nucleus layer.<br>
Ok, it's possible to use something similar to
xnintr_shirq_lonk/unlock() but that would require the per-irq array
also for non-irq-shared case and that's something I wanted to avoid in
the first instance. Hmm.. but maybe it's actually not that bad...<br>
<br>
So the problem is that the &quot;xnint_t&quot; object we have got as a cookie can be deleted at any time while we are using it.<br>
<br>
intr = rthal_irq_cookie(&amp;rthal_domain, irq);<br>
<div style="direction: ltr;">if (intr &amp;&amp; *(intr-&gt;name))<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; p += sprintf(p, &quot; &nbsp; &nbsp; &nbsp; &nbsp;%s&quot;, intr-&gt;name);<br><br>
</div>
<br>
Hm.. if I am not wrong, the same problem is true for xnintr_irq_handler().<br>
<br>
 Have to think a bit more on this...<br>
&nbsp;<br>
<br>
<br>
</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Jan<br><br></blockquote></div><br clear="all"><br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_45441_25690815.1156236479538--

