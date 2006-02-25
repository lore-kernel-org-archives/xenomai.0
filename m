Message-ID: <44004D5C.6060708@domain.hid>
Date: Sat, 25 Feb 2006 13:28:12 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] vxworks-skin taskSpawn
References: <5D63919D95F87E4D9D34FF7748CE2C2A1C3B49@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A1C3B49@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

Roderik_Wildenburg@domain.hid wrote:
> I am using xenomai-2.1-rc2 and try to create a task via the vxWorks ski=
n function taskSpawn.
As I have read that uvm and vxWorks exclude each other, I just inserted t=
he=20
xeno_uvm module (not the xeno_vxworks.o module ).
No problems so far.

More precisely, the VxWorks API is compiled as a user-space library (inst=
ead of a=20
kernel module) when using the UVM mode, and the VxWorks services are obta=
ined from=20
this library, within the Linux process that embodies it. This is why ther=
e is no=20
point in loading the in-kernel VxWorks module in this case.

When I start my application nothing happens (no errormessages ...), the=20
application seems to hang. Debugging printf=B4s show that the function ta=
skSpawn=20
never returns and the task to be spawned (there is no evidence that she i=
s=20
running) never produces any debug output.
> This happens with both vxworks skin examples koan.c and satch.c.
> Xenomai native skin works, satch and latency are running.
> Does anybody have any idea/recomendation about this behavior ?

After your application has stalled, try dumping the scheduler state to ge=
t more=20
information on the existing threads:
$ cat /proc/xenomai/sched

The same goes for the timer state:
$ cat /proc/xenomai/timer

Additionally, you may want to load your application with GDB, and see whi=
ch code=20
gets executed using breakpoints.

--=20

Philippe.

