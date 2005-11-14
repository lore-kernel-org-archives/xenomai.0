In-Reply-To: <4378956D.8040706@domain.hid>
Message-ID: <OFBDFF2ABC.D4775297-ONC12570B9.004E7A08-C12570B9.00517F6A@datacon.at>
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Date: Mon, 14 Nov 2005 15:50:10 +0100
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBFA2ADFDDFC988f9e8a93df938690918c4EBBFA2ADFDDFC98"
Content-Disposition: inline
Subject: [Xenomai-core] Re: [Xenomai-help] printk
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, xenomai@xenomai.org

--0__=4EBBFA2ADFDDFC988f9e8a93df938690918c4EBBFA2ADFDDFC98
Content-type: text/plain; charset=US-ASCII


> > ...
> >
> > This cannot happen in async mode, since the output would be buffered
and
> > printk() never called on behalf of the preempted handler.
> >
> >>
> >> let's say at the (*) point
> >>
> >> void __ipipe_flush_printk (unsigned virq)
> >> {
> >>       char *p = __ipipe_printk_buf;
> >>       int out = 0, len;
> >>
> >>       clear_bit(IPIPE_PPRINTK_FLAG,&ipipe_root_domain->flags);
> >>
> >>       while (out < __ipipe_printk_fill) {
> >>               len = strlen(p) + 1;
> >>               printk("%s",p);
> >>               p += len;
> >>               out += len;
> >>       }
> >> (*) <---------------------------- preempted
> >>       __ipipe_printk_fill = 0;
> >> }
> >>
> >> When linux gets controll back the virq continues its execution and
> >> sets __ipipe_printk_fill up to 0.
> >>
> >> This cannot happen only if virqs are manipulated with the primary
> >> domain being stalled as well. But you told "and under __Linux
> >> domain___ stalling protection in __ipipe_flush_printk since it's a
> >> virq handler".
> >>
> >>
> >>  > and finally, printk() cannot preempt
> >>  > __ipipe_flush_printk under normal operation mode (i.e. async mode).

> >> AFAICS,
> >>  > there's no race here.
>
> Mea culpa, Dmitry is right, in the above situation he depicted, we
> could drop a
> portion of the output buffer. A way to fix this would be to hw lock
> a test and
> decrement section of __ipipe_printk_fill in the flush handler.
>

Something like that (just a draft) would work probably but I suppose
something a bit more graceful would be implemented. Actually, with a small
optimization of IPIPE_PRINTK_FLAG.

void __ipipe_flush_printk (unsigned virq)
{
       char *p = __ipipe_printk_buf;
-       int out = 0, len;
+       int out = 0, len, used;

...
-       clear_bit(IPIPE_PPRINTK_FLAG,&ipipe_root_domain->flags);
...

+ spin_lock_irqsave_hw(&__ipipe_printk_lock,flags);
+ used = __ipipe_printk_fill;
+ spin_unlock_irqrestore_hw(&__ipipe_printk_lock,flags);

+ oncemore:

       while (out < used) {
               len = strlen(p) + 1;
               printk("%s",p);
               p += len;
               out += len;
       }

+ spin_lock_irqsave_hw(&__ipipe_printk_lock,flags);
+ if (__ipipe_printk_fill == used)
+     {
-       __ipipe_printk_fill = 0;

+     used = __ipipe_printk_fill = 0;

+     // when everything is done
+      clear_bit(IPIPE_PPRINTK_FLAG,&ipipe_root_domain->flags);

+     }
+ else
+     used = __ipipe_printk_fill;
+ spin_unlock_irqrestore_hw(&__ipipe_printk_lock,flags);

+ if (used)
+     goto oncemore;

...
}

and

