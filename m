In-Reply-To: <43787450.1050701@domain.hid>
Subject: Re: [Xenomai-help] printk
Message-ID: <OF52CB4F2C.0758DB64-ONC12570B9.0040DCB8-C12570B9.00423FCF@datacon.at>
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Date: Mon, 14 Nov 2005 13:03:37 +0100
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBFA2ADFD35A288f9e8a93df938690918c4EBBFA2ADFD35A28"
Content-Disposition: inline
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

--0__=4EBBFA2ADFD35A288f9e8a93df938690918c4EBBFA2ADFD35A28
Content-type: text/plain; charset=US-ASCII


Philippe Gerum <rpm@xenomai.org> wrote on 14.11.2005 12:26:08:

> >>
> >>Although, here is, well, a tiny race because of the fact that the virq
> >>handler doesn't lock a buffer-related data (like __ipipe_printk_fill)
> >>so a loss of data may occur under some circumstances.
> >>
>
> Nope. __ipipe_printk_fill and friends are manipulated under hw irq
> spinlocking
> in printk(), and under Linux domain stalling protection in
> __ipipe_flush_printk
> since it's a virq handler,

So what prevents some activity from the primary domain from preempting
__ipipe_flush_printk() and calling printk() when _only_ the Linux domain is
stalled?

let's say at the (*) point

void __ipipe_flush_printk (unsigned virq)
{
       char *p = __ipipe_printk_buf;
       int out = 0, len;

       clear_bit(IPIPE_PPRINTK_FLAG,&ipipe_root_domain->flags);

       while (out < __ipipe_printk_fill) {
               len = strlen(p) + 1;
               printk("%s",p);
               p += len;
               out += len;
       }
      (*)   <---------------------------- preempted
       __ipipe_printk_fill = 0;
}

When linux gets controll back the virq continues its execution and sets
__ipipe_printk_fill up to 0.

This cannot happen only if virqs are manipulated with the primary domain
being stalled as well. But you told "and under __Linux domain___ stalling
protection in __ipipe_flush_printk since it's a virq handler".


> and finally, printk() cannot preempt
> __ipipe_flush_printk under normal operation mode (i.e. async mode).
AFAICS,
> there's no race here.


---
Best regards,
Dmitry
--0__=4EBBFA2ADFD35A288f9e8a93df938690918c4EBBFA2ADFD35A28
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt>Philippe Gerum &lt;rpm@xenomai.org&gt; wrote on 14.11.2005 12:26:08:<br>
<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;Although, here is, well, a tiny race because of the fact that the virq<br>
&gt; &gt;&gt;handler doesn't lock a buffer-related data (like __ipipe_printk_fill)<br>
&gt; &gt;&gt;so a loss of data may occur under some circumstances.<br>
&gt; &gt;&gt;<br>
&gt; <br>
&gt; Nope. __ipipe_printk_fill and friends are manipulated under hw irq <br>
&gt; spinlocking <br>
&gt; in printk(), and under Linux domain stalling protection in <br>
&gt; __ipipe_flush_printk <br>
&gt; since it's a virq handler, </tt><br>
<br>
<tt>So what prevents some activity from the primary domain from preempting __ipipe_flush_printk() and calling printk() when _only_ the Linux domain is stalled?</tt><br>
<br>
<tt>let's say at the (*) point</tt><br>
<br>
<tt>void __ipipe_flush_printk (unsigned virq)</tt><br>
<tt>{</tt><br>
<tt> &nbsp; &nbsp; &nbsp; char *p = __ipipe_printk_buf;</tt><br>
<tt> &nbsp; &nbsp; &nbsp; int out = 0, len;</tt><br>
<br>
<tt> &nbsp; &nbsp; &nbsp; clear_bit(IPIPE_PPRINTK_FLAG,&amp;ipipe_root_domain-&gt;flags);</tt><br>
<br>
<tt> &nbsp; &nbsp; &nbsp; while (out &lt; __ipipe_printk_fill) {</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; len = strlen(p) + 1;</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; printk(&quot;%s&quot;,p);</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; p += len;</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; out += len;</tt><br>
<tt> &nbsp; &nbsp; &nbsp; }</tt><br>
<tt>	(*)	&lt;---------------------------- preempted</tt><br>
<tt> &nbsp; &nbsp; &nbsp; __ipipe_printk_fill = 0;</tt><br>
<tt>}</tt><br>
<br>
<tt>When linux gets controll back the virq continues its execution and sets __ipipe_printk_fill up to 0.</tt><br>
<br>
<tt>This cannot happen only if virqs are manipulated with the primary domain being stalled as well. But you told &quot;and under __Linux domain___ stalling protection in __ipipe_flush_printk since it's a virq handler&quot;.</tt><br>
<br>
<br>
<tt>&gt; and finally, printk() cannot preempt <br>
&gt; __ipipe_flush_printk under normal operation mode (i.e. async mode). AFAICS, <br>
&gt; there's no race here.</tt><br>
<br>
<br>
<tt>---</tt><br>
<tt>Best regards,</tt><br>
<tt>Dmitry</tt><br>
</body></html>
--0__=4EBBFA2ADFD35A288f9e8a93df938690918c4EBBFA2ADFD35A28--


