In-Reply-To: <436613FF.50604@domain.hid>
Subject: Re: [Xenomai-core] [RFC] support for sharing IRQs
Message-ID: <OF52EBEF44.18C1609B-ONC12570AB.004913D2-C12570AB.004F9693@domain.hid>
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Date: Mon, 31 Oct 2005 15:29:18 +0100
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBFA38DFDA95428f9e8a93df938690918c4EBBFA38DFDA9542"
Content-Disposition: inline
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

--0__=4EBBFA38DFDA95428f9e8a93df938690918c4EBBFA38DFDA9542
Content-type: text/plain; charset=US-ASCII


Hi Jan,

>
> I have some code hanging around here which implements IRQ sharing at
> skin level for an experimental in-house development over Xenomai. The
> code is smart enough to register an IRQ sharing trampoline handler only
> in case sharing is actually practiced for a specific line.

Could you be a bit more specific on what is meant by "...sharing is
actually practiced for a specific line"?

To my knowledge, the matter is only about whether a certain device (driver)
permits the earlier obtained irq line to be shared with other devices.
i.e. a driver [1] may succeed with an irq registration request in case
another driver [2] already holds this line but both [1] and [2] have
specified a SA_SHIRQ flag.


> I think it would be possible to break this out and generate a mainline
> patch. Anyway, the question for me is where to put this best, at skin
> (RTDM?) or at nucleus level? Both is technically feasible, but which way
> is desired? (I would vote for the nucleus...)

If we have a policy that all the drivers should be implemented on top of
RTDM, then, it can be done there. If no (and I guess so), this feature
should be common and I'd vote for the nucleus.
It seems to me now, that some parts of the hal will be involved
(rthal_irq_request/release()) since the nucleus itself doesn't keep track
of registered irqs.


>
> Jan
>

---
Best regards,
Dmitry
--0__=4EBBFA38DFDA95428f9e8a93df938690918c4EBBFA38DFDA9542
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt><br>
Hi Jan,<br>
</tt><br>
<tt>&gt; <br>
&gt; I have some code hanging around here which implements IRQ sharing at<br>
&gt; skin level for an experimental in-house development over Xenomai. The<br>
&gt; code is smart enough to register an IRQ sharing trampoline handler only<br>
&gt; in case sharing is actually practiced for a specific line.</tt><br>
<br>
<tt>Could you be a bit more specific on what is meant by &quot;...sharing is actually practiced for a specific line&quot;?</tt><br>
<br>
<tt>To my knowledge, the matter is only about whether a certain device (driver) permits the earlier obtained irq line to be shared with other devices.</tt><br>
<tt>i.e. a driver [1] may succeed with an irq registration request in case another driver [2] already holds this line but both [1] and [2] have specified a SA_SHIRQ flag.</tt><br>
<br>
<br>
<tt>&gt; I think it would be possible to break this out and generate a mainline<br>
&gt; patch. Anyway, the question for me is where to put this best, at skin<br>
&gt; (RTDM?) or at nucleus level? Both is technically feasible, but which way<br>
&gt; is desired? (I would vote for the nucleus...)</tt><br>
<br>
<tt>If we have a policy that all the drivers should be implemented on top of RTDM, then, it can be done there. If no (and I guess so), this feature should be common and I'd vote for the nucleus.</tt><br>
<tt>It seems to me now, that some parts of the hal will be involved (rthal_irq_request/release()) since the nucleus itself doesn't keep track of registered irqs.</tt><br>
<br>
<tt><br>
&gt; <br>
&gt; Jan<br>
&gt; <br>
</tt><br>
<tt>---</tt><br>
<tt>Best regards,</tt><br>
<tt>Dmitry</tt><br>
</body></html>
--0__=4EBBFA38DFDA95428f9e8a93df938690918c4EBBFA38DFDA9542--


