content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 31 May 2007 17:48:51 +0200
Message-ID: <5C40CD1E4697424ABDE3AC57CF1B22C6032202CD@FR0-MAILMB20.res.airbus.corp>
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

> > Hi,
> >=20
> > I'm still blocked on a CPU affinity problem.
> > In order to adapt a set affinity function which is based on
> > posix linux lib :
> > - CPU_AssignPID(uint32 PID, uint32 CPU_id)
> > - the cpu affinity of the caller and all its child threads=20
> must be set to CPU_id.
> >=20
> > Problems are:
> > Child PIDs must be listed, the only means I found is=20
> listing pids using `ls /proc/"Parent pid"/ > temp_file`
> > And each listed pid is sched_setaffinity'ed.
> > I don't know if setting affinity of RT threads from an=20
> other thread (parent) using pid works with xenomai.
> >=20
> > So, my question is :
> > With xenomai, is recursively cpu affinity setting from a=20
> parent thread, a good way of doing ?
>=20
> Neither good nor bad. The (i.e. your =3D=3D Airbus code) library you are
> trying to adapt _wants_ to set the CPU affinity for an entire process
> hierarchy, probably to remain compatible with the behaviour inherited
> from legacy RT environments. Therefore, unless you want to change this
> behaviour at interface specification level (unlikely,=20
> right?), you need
> your code to recurse down the process tree too.
>
> > I read switchtest program, and I conclude that in a xenomai=20
> and RT perspective, it seems "nicer"
> > to set affinity each threads separately during their init=20
> phase before the RT infinite loop.
>=20
> There are two questions here:
>=20
> Q. whether setting affinity during the init phase is best
> A. yes, since you want to use the regular=20
> sched_setaffinity(2) call for
> that, this will switch the caller to secondary mode, and you=20
> don't want
> such mode switch to happen during the actual RT processing.
>=20
> Q. whether you should opt for flat or process tree-based=20
> affinity setup.
> A. it depends on your requirements. IIUC, your specs imply recursive
> setup (because you want to mimic some existing behaviour), so=20
> the point
> seems moot here. However, it is always better not to rely on implicit
> affinities; you may end up with a sub-optimal runtime configuration,
> just because the existing process hierarchy may not always be=20
> consistent
> with the optimal CPU placement. This said, again, you might have no
> choice here if you need to port some existing library without
> significant changes, especially wrt the higher level code using such
> library.
>=20
> > Otherwise, setting affinity after child threads creation=20
> > from its parent, may switch them into=20
> > secondary mode during their RT loop, and at an unknown moment.
>=20
> Actually, only the caller (i.e. the one who calls set_schedaffinity)
> would switch to reenter the Linux kernel properly, in order to submit
> the sched_setaffinity() request. When a thread running in primary mode
> is set a different CPU affinity by another thread using the regular
> Linux kernel service (here, the former thread must be aslept=20
> waiting for
> some Xenomai resource), then the new affinity would be enforced only
> when the target thread leaves primary mode. For an immediate migration
> to take place while running in primary mode, you need to ask=20
> Xenomai to
> manage it, but there is no direct interface from the POSIX skin to the
> nucleus service performing this magic.
>=20
> To sum up, with the Xenomai POSIX interface, you need to call
> sched_setaffinity(2) to set the CPU affinity for both Xenomai and
> regular threads, and if you want to recurse down a process hierarchy,
> you need to make sure that all the targeted children are waiting in a
> plain Linux context, for some master thread to ask for such global
> migration. For instance, you could just sync them all on some init
> barrier which would mark the end of the initialization phase, and the
> latter would include setting the CPU affinity.
>=20
> This said, CPU affinity is a task property inherited upon fork, so if
> you manage to have the parent of the process tree setting up the right
> affinity before creating any child thread, you are basically done.
>=20
> > Argumentation is important for my internship because I have=20
> to port on xenomai a very big RT=20
> > posix based application. And I should justify any=20
> modifications and prevent potential problems.
> >=20
> > Sorry, I don't know if it is clear.
> >=20
> > Thanks in advance, Niry.
>
> Philippe.
>=20

Thanks for your answer. You exactly sum up my situation (better than myself=
).
So, if I well undestood, the current implementation of the set affinity=20
function for standard linux lib should work for xenomai threads.
So, main changes would take place into libcpu user programs.
I must take care that, in the program that uses this cpu lib, target=20
children threads must "wait in linux context".
Should they "wait" sleeping (e.g. on semaphore) or sleeping avoid switching=
=20
to secondary mode ?
Or should they wait on a simple while(!init_finished)?
Does sched_setaffinity from a master thread to a child thread block
master thread until child affinity is set ? In this instance,
sync is easy. If not ???

And if 2nd mode switching cannot be forced, this wait period=20
could take a long time, could'nt it?

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



