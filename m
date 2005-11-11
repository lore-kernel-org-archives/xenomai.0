In-Reply-To: <437464B2.6030204@domain.hid>
Subject: Re: [Xenomai-help] printk
Message-ID: <OF1D0CCC98.82E4D674-ONC12570B6.003B9ABD-C12570B6.003D16B7@domain.hid>
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Date: Fri, 11 Nov 2005 12:07:15 +0100
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBFA25DFA81C2D8f9e8a93df938690918c4EBBFA25DFA81C2D"
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
To: Ignacio =?ISO-8859-1?Q?Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai@xenomai.org

--0__=4EBBFA25DFA81C2D8f9e8a93df938690918c4EBBFA25DFA81C2D
Content-type: text/plain; charset=US-ASCII


xenomai-help-bounces@domain.hid wrote on 11.11.2005 10:30:26:

> Hi,
>
> I'm porting an app from RTAI to Xenomai, and when it came to the
> rt_printk function, I had to replace it with plain printk (the
> xnarch_log* functions all use printk).
>
> What I want to know if:
>
> 1- Is totally safe to call the standard kernel printk function from a
> real time task?

Actually, the adeos/ipipe patches make some changes to the vanilla kernel's
printk() mechanism.

There are 2 possible modes of printk() being issued from the primary
domain.

1) asynchronous:

all data is written into the protected buffer and the __ipipe_printk_virq
virq is risen for the secondary domain. So the data will be printed out
when the linux gets control next time.

Although, here is, well, a tiny race because of the fact that the virq
handler doesn't lock a buffer-related data (like __ipipe_printk_fill) so a
loss of data may occur under some circumstances.

2) synchronous (IPIPE_SPRINTK_FLAG)

in this case, a normal linux vprintk() call is issued. Oops, this one, in
turn, calls spin_lock_irqsave(&logbuf_lock, flags); in real-time context
and that lock may be already held by a preempted non-rt task on the same
CPU.

Houston? :o)

>
> 2- Even if it's safe, can it affect the performance of a real time task?
> (or can it block under *any* conceivable condition?)

It gives some overhead since data must be copied to the buffer and at that
time the interrupts are off.
Blocked? No, if not taking into account a possible "hang up" with the
synchronous mode (ok, as always there is still a hope that I can be wrong
):)

>
> Thanks.
>
> Nacho.
>

---
Best regards,
Dmitry
--0__=4EBBFA25DFA81C2D8f9e8a93df938690918c4EBBFA25DFA81C2D
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><font face="Arial"><br>
</font><tt>xenomai-help-bounces@domain.hid wrote on 11.11.2005 10:30:26:<br>
<br>
&gt; Hi,<br>
&gt; <br>
&gt; I'm porting an app from RTAI to Xenomai, and when it came to the<br>
&gt; rt_printk function, I had to replace it with plain printk (the<br>
&gt; xnarch_log* functions all use printk).<br>
&gt; <br>
&gt; What I want to know if:<br>
&gt; <br>
&gt; 1- Is totally safe to call the standard kernel printk function from a<br>
&gt; real time task?</tt><br>
<br>
<tt>Actually, the adeos/ipipe patches make some changes to the vanilla kernel's printk() mechanism.</tt><br>
<br>
<tt>There are 2 possible modes of printk() being issued from the primary domain.</tt><br>
<br>
<tt>1) asynchronous:</tt><br>
<br>
<tt>all data is written into the protected buffer and the </tt><tt>__ipipe_printk_virq virq is risen for the secondary domain. So the data will be printed out when the linux gets control next time.</tt><br>
<br>
<tt>Although, here is, well, a tiny race because of the fact that the virq handler doesn't lock a buffer-related data (like </tt><tt>__ipipe_printk_fill) so a loss of data may occur under some circumstances.</tt><br>
<br>
<tt>2) synchronous (</tt><tt>IPIPE_SPRINTK_FLAG</tt><tt>)</tt><br>
<br>
<tt>in this case, a normal linux vprintk() call is issued. Oops, this one, in turn, calls </tt><tt>spin_lock_irqsave(&amp;logbuf_lock, flags); in real-time context and that lock may be already held by a preempted non-rt task on the same CPU.</tt><br>
<br>
<tt>Houston? :o)</tt><br>
<tt><br>
&gt; <br>
&gt; 2- Even if it's safe, can it affect the performance of a real time task?<br>
&gt; (or can it block under *any* conceivable condition?)</tt><br>
<br>
<tt>It gives some overhead since data must be copied to the buffer and at that time the interrupts are off.</tt><br>
<tt>Blocked? No, if not taking into account a possible &quot;hang up&quot; with the synchronous mode (ok, as always there is still a hope that I can be wrong ):)</tt><br>
<tt><br>
&gt; <br>
&gt; Thanks.<br>
&gt; <br>
&gt; Nacho.<br>
&gt; <br>
</tt><br>
<tt>---</tt><br>
<tt>Best regards,</tt><br>
<tt>Dmitry</tt><br>
</body></html>
--0__=4EBBFA25DFA81C2D8f9e8a93df938690918c4EBBFA25DFA81C2D--


