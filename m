Message-ID: <b647ffbd0703240320ta4f54ccg344108ddd1f47958@domain.hid>
Date: Sat, 24 Mar 2007 11:20:49 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] [RT_PIPE] - User space read() not waking up
In-Reply-To: <460481F2.5010408@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_243552_3767744.1174731649379"
References: <20070322215707.232970@domain.hid>
	<b647ffbd0703230142n46a215ddv5ab0e2c984d0d93c@domain.hid>
	<460481F2.5010408@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Viktor STARK <stark.viktor@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

------=_Part_243552_3767744.1174731649379
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Viktor,


I do understand the domain separation, but if I got things right, pipes
> can only be read using read() in user space. That's also what the API
> documentation suggests.


Pipes are designed to connect actors from /different/ domains, normally a
flow of data is from primary --> secondary (linux). The actor in the
secondary domain must not be hard real-time latency dependent, for the
obvious reasons I described before.

Take a look at the queue interface (rt_queue_* for the native skin).


1) Why does it happen every 10000 cycles (2 seconds)? The fact that this
> erratic behaviour is so deterministic makes me think that it might not
> be standard Linux related. I mean the fact that it happens every 2
> seconds (and I mean 2e6 us, not just approximately 2 seconds) just makes
> it look like it's provoked by something which is RT.


Maybe yes, maybe no. Some periodic linux activity (ISR, long
interrupt/preemption disabled section, hight priority task) may be a reason
as well.

2) Even if my read() is scheduled, how comes I only get past the read()
> after the second rt_pipe_write()? One would think that if my read() is
> scheduled I could be waking up after 250 us or 300 us, no? But I'm
> *always* woken up after 2 cycles (that is 400 us).
>

Maybe something has to do with your part (driver + rt task) in the primary
domain..

Could you make a small sample program which still shows this "problem" and
post it here?

Additional option is to use the I-pipe tracer as Jan suggested.


3) Pipes seemed to be a good way to transfer data from kernel space.
> What other (maybe more deterministic) way would you suggest? I'm not
> asking for a complete program architecture here just a half dozen words
> describing how you would have done it.


rt_queue_*

Well, you may post your design briefly as well and ask for comments.


Thanks in advance.
>
> Best regards,
>
> Viktor STARK
>

-- 
Best regards,
Dmitry Adamushko

------=_Part_243552_3767744.1174731649379
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>
Hello Viktor,<br>
<br>
<br>
<div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I do understand the domain separation, but if I got things right, pipes
<br>can only be read using read() in user space. That&#39;s also what the API<br>documentation suggests.</blockquote><div><br>
Pipes are designed to connect actors from /different/ domains, normally
a flow of data is from primary --&gt; secondary (linux). The actor in
the secondary domain must not be hard real-time latency dependent, for
the obvious reasons I described before.<br>
<br>
Take a look at the queue interface (rt_queue_* for the native skin).<br>
&nbsp;</div><br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">1) Why does it happen every 10000 cycles (2 seconds)? The fact that this
<br>erratic behaviour is so deterministic makes me think that it might not<br>be standard Linux related. I mean the fact that it happens every 2<br>seconds (and I mean 2e6 us, not just approximately 2 seconds) just makes
<br>
it look like it&#39;s provoked by something which is RT.</blockquote><div><br>
Maybe yes, maybe no. Some periodic linux activity (ISR, long
interrupt/preemption disabled section, hight priority task) may be a
reason as well.</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">2) Even if my read() is scheduled, how comes I only get past the read()
<br>after the second rt_pipe_write()? One would think that if my read() is<br>scheduled I could be waking up after 250 us or 300 us, no? But I&#39;m
<br>*always* woken up after 2 cycles (that is 400 us).<br>
</blockquote><div><br>
Maybe something has to do with your part (driver + rt task) in the primary domain..<br>
<br>
Could you make a small sample program which still shows this &quot;problem&quot; and post it here?<br>
<br>
Additional option is to use the I-pipe tracer as Jan suggested.<br>
<br>
<br>
</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">3) Pipes seemed to be a good way to transfer data from kernel space.<br>What other (maybe more deterministic) way would you suggest? I&#39;m not
<br>asking for a complete program architecture here just a half dozen words
<br>describing how you would have done it.</blockquote><div><br>
rt_queue_*<br>
&nbsp;<br>
Well, you may post your design briefly as well and ask for comments.<br>
<br>
</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Thanks in advance.<br><br>Best regards,<br><br>Viktor STARK<br></blockquote></div>
<br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_243552_3767744.1174731649379--

