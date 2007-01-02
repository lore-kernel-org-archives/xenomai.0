Message-ID: <459A6CFD.4030805@domain.hid>
Date: Tue, 02 Jan 2007 15:32:29 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <459A31E3.40807@domain.hid> <1167744149.30347.2.camel@domain.hid>	
	<459A5E92.6030504@domain.hid> <1167745769.30347.6.camel@domain.hid>	
	<459A64A9.4060707@domain.hid>
	<1167747223.30347.10.camel@domain.hid> <459A6A88.8000803@domain.hid>
In-Reply-To: <459A6A88.8000803@domain.hid>
Content-Type: multipart/mixed; boundary="------------050904080103060709000501"
Subject: [Xenomai-core] Re: SVN checkin #2010
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
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------050904080103060709000501
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7Bit

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>On Tue, 2007-01-02 at 14:56 +0100, Gilles Chanteperdrix wrote:
>>
>>>Philippe Gerum wrote:
>>>
>>>>On Tue, 2007-01-02 at 14:30 +0100, Gilles Chanteperdrix wrote:
>>>>
>>>>
>>>>>Philippe Gerum wrote:
>>>>>
>>>>>
>>>>>>On Tue, 2007-01-02 at 11:20 +0100, Jan Kiszka wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>>>Hi all - and happy new year,
>>>>>>>
>>>>>>>I haven't looked at all the new code yet, only the commit messages. I
>>>>>>>found something similar to my fast-forward-on-timer-overrun patch in
>>>>>>>#2010 and wondered if Gilles' original concerns on side effects for the
>>>>>>>POSIX skin were addressed [1]. I recalled that my own final summary on
>>>>>>>this was "leave it as it is" [2].
>>>>>>>
>>>>>>
>>>>>>The best approach is to update the POSIX skin so that it does not rely
>>>>>>on the timer code to act in a sub-optimal way; that's why this patch
>>>>>>found its way in. Scheduling and processing timer shots uselessly is a
>>>>>>bug, not a feature in this case.
>>>>>
>>>>>There is some work to be done on the posix skin anyway, this will all be
>>>>>at once. By the way, I tested the trunk on ARM, and I still get a lockup
>>>>>when the latency period is too low. I wonder if we should not compare to
>>>>>"now + nkschedlat", or even use xnarch_get_cpu_tsc() instead of "now".
>>>>
>>>>You mean as below, in order to account for the time spent in the handler(s)?	
>>>>
>>>>-	while ((xntimerh_date(&timer->aplink) += timer->interval) < now)
>>>>+	while ((xntimerh_date(&timer->aplink) += timer->interval) < xnarch_get_cpu_tsc())
>>>>		    ;
>>>>
>>>
>>>I mean even:
>>>
>>>	while ((xntimerh_date(&timer->aplink) += timer->interval) <
>>>		xnarch_get_cpu_tsc() + nkschedlat)
>>>                 ;
>>>
>>>Because if the timer date is between now and now + nkschedlat, its
>>>handler will be called again.
>>>
>>
>>Ack.
>>
> 
> 
> Keep in mind that this code is now a performance regression for the
> non-overflow case, specifically when xnarch_get_cpu_tsc() costs more
> than just a simple CPU register access.
> 
> My previous "leave it as it is" was also due to the consideration that
> we shouldn't pay too much in hotpaths for things that go wrong on
> misdesigned systems.

What about a greedy version like this.

-- 
                                                 Gilles Chanteperdrix

--------------050904080103060709000501
Content-Type: text/x-patch;
 name="xeno-greedy-timer-fast-forward.diff"
Content-Disposition: inline;
 filename="xeno-greedy-timer-fast-forward.diff"
Content-Transfer-Encoding: Quoted-Printable

Index: ksrc/nucleus/timer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/timer.c	(r=C3=A9vision 2037)
+++ ksrc/nucleus/timer.c	(copie de travail)
@@ -184,10 +184,10 @@
 	xntimer_t *timer;
 	xnticks_t now;
=20
+	now =3D xnarch_get_cpu_tsc();
 	while ((holder =3D xntimerq_head(timerq)) !=3D NULL) {
 		timer =3D aplink2timer(holder);
=20
-		now =3D xnarch_get_cpu_tsc();
 		if (xntimerh_date(&timer->aplink) - nkschedlat > now)
 			/* No need to continue in aperiodic mode since timeout
 			   dates are ordered by increasing values. */
@@ -199,6 +199,7 @@
 			if (!testbits(nktbase.status, XNTBLCK)) {
 				timer->handler(timer);
=20
+				now =3D xnarch_get_cpu_tsc();
 				if (timer->interval =3D=3D XN_INFINITE ||
 				    !testbits(timer->status, XNTIMER_DEQUEUED)
 				    || testbits(timer->status, XNTIMER_KILLED))
@@ -221,8 +222,9 @@
 			   translates into precious microsecs on low-end hw. */
 			__setbits(sched->status, XNHTICK);
=20
-		while ((xntimerh_date(&timer->aplink) +=3D timer->interval) < now)
-		    ;
+		do {
+			xntimerh_date(&timer->aplink) +=3D timer->interval;
+		} while (xntimerh_date(&timer->aplink) < now + nkschedlat);
 		xntimer_enqueue_aperiodic(timer);
 	}
=20

--------------050904080103060709000501--

