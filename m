Subject: Re: [Xenomai-core] [PATCH 0/3] Reworked nucleus statistics
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <b647ffbd0610181306k65d7308ei10783073e550f0d1@domain.hid>
References: <452E9ACD.20800@domain.hid> <1161178927.5053.81.camel@domain.hid>
	<b647ffbd0610181306k65d7308ei10783073e550f0d1@domain.hid>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 22:53:46 +0200
Message-Id: <1161291226.4959.97.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Wed, 2006-10-18 at 22:06 +0200, Dmitry Adamushko wrote:
> 
>         ...
>         
>         Dmitry, are there other issues I'm missing, that you think
>         would be
>         better solved using a simpler accounting model?
> 
> So according to you, the more complex model gives users a better
> understanding of behavior of their drivers/applications?
> 

I said the latter goal should be considered as most important one when
discussing this particular issue. Each approach having its pros/cons
regarding this goal depending on the aspect considered
(shared/non-shared, accounting accuracy etc.), the choice is about
picking the one which fulfills this goal as much as possible.

Basically, your respective approaches (i.e. Jan and yours) differ on the
criterion measuring such "fulfillment", and since there is likely no
perfect solution, we should make a trade-off on that. To sum up, you
consider that unambiguous shared IRQ accounting carries more weight,
whilst Jan seems to put more weight on charging any rescheduling cost
that could result from the ISR to the proper statistic counter, i.e. the
ISR, and not any random thread the corresponding IRQ happened to
preempt.

My guts feeling, as a possible user of this code, would be to favour
Jan's option, not because yours is essentially wrong, but rather because
it's missing what Jan's solution brings regarding the rescheduling
issue. In practice, a rescheduling costs a _lot_ more to perform
time-wise by the nucleus, than the less ambiguous measurement you could
do from an ISR prologue. My point is that, in that particular case, I'd
always prefer getting the right information from the most significant
order of magnitude.

Regarding the accounting upon XN_IRQ_HANDLED status, well, it's again a
matter of trade-off, even if the two options seem much more balanced in
their respective merits and caveats. I could vote for any of them; this
said, I think Jan's argument about shared IRQs being unusual (and I
would even add sub-optimal in a RT context) should be taken for what it
says: we should better try optimizing for the common case when there is
no real win in optimizing for the rare one. My initial question boils
down to make sure that I did not underestimate the importance of
improving the rare case.

[...]

-- 
Philippe.



