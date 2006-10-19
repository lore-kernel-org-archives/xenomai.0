Message-ID: <b647ffbd0610190259m43410efbj35703d71fa2b247f@domain.hid>
Date: Thu, 19 Oct 2006 11:59:35 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [PATCH 0/3] Reworked nucleus statistics
In-Reply-To: <45368EBD.6020608@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_132799_9440120.1161251975942"
References: <452E9ACD.20800@domain.hid> <1161178927.5053.81.camel@domain.hid>
	<b647ffbd0610181306k65d7308ei10783073e550f0d1@domain.hid>
	<45368EBD.6020608@domain.hid>
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

------=_Part_132799_9440120.1161251975942
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 18/10/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> >
> > (1) time spent in ISR;
> >
> > (2) some prologue for the very first shared handler and epilogue - for
> the
> > last one.
>
> (2) is the rare case that multiple IRQs happen at the same time on the
> same line. As I said, the case when only one occurs and the others are
> needlessly tested is more often.


Indeed, it looks like "prologue" and "epilogue" are always accounted to the
ISR that reported XN_ISR_HANDLES. And if it's only one, then its position in
the chain doesn't matter.


> The "simple" model accounts only (1) to ISR time statistics so it's always
> > easy to say what's this number means. It just describes the load caused
> > by a
> > corresponding ISR handler.
>
> [sorry, Dmitry, for this replay ;)]


[off-topic]
I somehow read it as "sorry for this _reply_" and thought you had expressed
below all you think about my complains and myself... but, ok. you are more
polit-correct :)))

I designed this instrumentation with a fairly old question of mine in
> the head: "What does raising this IRQ, say, at 1 KHz costs the system?"
> And this question includes not just the ISR itself, but also the
> disturbance due to potential rescheduling.


Ok.


> Shared Interrupt are indeed an exception, and if we were only discussing
> non-shared instrumentation here, I guess it wouldn't be that tricky to
> find a common model. If you look at that part, I'm basically shifting
> some instrumentation point after the rescheduling, that's it.


yes, per-IRQ accounting (as opposed to per-ISR) wouldn't have a background
for such objections.

Well, if we conclude that the enhanced scheme provides better
informativeness and everyone benefiits from it, then let it be so. I don't
have any more objections [chores : uufff, haleluia!]


Jan
>
>
-- 
Best regards,
Dmitry Adamushko

------=_Part_132799_9440120.1161251975942
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><div><span class="gmail_quote">On 18/10/06, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
&gt;<br>&gt; (1) time spent in ISR;<br>&gt;<br>&gt; (2) some prologue for the very first shared handler and epilogue - for the<br>&gt; last one.<br><br>(2) is the rare case that multiple IRQs happen at the same time on the
<br>same line. As I said, the case when only one occurs and the others are<br>needlessly tested is more often.</blockquote><div><br>
Indeed, it looks like &quot;prologue&quot; and &quot;epilogue&quot; are always accounted to
the ISR that reported XN_ISR_HANDLES. And if it's only one, then its
position in the chain doesn't matter.<br>
<br>
</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; The &quot;simple&quot; model accounts only (1) to ISR time statistics so it's always
<br>&gt; easy to say what's this number means. It just describes the load caused<br>&gt; by a<br>&gt; corresponding ISR handler.<br><br>[sorry, Dmitry, for this replay ;)]</blockquote><div><br>
[off-topic]<br>
I somehow read it as &quot;sorry for this _reply_&quot; and thought you had
expressed below all you think about my complains and myself... but, ok.
you are more polit-correct :)))<br>
</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I designed this instrumentation with a fairly old question of mine in<br>the head: &quot;What does raising this IRQ, say, at 1 KHz costs the system?&quot;
<br>And this question includes not just the ISR itself, but also the<br>disturbance due to potential rescheduling.</blockquote><div><br>
Ok. <br>
</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>Shared Interrupt are indeed an exception, and if we were only discussing<br>non-shared instrumentation here, I guess it wouldn't be that tricky to
<br>find a common model. If you look at that part, I'm basically shifting<br>some instrumentation point after the rescheduling, that's it.</blockquote><div><br>
yes, per-IRQ accounting (as opposed to per-ISR) wouldn't have a background for such objections.<br>
</div><div><br>
Well, if we conclude that the enhanced scheme provides better
informativeness and everyone benefiits from it, then let it be so. I
don't have any more objections [chores : uufff, haleluia!]<br>
<br>
</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Jan<br><br></blockquote></div><br>-- <br>Best regards,<br>Dmitry Adamushko<br>
<br>


------=_Part_132799_9440120.1161251975942--

