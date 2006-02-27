Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: AW: [Xenomai-core] vxworks-skin taskSpawn
Date: Mon, 27 Feb 2006 11:44:50 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A1C3C46@domain.hid>
From: <Roderik_Wildenburg@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Thank you for caring about my problem !
Perhaps I should have mentioned in my earlier postings that I am using a =
PowerPC platform. I hope this does not nullify your prior analyses.

These are the outputs (with some of my debug outputs), when I start =
satch.

# ./satch
Xenomai: UVM skin or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_uvm?)=20

# insmod xeno_uvm.o
Using xeno_uvm.o
Xenomai: starting UVM services.
Dec 12 06:21:02 trgt user.info kernel: Xenomai: starting UVM services.

# ./satch
Xenomai/uvm: real-time nucleus v2.1-rc2 (Champagne) loaded.
starting VxWorks services.
spawning consumer 805462824
taskSpawn before TaskInit
taskInit before xnpod_init_thread
taskSpawn before TaskActivate
taskActivate before xnpod_start_thread
xnpod_start_thread before xnarch_init_thread ConsumerTask
xnpod_start_thread after xnarch_init_thread
xnpod_start_thread after xnpod_resume_thread
xnpod_start_thread before xnpod_schedule

satch stalled !!
=3D> ouput form an other terminal

~ # cat /proc/xenomai/sched=20
CPU  PID    PRI  TIMEOUT  STAT       NAME
  0  0      0    0        R          ROOT
  0  42     1    0        S          uvm-root
  0  44     3    0        W          uvm-timer
~ # cat /proc/xenomai/timer=20
status=3Doneshot:setup=3D40:tickval=3D1:jiffies=3D940509634545



So far the debug outputs. I never worked with gdb before, but I will try =
to establish a remote debug session with it, to get some more =
informations.
But in the meantime could you perhaps be so kind to answer a questions =
occured with your answer (thank you) :
You have written :

> More precisely, the VxWorks API is compiled as a user-space=20
> library (instead of a kernel module) when using the UVM mode,=20
> and the VxWorks services are obtained from this library,=20
> within the Linux process that embodies it. This is why there=20
> is no point in loading the in-kernel VxWorks module in this case.

O.k., I understand that the vxWorks API is done by some kind of wrapper =
functionalities provided by the user-space vxworks library. What I =
don=B4t understand is, why do I need the uvm kernel module for vxWorks =
but not for the  native xenomai API ? And, what is the vxWorks kernel =
module (xeno_vxworks.o) for, when do I need it ??


Thank you for you patience when answering all these stupid (?) questions
Roderik




> -----Urspr=FCngliche Nachricht-----
> Von: Philippe Gerum [mailto:rpm@xenomai.org
> Gesendet: Samstag, 25. Februar 2006 13:28
> An: Wildenburg, Roderik RAEK3 MRA
> Cc: xenomai@xenomai.org
> Betreff: Re: [Xenomai-core] vxworks-skin taskSpawn
>=20
> Roderik_Wildenburg@domain.hid wrote:
> > I am using xenomai-2.1-rc2 and try to create a task via the=20
> vxWorks skin function taskSpawn.
> As I have read that uvm and vxWorks exclude each other, I=20
> just inserted the xeno_uvm module (not the xeno_vxworks.o module ).
> No problems so far.
>=20
> More precisely, the VxWorks API is compiled as a user-space=20
> library (instead of a kernel module) when using the UVM mode,=20
> and the VxWorks services are obtained from this library,=20
> within the Linux process that embodies it. This is why there=20
> is no point in loading the in-kernel VxWorks module in this case.
>=20
> When I start my application nothing happens (no errormessages=20
> ...), the application seems to hang. Debugging printf=B4s show=20
> that the function taskSpawn never returns and the task to be=20
> spawned (there is no evidence that she is
> running) never produces any debug output.
> > This happens with both vxworks skin examples koan.c and satch.c.
> > Xenomai native skin works, satch and latency are running.
> > Does anybody have any idea/recomendation about this behavior ?
>=20
> After your application has stalled, try dumping the scheduler=20
> state to get more information on the existing threads:
> $ cat /proc/xenomai/sched
>=20
> The same goes for the timer state:
> $ cat /proc/xenomai/timer
>=20
> Additionally, you may want to load your application with GDB,=20
> and see which code gets executed using breakpoints.
>=20
> --=20
>=20
> Philippe.
>=20

