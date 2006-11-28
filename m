Message-ID: <456C9BBC.9050003@domain.hid>
Date: Tue, 28 Nov 2006 21:27:40 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: =?ISO-8859-1?Q?R=E9p=2E_=3A_Re=3A_=5BXenomai-help=5D_?=
	=?ISO-8859-1?Q?Switch_mode_with_x86?=
References: <s56c97a4.096@domain.hid>
In-Reply-To: <s56c97a4.096@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC4A9C7B9F053868F7CC91548"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nicolas BLANCHARD <n.blanchard@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC4A9C7B9F053868F7CC91548
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Nicolas BLANCHARD wrote:
>>>>> Jan Kiszka <jan.kiszka@domain.hid> 28/11/06 19:02 >>>
>> Nicolas BLANCHARD wrote:
>>> Hi !=20
>>>
>>> I'm newbie in xenomai world,
>>> I've write an application which make a lot of switch mode
>>> (Primary->secondary ...)
>>> and sometime tasks are block in secondary mode (/proc/xenomai/sched
> ->
>>> stat X).
>>> (no watchod message in dmesg, it's block in secondary mode).
>>>
>>> I use xenomai 2.2.5, adeos 1.5.02 (same probleme with 2.2.3 et adeos
>>> 1.4)
>>> It' run on x86 (486 vortex 166Mhz).
>>> So, i've write an litle example that failed.  It failed on my x86 (in=

>>> less than 2 minutes),
>>> but this example run corectly with a pentium 4 or an Amd processor :
>> How does it fail precisely? Which tasks are stuck? Attach
>> /proc/xenomai/sched output e.g. Already tried to attach gdb to that
>> process after the lock-up?
>=20
> I've no "crash", Tasks are blocked :
>=20
> /proc/xenomai/stat -> state of TASK_1 (Hight priority) : X
>                    -> state of TASK_2 (Low priority) : R or sometime X
> /proc/xenomai/sched -> period of TASK_1 always 0, CPU 0%
>                     -> period of TASK_2 always 0, CPU 0%
>=20
> In my original program, all others tasks which don't switch to secondar=
y
> mode
> are still alive and runs correctly ...
>=20
> I've tested gdb, nothing special, it's like if it was normal,
> But block tasks seems to be in a infinite sleep under secondary mode.

I was targeting with gdb on the question "blocked on what?"

>=20
>>
>> One difference of vortex vs. P4 might be (besides speed) that for the
>> former Xenomai uses TSC emulation, for the latter the CPU already come=
s
>> with this support. You can force the high-end systems into that mode b=
y
>> compiling the kernel with CONFIG_M586. Or did you use the same kernel
>> images on all systems?
>>
>=20
> No, kernel are not similar(both xenomai 2.2.5 + adeos 1.5-02 + linux
> 2.6.17.13),
>    ->Pentium 4 under windowsXP with Vmware worstation vm ubuntu,
> different kernel config
>      for run with Vmware, it's run fine.
>      In xenomai options there is nothing different.
>=20
> I will try CONFIG_M586 (actually 486)

Given the information below, I suspect now it is a race that is more
likely on slow boxes. Anyway, it's worth a test.

>=20
>> Your .config would be interesting. You can already check if
>> CONFIG_INPUT_PCSPKR is set. Must be off for TSC emulation (Xenomai 2.2=

>> doesn't check for this conflict, 2.3 will do so).
>=20
> Ok
> (With Xenomai configure script i've passed options : disable-x86-tsc an=
d
> disable-x86-sep)
>=20
>>> #include <sys/mman.h>
>>> #include <stdio.h>
>>> #include <signal.h>
>>> #include <native/task.h>
>>> #include <string.h>
>>>
>>> static int iStop =3D 0;
>>> RT_TASK Task_1, Task_2;
>>>
> //---------------------------------------------------------------------=
-THREAD
>>> 1
>>> void thread_1(void *arg)
>>> {
>>> 	while(1)
>>> 	{
>>> 		unsigned long overruns;
>>> 		int iErr;
>>>
>>> 		iErr =3D rt_task_wait_period(&overruns);
>>> 		if (iErr || overruns)
>>> 			printf("Echec wait_period task_1 err %d,
>>> overruns: %lu\n",iErr,overruns);
>>
>> Would have been better to attach the program instead of inlining it. :=
)
>>
>>> 		//iErr =3D rt_task_set_mode(T_PRIMARY, 0, NULL);
>>> 		if(iErr)
>>> 			printf("Echec set_mod Secondary task_1\n");
>>> printf("r\n");
>>> 		if(iStop =3D=3D 1)
>>> 		{
>>> 			iErr =3D rt_task_delete(&Task_1);
>>> 			if (iErr )=20
>>> 				printf("Echec delete task_1 err %d\n",
>>> iErr);
>>> 			break;
>>> 		}
>>> 	}
>> There is no mode switch in this thread and the second one. Is this not=

>> required to cause the lock-up???
>>
>> ...
>=20
> There is a switch with printf, if you comment this line and uncomment
> rt_task_set_mode line the probleme is the same.

Ah, uum, just found my glasses.

So there must be two tasks in secondary mode, and they must run at
different prio levels? Then I have two more things to try:

 - CONFIG_XENO_OPT_RPIDISABLE (Nucleus feature to disable prio boosting
   in secondary mode)

 - Xenomai 2.3-rc2 (to check if some recent change improves the
   situation)

Jan


--------------enigC4A9C7B9F053868F7CC91548
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFbJu8niDOoMHTA+kRAunuAJ9zwIFXyz3cJyDF8mVGE4saARqI6gCfTeXX
a8uHVjipKyroSE23Vd/7MsY=
=bjEZ
-----END PGP SIGNATURE-----

--------------enigC4A9C7B9F053868F7CC91548--

