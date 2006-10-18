Message-ID: <b647ffbd0610181306k65d7308ei10783073e550f0d1@domain.hid>
Date: Wed, 18 Oct 2006 22:06:10 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [PATCH 0/3] Reworked nucleus statistics
In-Reply-To: <1161178927.5053.81.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_126047_900346.1161201970500"
References: <452E9ACD.20800@domain.hid> <1161178927.5053.81.camel@domain.hid>
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

------=_Part_126047_900346.1161201970500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> ...
>
> Dmitry, are there other issues I'm missing, that you think would be
> better solved using a simpler accounting model?


So according to you, the more complex model gives users a better
understanding of behavior of their drivers/applications?

...
>   0  0      0          201357   0     00000000      2.8  IRQ1: handler1
>   0  0      0          5811       0     00000000      2.4  IRQ1: handler2

what is % in this case?

it accounts :

(1) time spent in ISR;

(2) some prologue for the very first shared handler and epilogue - for the
last one.

So in fact, part (1) can be the same for both handlers (say, just the same
code), N can be == M (irq frequency) but % numbers are different. Is it
fair?

The "simple" model accounts only (1) to ISR time statistics so it's always
easy to say what's this number means. It just describes the load caused by a
corresponding ISR handler.

Ok, if somebody wants to tell me that shared interrupts is an exceptional
and rare case, then I got it. But anyway, as long as we want to provide
per-ISR (and not per-IRQ) statistics, it adds some unclearness (unfairness)
on how to consider reported values.

I also expected that those prologue and epilogue are likely to cause much
lighter "disturbance" being added to a preempted thread (because such
threads normally should have higher % load wrt ISR anyway).

Regarding accounting only XN_ISR_HANDLED cases. At least, I suppose,
ISR[n+1] doesn't get accounted the interval of time spent by ISR[n] to
report XN_ISR_NONE?

Which brings us to the next point that I didn't get it from the 3-d patch
after looking at it brielfy (well, I didn't apply it yet).
And in general, it's getting a bit more difficult to see interrupt handling
details behind statistic-handling ones, esp. in the case of shared
interrupts. Of course, that's really a minor issue as long as users may get
better statistic information :)

ok, that was kind of a summary, I hope I didn't forget anything else as we
already had quite a long discussion with Jan.

all in all (yep, I like repeating myself :) IMHO the simple model, at least,
clearly answeres a question what's behind the numbers while the complex one
makes the answer more complex trying to be fair in one place and at the same
time adding "unfairness" in another place.


--
> Philippe.
>
>

-- 
Best regards,
Dmitry Adamushko

------=_Part_126047_900346.1161201970500
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>
<div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">...<br><br>Dmitry, are there other issues I'm missing, that you think would be<br>better solved using a simpler accounting model?
</blockquote><div><br>
So according to you, the more complex model gives users a better understanding of behavior of their drivers/applications?<br>
<br>
...<br>
&gt; &nbsp; 0 &nbsp;0 &nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;201357 &nbsp; 0 &nbsp; &nbsp; 00000000 &nbsp; &nbsp;&nbsp;
2.8&nbsp; IRQ1: handler1<br>
&gt; &nbsp; 0 &nbsp;0 &nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;5811 &nbsp; &nbsp; &nbsp; 0 &nbsp; &nbsp; 00000000 &nbsp;
&nbsp;&nbsp; 2.4 &nbsp;IRQ1: handler2<br>
<br>
what is % in this case?<br>
<br>
it accounts :<br>
<br>
(1) time spent in ISR;<br>
<br>
(2) some prologue for the very first shared handler
and epilogue - for the last one.<br>
<br>
So in fact, part (1) can be the same for both handlers (say, just the
same code), N can be == M (irq frequency) but % numbers are different.
Is it fair?<br>
<br>
The &quot;simple&quot; model accounts only (1) to ISR time statistics so it's
always easy to say what's this number means. It just describes the load
caused by a corresponding ISR handler.<br>
<br>
Ok, if somebody wants to tell me that shared interrupts is an
exceptional and rare case, then I got it. But anyway, as long as we
want to provide per-ISR (and not per-IRQ) statistics, it adds some
unclearness (unfairness) on how to consider reported values.<br>
<br>
I also expected that those prologue and epilogue are likely to cause
much lighter &quot;disturbance&quot; being added to a preempted thread (because
such threads normally should have higher % load wrt ISR anyway).<br>
<br>Regarding accounting only XN_ISR_HANDLED cases. At least, I
suppose, ISR[n+1] doesn't get accounted the interval of time spent by
ISR[n] to report XN_ISR_NONE?<br>
<br>
Which brings us to the next point that I didn't get it from the 3-d
patch after looking at it brielfy (well, I didn't apply it yet).<br>
And in general, it's getting a bit more difficult to see interrupt
handling details behind statistic-handling ones, esp. in the case of
shared interrupts. Of course, that's really a minor issue as long as
users may get better statistic information :)<br><br>ok, that was kind of a summary, I hope I didn't forget anything else as we already had quite a long discussion with Jan.<br>
<br>
all in all (yep, I like repeating myself :) IMHO the simple model, at
least, clearly answeres a question what's behind the numbers while the
complex one makes the answer more complex trying to be fair in one
place and at the same time adding &quot;unfairness&quot; in another place.<br>
<br>
</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">--<br>Philippe.<br><br></blockquote></div><br clear="all"><br>-- <br>Best regards,
<br>Dmitry Adamushko<br>
<br>


------=_Part_126047_900346.1161201970500--

