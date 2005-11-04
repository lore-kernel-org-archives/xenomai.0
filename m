content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] number-crunching execution jitter
Date: Fri, 4 Nov 2005 13:30:00 +0100
Message-ID: <1CFEB358338412458B21FAA0D78FE86D4F0E5B@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dominique.RAGOT@fr.thalesgroup.com, xenomai@xenomai.org

Dominique.RAGOT wrote:
>I am using Xenomai 2.0 for a number-crunching application on
bi-processor x86 SMP and using the Posix skin.
>
>There are 2 tasks on each processor that are awaken every 20ms and
execute for 16ms.
>When there are no perturbations on the machine, the jitter on tasks
wakeup and execution time is acceptable (approx. 5%).
>
>However, when adding a simple load such as find / -print redirected to
/dev/null, the execution jitter is much worse (more than 100% in some
cases), whereas wakeup jitter remains good. My conclusion is that the
tasks are preempted when running. Is it right ?

IMHO, there are plenty of other possible reasons.
What *measurement* result makes you conclude it is preemption which
induces
execution jitter?

Rem: I assume your RT tasks are free of non-RT Linux syscalls.

>I suspect the interrupt shield to be inactive (although I see it in
/proc/adeos). How could it be activated with Posix skin ? How could it
be monitored ?

Subtract the number of interrupts handlers processed when leaving your=20
RT task by the number when entering. This measurement will tell you if=20
the interrupt shield works as expected or not.

A tool like LTT (not available now with Xenomai?) would have been able
to tell what's happening during the 20ms period.

My random guess is you're maybe in the need of a "cache-shield",=20
a "tlb-shield" and/or a "DMA-shield". All those shields (tm) :-).

Measurements can be done using OProfile, with appropriate event
selection.


>PS: too bad the cruncher will not survive 2.0. Would you consider
including POSIX tests in the new 2.1 release ? I did not see any in the
2.0.

I'm sure the Xenomai committer team will enjoy your patches ;-)


Best Regards,
--=20
Stephane


