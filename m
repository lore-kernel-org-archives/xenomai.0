content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 May 2007 12:12:17 +0200
Message-ID: <5C40CD1E4697424ABDE3AC57CF1B22C6032202C8@domain.hid>
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

Thanks Jan,

It's more and more clear.
Just a question, I've a little doubt. Native tasks do not inherit
affinity from their parent process. I've read that cpu affinity=20
setting at pthread creation is only availablle in kernel space.
Do Posix skin threads inherit affinity from their parent, in user space?

If not, when I "sched_setaffinity" a parent process, I have to=20
recursively "sched_setaffinity" all its threads and force them to
switch to primary mode. Is it right ?

> >>> Hello,
> >>>
> >>> I have some question about CPU affinity with Xenomai 2.3.1.
> >>> (it is to see if  xenomai support developing for a cpu=20
> >> manager library is feasible)
> >>
> >> What will this library do? (/me just nosy)
> >=20
> > In fact, there's simulation programs that run on many=20
> different systems (hard + soft),
> > and to make this applications as portable as possible, they=20
> use libraries developed for every
> > systems (dec alpha, pc, specific cards, linux, unix). And,=20
> I search if xenomai could be used
> > with less re-implementation effort, so the more posix=20
> function are developed by xenomai,=20
> > the better it is, and easier it is (for me :p).
> > So first step is developing this libraries xenomai support=20
> (e.g. timer, cpu).
> > This cpu library should provides "simple" functions like :=20
> getting the number of cpu,
> > setting/getting the cpu affinity for a process passing its=20
> pid, protect/un-protect cpu from running
> > unwanted process.
>=20
> OK, I see.
>=20
> >=20
> >>> When using rt_task_create, CPU mask can be specified.=20
> >> However, when sched_setaffinity is called=20
> >>> to modify main program affinity, and after, rt_task_create=20
> >> is called without specifying CPU mask,
> >>> did the child task inherits from the main program affinity ?
> >> If you don't provide a target CPU (either on creation or via
> >> /proc/xenomai/affinity), better consider the affinity as=20
> unspecified
> >> (any possible CPU). The target CPU derives from Linux=20
> >> decision where to
> >> put the thread non-RT boot code on, Xenomai just nails=20
> that decision
> >> down until someone explicitly migrates.
> >>
> >>> Same question for Posix skin threads ?
> >>>
> >>> Can native task affinity be set other than when creating ?=20
> >> using sdhed_setaffinity ?
> >>
> >> /proc/xenomai/affinity (has global scope) or=20
> >> sched_setaffinity. Xenomai
> >> shadow threads follow the migration that may took place while in
> >> secondary mode, and sched_setaffinity comes with such a=20
> mode switch.
> >=20
> > Thanks, If I have well understood, tasks or threads=20
> affinity can be set using /proc/xenomai/affinity
> > but, I have read that /proc/xenomai/affinity does not exist=20
> in xenomai 2.3.1 and xenomai must be patched
>=20
> Yes, it's an upcoming feature of 2.4.
>=20
> > (I don't know how because I don't have nor SVN neither=20
> internet connection on my xenomai boxes).
>=20
> There is a daily snapshot on gna.org:=20
> https://gna.org/svn/?group=3Dxenomai
>=20
> > So I can use sched_setaffinity, but it make switch to=20
> secondary mode.=20
> > Does'nt matter if only threads must be RT and=20
> sched_setaffinity is called during a non-rt init phase, does it ?
>=20
> Yep.
>=20
> > That means that affinity does'nt depend on running on=20
> xenomai or secondary mode ?
>=20
> Sorry, doesn't parse for me right now.
>=20
> >=20
> > BTW, is protecting a CPU with xenomai possible ?=20
> > Does xenomai use /dev/cpuset or an other device ?
>=20
> Xenomai doesn't directly interact with cpuset -- but... if you force
> some RT process into a certain CPU and you don't override=20
> this decision
> on RT thread creation, Xenomai will follow as explained.
>=20
> Jan
>=20
>=20
> This mail has originated outside your organization, either=20
> from an external partner or the Global Internet.
> Keep this in mind if you answer this message.
>=20
>=20
>=20

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



