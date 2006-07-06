From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Message-ID: <17580.62092.647925.100612@domain.hid>
Date: Thu, 6 Jul 2006 13:22:52 +0200
Subject: Re: AW: [Xenomai-help] delete queues "offline"; /proc/stat
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A3F8CE2@domain.hid>
References: <5D63919D95F87E4D9D34FF7748CE2C2A3F8CE2@domain.hid>
Content-Transfer-Encoding: Quoted-Printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

Roderik_Wildenburg@domain.hid wrote:
 > > > when a xenomai-task crashs which created some queues=20
 > > > (rt_queue_create)=20
 > > > and I try to restart the task the creation of the queues=20
 > > > will fail as=20
 > > > the queue still exists (error EEXIST =3D=3D 17). Is there a=20
 > > > possibility to=20
 > > > see which queues exist (I did not find a hint in the /proc/xenomai
 > > > directory) and to get rid of these queues (or geneally=20
 > > > spoken : to get=20
 > > > rid of allocated resources) e.g. with a commandline tool ?
 >=20
 > >=20
 > > Native or posix skin? Gilles added per-process resource=20
 > > cleanup to the posix skin in 2.2-rc3.
 > >
 >=20
 > following Murphys law, I, of course, use native skin where this mechan=
ism isn=B4t=20
 > implemented yet ;-)
 > What does "per-process resource cleanup" mean ?=20
 > When the process/thread is killed the queues and other resources of th=
is=20
 > process/thread are deleted automaticaly ?

Yes, all resources specific to a process are deleted automatically, so,
any message queue descriptor or shared memory descriptor is
closed. Named objects are not deleted though, since they may be shared
between several processes, only non-pshared anonymous objects and named
objects *descriptors* are deleted. This is the only reasonable
implementation I could find.

--=20


					    Gilles Chanteperdrix.

