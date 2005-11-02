In-Reply-To: <4367A60D.9030108@domain.hid>
Subject: Re: [Xenomai-core] [RFC] support for sharing IRQs
Message-ID: <OF28F322D2.5578F6D9-ONC12570AD.003C7FD4-C12570AD.00491DDF@datacon.at>
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Date: Wed, 2 Nov 2005 14:18:37 +0100
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBFA3EDFAFF9448f9e8a93df938690918c4EBBFA3EDFAFF944"
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

--0__=4EBBFA3EDFAFF9448f9e8a93df938690918c4EBBFA3EDFAFF944
Content-type: text/plain; charset=US-ASCII


> >> [...]

> >>e.g.
> >>
> >>the "cookie" remains opaque for the ipipe but when requested by
> >>HAL::rthal_irq_request() or NUCLEUS::xnintr_irq_handler() it's treated
as a
> >>chain of ISR handlers.
> >>
> >
> >
> > Yep, that's also what I had in mind about potential ipipe changes and
> > their use in the nucleus.
> >
>
> Ok, let's go for those changes this way:
>
> 1. The I-pipe series needs to be updated so that an opaque cookie
ispassed to
> the handler; since we have a change in the interface, the 1.1 serieshas
to be
> started for this purpose.
>
> 2. In order to let the people running the legacy RTAI/fusion and
> Xenomai 2.0.x
> series a reasonable amount of time to upgrade their patchset, the IRQ
layer
> updates (sharing and trampoline suppression) will go to the Xenomai 2.1
dev
> branch. IOW, Xenomai 2.1 will be exclusively based on the I-pipe 1.1
series,
> which also means that Xenomai support for the oldgen Adeos and I-pipe 1.0

> patches will be discontinued after the Xenomai 2.0.x series is closed.
>
> 3. Changes in the IRQ layer will be made at nucleus level, which is the
most
> efficient way to provide them.
>

Ok, I'd take this task (err.. since I'm not doing anything useful for
Xenomai at the moment). Although, I may start not earlier than next week.
Jan, since you have come up with the initial proposol and maybe you need
get that new code working asap, it's up to you to handle it on your own :o)
Just let me know in that case.


>
> --
>
> Philippe.
>

---
Best regards,
Dmitry
--0__=4EBBFA3EDFAFF9448f9e8a93df938690918c4EBBFA3EDFAFF944
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt>&gt; &gt;&gt; [...]</tt><br>
<br>
<tt>&gt; &gt;&gt;e.g.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;the &quot;cookie&quot; remains opaque for the ipipe but when requested by <br>
&gt; &gt;&gt;HAL::rthal_irq_request() or NUCLEUS::xnintr_irq_handler() it's treated as a <br>
&gt; &gt;&gt;chain of ISR handlers.<br>
&gt; &gt;&gt;<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; Yep, that's also what I had in mind about potential ipipe changes and<br>
&gt; &gt; their use in the nucleus.<br>
&gt; &gt; <br>
&gt; <br>
&gt; Ok, let's go for those changes this way:<br>
&gt; <br>
&gt; 1. The I-pipe series needs to be updated so that an opaque cookie ispassed to <br>
&gt; the handler; since we have a change in the interface, the 1.1 serieshas to be <br>
&gt; started for this purpose.<br>
&gt; <br>
&gt; 2. In order to let the people running the legacy RTAI/fusion and <br>
&gt; Xenomai 2.0.x <br>
&gt; series a reasonable amount of time to upgrade their patchset, the IRQ layer <br>
&gt; updates (sharing and trampoline suppression) will go to the Xenomai 2.1 dev <br>
&gt; branch. IOW, Xenomai 2.1 will be exclusively based on the I-pipe 1.1 series, <br>
&gt; which also means that Xenomai support for the oldgen Adeos and I-pipe 1.0 <br>
&gt; patches will be discontinued after the Xenomai 2.0.x series is closed.<br>
&gt; <br>
&gt; 3. Changes in the IRQ layer will be made at nucleus level, which is the most <br>
&gt; efficient way to provide them.<br>
&gt; <br>
</tt><br>
<tt>Ok, I'd take this task (err.. since I'm not doing anything useful for Xenomai at the moment). Although, I may start not earlier than next week.</tt><br>
<tt>Jan, since you have come up with the initial proposol and maybe you need get that new code working asap, it's up to you to handle it on your own :o) Just let me know in that case.</tt><br>
<br>
<tt><br>
&gt; <br>
&gt; -- <br>
&gt; <br>
&gt; Philippe.<br>
&gt; <br>
</tt><br>
<tt>---</tt><br>
<tt>Best regards,</tt><br>
<tt>Dmitry</tt><br>
</body></html>
--0__=4EBBFA3EDFAFF9448f9e8a93df938690918c4EBBFA3EDFAFF944--


