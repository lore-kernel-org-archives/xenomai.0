Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: AW: [Xenomai-core] vxworks-skin taskSpawn (additional info)
Date: Fri, 24 Feb 2006 14:33:16 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A1C3BA8@domain.hid>
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
To: xenomai@xenomai.org

Some more debugging (printf=B4s ;-)) of the example satch.c  revealed =
that taskSpawn hangs in a function of the nucleus module nucleus/pod.c =
called xnpod_schedule.

This is the caller stack :

vxworks/tasklib.c/taskSpawn
->vxworks/tasklib.c/taskInit
->vxworks/tasklib.c/TaskActivate
-->nucleus/pod.c/xnpod_start_thread
--->nucleus/pod.c/xnpod_schedule

and xnpod_schedule never returns.
Does anybody can give me some more hints for debugging or knows the =
solution for this problem ?

Thank you for your help in advance.
Roderik


>=20
> I am using xenomai-2.1-rc2 and try to create a task via the=20
> vxWorks skin function taskSpawn. As I have read that uvm and=20
> vxWorks exclude each other, I just inserted the xeno_uvm=20
> module (not the xeno_vxworks.o module ). No problems so far.=20
> When I start my application nothing happens (no errormessages=20
> ...), the application seems to hang. Debugging printf=B4s show=20
> that the function taskSpawn never returns and the task to be=20
> spawned (there is no evidence that she is running) never=20
> produces any debug output.
> This happens with both vxworks skin examples koan.c and satch.c.
> Xenomai native skin works, satch and latency are running.
> Does anybody have any idea/recomendation about this behavior ?
>=20
> Thank you in advance !
> Roderik
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>=20

