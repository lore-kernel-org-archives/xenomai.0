Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Jan 2009 15:25:53 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A01776D54@domain.hid>
In-Reply-To: <49787147.9060201@domain.hid>
From: <roderik.wildenburg@domain.hid>
Subject: Re: [Xenomai-help] How to use Xenomai libraries with "normal" (non
	Xenomai) linux processes ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

> > Please correct me if I am wrong: In your replacement
> > pthread_getschedparam would read scheduling parameters which should
> > have been set with sched_setscheduler before(!) your=20
> replacement gets
> > active. Is this possible at all ? Wouldn=B4t I have to call
> > sched_setscheduler (in "sysup") before I fork? And if calling after
> > the fork it realy would be racy. So this isn=B4t a very feasible
> > solution, isn=B4t it? Changing the scheduling paramters of a running
> > Xenoami task probably isn=B4t possible (probably there is nothing to
> > recognize the change ?)?
>=20
> You are just repeating what I said. So, I have not much more to say.
>

Yes, but with my own words, so you can tell me whether I understood you =
or not ;-).

> > Linux and Linux is the lowest priority task in Xenomai. So, as soon
> > as a task is in secondary mode every(!) Xenomai primary mode task
> > would be scheduled in front of a secondary mode task, I thought. So,
> > if your statement is right, I can=B4t see the difference between
> > primary and secondary mode any more as a higher prioritized task
> > obviously allways(!?) runs in front of a lower prioritized one
> > independend whether it runs in primary or secondary mode? Is there
> > some documenation I could read for better understanding ? Is this
> > behaviour connected to the Xenomai "priority coupling" option?
>=20
> Yes, it is what priority coupling means. But it really is the=20
> most sane
> behaviour: you choose a priority and both Linux and Xenomai schedulers
> cooperate to enfore this priority.

How are Linux tasks treated which are not linked with any Xenomay =
library, but whose scheduling is set to SCHED_FIFO and whose priority is =
set to some value higher than a Xenomai tasks (with sched_setscheduler). =
When do they run ?

> The real difference between a task running in secondary mode=20
> and a task
> running in primary mode, is that a task running in secondary=20
> mode may be
> interrupted/preempted by a Linux event. So, running in primary mode is
> not a problem in itself as you seem to think. Provided that=20
> the priority
> are well chosen, it will not prevent other task from running.
>=20
> --=20
>                                                  Gilles.
>=20
>

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

