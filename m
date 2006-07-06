Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: AW: [Xenomai-help] delete queues "offline"; /proc/stat
Date: Thu, 6 Jul 2006 12:09:38 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A3F8CE2@domain.hid>
From: <Roderik_Wildenburg@domain.hid>
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

> > when a xenomai-task crashs which created some queues=20
> > (rt_queue_create)=20
> > and I try to restart the task the creation of the queues=20
> > will fail as=20
> > the queue still exists (error EEXIST =3D=3D 17). Is there a=20
> > possibility to=20
> > see which queues exist (I did not find a hint in the /proc/xenomai
> > directory) and to get rid of these queues (or geneally=20
> > spoken : to get=20
> > rid of allocated resources) e.g. with a commandline tool ?

>=20
> Native or posix skin? Gilles added per-process resource=20
> cleanup to the posix skin in 2.2-rc3.
>

following Murphys law, I, of course, use native skin where this =
mechanism isn=B4t=20
implemented yet ;-)
What does "per-process resource cleanup" mean ?=20
When the process/thread is killed the queues and other resources of this =

process/thread are deleted automaticaly ?

> Otherwise: the names should be found in=20
> /proc/xenomai/registry. Writing a tiny tool to pick up a name=20
> and resources type, attach to it, and then release it should=20
> be straightforward. But I think we will have per-process=20
> cleanup also for other skins in the future.
>=20

The trick with this is the attachement with the resource.
I can=B4t see a way to attach to a queue whos handle (RT_QUEUE)
is lost (it can=B4t be reconstructed out of the data from the=20
registry).  Are there some other "tricks" ?


> Stalled RTDM descriptors can be released via "echo DESCR_NO >=20
> /proc/xenomai/rtdm/open_fildes" (I still have to make use of Gilles'
> per-process cleanup also for the posix rtdm part...).
>=20
> > An other question, I would appreciate some help for, is :
> > How could I determine the CPU-load when a xenomai thread is=20
> running?=20
> > Is the data provided by /proc/stat valid with xenomai ?
>=20
> Nope, they aren't. We actually need to do something in this=20
> direction, maybe a simple per-xeno-thread execution time=20
> accounting if XENO_OPT_STATS is set.
>=20

A summary of Xenomai used time in /proc/stat would be fine too:
CPU : "User time" "nice time" "system time" "xenomai time" "idle time".
But this probably is not compatible.



> Jan
>=20
>=20

