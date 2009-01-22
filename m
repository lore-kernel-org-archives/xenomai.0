Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Jan 2009 12:06:01 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A01776C87@domain.hid>
In-Reply-To: <49771D9E.4080204@domain.hid>
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

Sorry for the delayed answer, but I am fighting with an other Xenomai =
problem too (PPC switchtest FPU problem, you probably heard about it).

> > I don=B4t understand this. Isn=B4t this a contradiction to your=20
> answer in
> > 2.) ? I thought sched_setscheduler does not work for Xenomai tasks
> > and in our testcase we could see that scheduling policy isn=B4t set =
as
> > expected (to SCHED_FIFO).
>=20
> Currently the posix skin library does, in init.c:
>        parm.sched_priority =3D 0;
>         err =3D __wrap_pthread_setschedparam(pthread_self(),=20
> SCHED_OTHER,
>                                            &parm);
>=20
> We could replace this with:
> 	err =3D pthread_getschedparam(pthread_self(), &policy, &parm);
> 	if (err)
> 		...
> 	err =3D __wrap_pthread_setschedparam(pthread_self(),
> 					   policy, &parm);
>=20
> But sched_setscheduler could be called after that, so this is racy.

Please correct me if I am wrong:
In your replacement pthread_getschedparam would read scheduling =
parameters which should have been set with sched_setscheduler before(!) =
your replacement gets active. Is this possible at all ? Wouldn=B4t I =
have to call sched_setscheduler (in "sysup") before I fork? And if =
calling after the fork it realy would be racy. So this isn=B4t a very =
feasible solution, isn=B4t it? Changing the scheduling paramters of a =
running Xenoami task probably isn=B4t possible (probably there is =
nothing to recognize the change ?)?

> >=20
> > So how can I force secondary mode ?
>=20
> The point is that if you force it to secondary mode, and the=20
> next system
> call is in fact a xenomai syscall, xenomai will switch the thread to
> primary mode again. So, you have two useless mode switches which you
> could have avoided if you had not forcibly switched to secondary mode.

In our case this wouldn=B4t be very likely and even if there would be 2 =
useless mode switches, I could accept this as it would happen "only" in =
a Linux (not realtime) process (I would force back to secondary mode =
only if I knew it is a Linux, not Xenomai process).

> Note that even if a xenomai thread is running in secondary=20
> mode and has
> a priority higher than another xenomai thread running in primary mode,
> the one running in secondary mode will run. So, you should not use
> primary mode and secondary mode to decide which thread should run, you
> should use the priorities.

This is realy astonishing! I didn=B4t knew that and even now I can=B4t =
believe it.
I allways thought that secondary mode means: scheduled by Linux and =
Linux is the lowest priority task in Xenomai. So, as soon as a task is =
in secondary mode every(!) Xenomai primary mode task would be scheduled =
in front of a secondary mode task, I thought.
So, if your statement is right, I can=B4t see the difference between =
primary and secondary mode any more as a higher prioritized task =
obviously allways(!?) runs in front of a lower prioritized one =
independend whether it runs in primary or secondary mode? Is there some =
documenation I could read for better understanding ?
Is this behaviour connected to the Xenomai "priority coupling" option?

Best regards=20
Roderik

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

