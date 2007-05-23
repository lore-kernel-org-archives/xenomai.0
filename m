content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 May 2007 10:47:52 +0200
Message-ID: <5C40CD1E4697424ABDE3AC57CF1B22C6032202C6@domain.hid>
From: "RAKOTOSALAMA, Nirilanto" <NIRILANTO.RAKOTOSALAMA@airbus.com>
Subject: Re: [Xenomai-help] [Newbie question] threads and task CPU affinity
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

> > Hello,
> >=20
> > I have some question about CPU affinity with Xenomai 2.3.1.
> > (it is to see if  xenomai support developing for a cpu=20
> manager library is feasible)
>=20
> What will this library do? (/me just nosy)

In fact, there's simulation programs that run on many different systems (ha=
rd + soft),
and to make this applications as portable as possible, they use libraries d=
eveloped for every
systems (dec alpha, pc, specific cards, linux, unix). And, I search if xeno=
mai could be used
with less re-implementation effort, so the more posix function are develope=
d by xenomai,=20
the better it is, and easier it is (for me :p).
So first step is developing this libraries xenomai support (e.g. timer, cpu=
).
This cpu library should provides "simple" functions like : getting the numb=
er of cpu,
setting/getting the cpu affinity for a process passing its pid, protect/un-=
protect cpu from running
unwanted process.

> > When using rt_task_create, CPU mask can be specified.=20
> However, when sched_setaffinity is called=20
> > to modify main program affinity, and after, rt_task_create=20
> is called without specifying CPU mask,
> > did the child task inherits from the main program affinity ?
>=20
> If you don't provide a target CPU (either on creation or via
> /proc/xenomai/affinity), better consider the affinity as unspecified
> (any possible CPU). The target CPU derives from Linux=20
> decision where to
> put the thread non-RT boot code on, Xenomai just nails that decision
> down until someone explicitly migrates.
>=20
> >=20
> > Same question for Posix skin threads ?
> >=20
> > Can native task affinity be set other than when creating ?=20
> using sdhed_setaffinity ?
>=20
> /proc/xenomai/affinity (has global scope) or=20
> sched_setaffinity. Xenomai
> shadow threads follow the migration that may took place while in
> secondary mode, and sched_setaffinity comes with such a mode switch.

Thanks, If I have well understood, tasks or threads affinity can be set usi=
ng /proc/xenomai/affinity
but, I have read that /proc/xenomai/affinity does not exist in xenomai 2.3.=
1 and xenomai must be patched
(I don't know how because I don't have nor SVN neither internet connection =
on my xenomai boxes).
So I can use sched_setaffinity, but it make switch to secondary mode.=20
Does'nt matter if only threads must be RT and sched_setaffinity is called d=
uring a non-rt init phase, does it ?
That means that affinity does'nt depend on running on xenomai or secondary =
mode ?

BTW, is protecting a CPU with xenomai possible ?=20
Does xenomai use /dev/cpuset or an other device ?

> > Can posix skin thread affinity be set using sched_affinity ?
> >=20
> >=20
> > Thanks in advance.
> >=20
> > Niry.
> >=20
>=20
> Jan
>=20
Niry

This e-mail is intended only for the above addressee. It may contain privil=
eged information.
If you are not the addressee you must not copy, distribute, disclose or use=
 any of the information in it.=20
If you have received it in error please delete it and immediately notify th=
e sender.
Security Notice: all e-mail, sent to or from this address, may be accessed =
by someone other than the recipient, for system management and security rea=
sons. This access is controlled under Regulation of security reasons.
This access is controlled under Regulation of Investigatory Powers Act 2000=
, Lawful Business Practises.