asmlinkage int printk(const char *fmt, ...)
{
+      int virq_is_active;
...

       spin_lock_irqsave_hw(&__ipipe_printk_lock,flags);

       fbytes = __LOG_BUF_LEN - __ipipe_printk_fill;

       if (fbytes > 1) {
               r = vscnprintf(__ipipe_printk_buf + __ipipe_printk_fill,
                              fbytes, fmt, args) + 1; /* account for the
null byte */
               __ipipe_printk_fill += r;
       } else
               r = 0;

+      virq_is_active =
test_and_set_bit(IPIPE_PPRINTK_FLAG,&ipipe_root_domain->flags);

       spin_unlock_irqrestore_hw(&__ipipe_printk_lock,flags);

-      if (!test_and_set_bit(IPIPE_PPRINTK_FLAG,&ipipe_root_domain->flags))
+      if (!virq_is_active)
               ipipe_trigger_irq(__ipipe_printk_virq);
out:
       va_end(args);

       return r;
}

> --
>
> Philippe.

---
Best regards,
Dmitry
--0__=4EBBFA2ADFDDFC988f9e8a93df938690918c4EBBFA2ADFDDFC98
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt>&gt; &gt; ...<br>
&gt; &gt; <br>
&gt; &gt; This cannot happen in async mode, since the output would be buffered and <br>
&gt; &gt; printk() never called on behalf of the preempted handler.<br>
&gt; &gt; <br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; let's say at the (*) point<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; void __ipipe_flush_printk (unsigned virq)<br>
&gt; &gt;&gt; {<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; char *p = __ipipe_printk_buf;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; int out = 0, len;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; clear_bit(IPIPE_PPRINTK_FLAG,&amp;ipipe_root_domain-&gt;flags);<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; while (out &lt; __ipipe_printk_fill) {<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; len = strlen(p) + 1;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; printk(&quot;%s&quot;,p);<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; p += len;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; out += len;<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; }<br>
&gt; &gt;&gt; (*) &lt;---------------------------- preempted<br>
&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; __ipipe_printk_fill = 0;<br>
&gt; &gt;&gt; }<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; When linux gets controll back the virq continues its execution and <br>
&gt; &gt;&gt; sets __ipipe_printk_fill up to 0.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; This cannot happen only if virqs are manipulated with the primary <br>
&gt; &gt;&gt; domain being stalled as well. But you told &quot;and under __Linux <br>
&gt; &gt;&gt; domain___ stalling protection in __ipipe_flush_printk since it's a <br>
&gt; &gt;&gt; virq handler&quot;.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &nbsp;&gt; and finally, printk() cannot preempt<br>
&gt; &gt;&gt; &nbsp;&gt; __ipipe_flush_printk under normal operation mode (i.e. async mode). <br>
&gt; &gt;&gt; AFAICS,<br>
&gt; &gt;&gt; &nbsp;&gt; there's no race here.<br>
&gt; <br>
&gt; Mea culpa, Dmitry is right, in the above situation he depicted, we <br>
&gt; could drop a <br>
&gt; portion of the output buffer. A way to fix this would be to hw lock <br>
&gt; a test and <br>
&gt; decrement section of __ipipe_printk_fill in the flush handler.<br>
&gt; <br>
</tt><br>
<tt>Something like that (just a draft) would work probably but I suppose something a bit more graceful would be implemented. Actually, with a small optimization of IPIPE_PRINTK_FLAG.</tt><br>
<br>
<tt>void __ipipe_flush_printk (unsigned virq)</tt><br>
<tt>{</tt><br>
<tt> &nbsp; &nbsp; &nbsp; char *p = __ipipe_printk_buf;</tt><br>
<tt>- &nbsp; &nbsp; &nbsp; int out = 0, len;</tt><br>
<tt>+ &nbsp; &nbsp; &nbsp; int out = 0, len, used;</tt><br>
<br>
<tt>...</tt><br>
<tt>- &nbsp; &nbsp; &nbsp; clear_bit(IPIPE_PPRINTK_FLAG,&amp;ipipe_root_domain-&gt;flags);</tt><br>
<tt>...</tt><br>
<br>
<tt>+ spin_lock_irqsave_hw(&amp;__ipipe_printk_lock,flags);</tt><br>
<tt>+ used = __ipipe_printk_fill;</tt><br>
<tt>+ spin_unlock_irqrestore_hw(&amp;__ipipe_printk_lock,flags);</tt><br>
<br>
<tt>+ oncemore:</tt><br>
<br>
<tt> &nbsp; &nbsp; &nbsp; while (out &lt; used) {</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; len = strlen(p) + 1;</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; printk(&quot;%s&quot;,p);</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; p += len;</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; out += len;</tt><br>
<tt> &nbsp; &nbsp; &nbsp; }</tt><br>
<br>
<tt>+ spin_lock_irqsave_hw(&amp;__ipipe_printk_lock,flags);</tt><br>
<tt>+ if (__ipipe_printk_fill == used)</tt><br>
<tt>+	{</tt><br>
<tt>- &nbsp; &nbsp; &nbsp; __ipipe_printk_fill = 0;</tt><br>
<br>
<tt>+ &nbsp; &nbsp; used = __ipipe_printk_fill = 0;</tt><br>
<br>
<tt>+	// when everything is done</tt><br>
<tt>+ &nbsp; &nbsp; &nbsp;clear_bit(IPIPE_PPRINTK_FLAG,&amp;ipipe_root_domain-&gt;flags);</tt><br>
<br>
<tt>+	}<br>
+ else</tt><br>
<tt>+	used = __ipipe_printk_fill;</tt><br>
<tt>+ spin_unlock_irqrestore_hw(&amp;__ipipe_printk_lock,flags);</tt><br>
<br>
<tt>+ if (used)</tt><br>
<tt>+	goto oncemore;</tt><br>
<br>
<tt>...</tt><br>
<tt>}</tt><br>
<br>
<tt>and</tt><br>
<br>
<tt>asmlinkage int printk(const char *fmt, ...)</tt><br>
<tt>{</tt><br>
<tt>+	 int virq_is_active;</tt><br>
<tt>...</tt><br>
<br>
<tt> &nbsp; &nbsp; &nbsp; spin_lock_irqsave_hw(&amp;__ipipe_printk_lock,flags);</tt><br>
<br>
<tt> &nbsp; &nbsp; &nbsp; fbytes = __LOG_BUF_LEN - __ipipe_printk_fill;</tt><br>
<br>
<tt> &nbsp; &nbsp; &nbsp; if (fbytes &gt; 1) {</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; r = vscnprintf(__ipipe_printk_buf + __ipipe_printk_fill,</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;fbytes, fmt, args) + 1; /* account for the null byte */</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; __ipipe_printk_fill += r;</tt><br>
<tt> &nbsp; &nbsp; &nbsp; } else</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; r = 0;</tt><br>
<br>
<tt>+	 virq_is_active = test_and_set_bit(IPIPE_PPRINTK_FLAG,&amp;ipipe_root_domain-&gt;flags);</tt><br>
<br>
<tt> &nbsp; &nbsp; &nbsp; spin_unlock_irqrestore_hw(&amp;__ipipe_printk_lock,flags);</tt><br>
<br>
<tt>-	 if (!test_and_set_bit(IPIPE_PPRINTK_FLAG,&amp;ipipe_root_domain-&gt;flags))</tt><br>
<tt>+ &nbsp; &nbsp; &nbsp;if (!virq_is_active)</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ipipe_trigger_irq(__ipipe_printk_virq);</tt><br>
<tt>out:</tt><br>
<tt> &nbsp; &nbsp; &nbsp; va_end(args);</tt><br>
<br>
<tt> &nbsp; &nbsp; &nbsp; return r;</tt><br>
<tt>}</tt><br>
<br>
<tt>&gt; -- <br>
&gt; <br>
&gt; Philippe.<br>
</tt><br>
<tt>---</tt><br>
<tt>Best regards,</tt><br>
<tt>Dmitry</tt><br>
</body></html>
--0__=4EBBFA2ADFDDFC988f9e8a93df938690918c4EBBFA2ADFDDFC98--


