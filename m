Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Jan 2009 13:27:49 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A017769AB@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <4976FEA7.5010707@domain.hid>
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

> >=20
> > From this scenario deduce the following questions :
> >=20
> > 1.) Linking a linux-process with a Xenomai-library "transforms" the
> > linux process to a Xenomai-process/task. Is this true ?
>=20
> Yes, and you need this to be able to call Xenomai services.

O.k. I thought so.

>=20
> For your issue, we could probably use the existing process priority
> instead of forcing SCHED_OTHER, 0. But for this to work, we have to be
> sure that the "sysup" process does not call=20
> sched_setscheduler too late
> after the creation of the process, IOW, there is a race condition.

I don=B4t understand this. Isn=B4t this a contradiction to your answer =
in 2.) ?
I thought sched_setscheduler does not work for Xenomai tasks and in our =
testcase we could see that scheduling policy isn=B4t set as expected (to =
SCHED_FIFO).=20

>=20
> But I still do not understand why you can not handle this in=20
> the xenomai
> library. For instance by passing the priority to an initialization
> function. You would avoid the race.
>=20

The process "linuxwithxenolib" does not know anything about the =
priority, as "sysup" manages the scheduling parameters for him (reads =
configuration file,...; this has mainly historic reasons (ported from =
other OS)), therfore "linuxwithxenolib" can not pass the priority to my =
library. This is not realy very beautiful and I think we have to think =
about it.


> >=20
> > 2.) Is there a way to influence the priority and scheduling=20
> policy of
> > a Xenomai-task from outside the task (from an other task (like
> > "sysup"); like sched_setscheduler can do for linux processes) ?
>=20
> No.
O.K. I probably have to accept this. So we have to think about an other =
solution (probably set the priority within "linuxwithxenolib").=20

>=20
> >=20
> > 3.) As soon as a Xenomai-systemcall (e.g. clock_gettime, sem_post,
> > sem_wait) is executed in this process the process is scheduled in
> > primary mode ?
>=20
> For some services, yes, for others no. You can find the information in
> the online documentation.
>=20
> >=20
> > 4.) Is there a way, to force back a process to secondary mode (after
> > the Xenomai-systemcall has been executed) ?
>=20
> Yes, but no, you do not want to do that. Xenomai=20
> automatically switches
> the process when needed.
>=20

But yes, I want, I want, I want  ;-))
Think about the following scenario:
1)"linuxwithxenolib" calls my xenomai-library.=20
2)Due to a xenomai systemcall in my library "linuxwithxenolib" switches =
to primary mode
3)"linuxwithxenolib" leaves my library function
4)"linuxwithxenolib" is still in primary mode and acts as a realtime =
task till it calls a linux-systemcall.
This isn=B4t the way "linuxwithxenolib" should act. It should be =
scheduled by linux as often and as long as possible.
5)So, if I could force secondary mode at the end of my library function =
everything would be fine.

So how can I force secondary mode ?

Thank you very much for your help !
Roderik

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

