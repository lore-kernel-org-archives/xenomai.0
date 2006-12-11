Message-ID: <457D9F19.3050807@domain.hid>
Date: Mon, 11 Dec 2006 19:10:33 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Re: [Adeos-main] [PATCH] ppc mvme5500
References: <1165537720.4578b1b879da9@domain.hid>
	<45795320.5060806@domain.hid>
	<1165595720.45799448b0adc@domain.hid>
	<4579CD41.6060102@domain.hid>
	<1165665886.457aa65e2c26e@domain.hid>
	<457AAEB9.20403@domain.hid>
	<1165834501.457d390514d36@domain.hid>
	<457D57B4.3000802@domain.hid>
	<1165843368.457d5ba8692bd@domain.hid>
	<457D609F.8030301@domain.hid> <457D6BF1.1040507@domain.hid>
	<1165859722.457d9b8a9b097@domain.hid>
In-Reply-To: <1165859722.457d9b8a9b097@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFA68BD5289F3B9CC14AACB2A"
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
To: barbalace@domain.hid
Cc: xenomai-help <xenomai@xenomai.org>, adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFA68BD5289F3B9CC14AACB2A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

barbalace@domain.hid wrote:
> Quoting Jan Kiszka <jan.kiszka@domain.hid>:
>> Antonio, please use a recent Xenomai version (e.g. 2.2.5) to avoid tha=
t
>> we may hunt old issues.
>  Ok, could be the right solution.

Your issue is independent of the version, still 2.2.5 contains a lot of
fixes.

>=20
>> Next post a simple demo code to xenomai-help,
>> showing the misbehaviour. We could then check if other archs are
>> involved, if it's reproducible on further PPC boards, or if some mista=
ke
>> might have slipped into the code.
>> From your description I wonder if you lock the mutex in line 2 from th=
e
>> correct context (a Xenomai thread). If you call that lock from main,
>> don't forget to invoke rt_task_shadow first.
>=20
> A simplified version of the code (in the original code there is an hw D=
AQ and I
> understand that the same code run 2-times, here one could use a buffer =
to write
> for example a u(->for unlocking) and a l(->for locking) ):
>=20
> /* -- START CODE HERE ---------- demo.c -------------------------------=
-------*/
> #include <linux/config.h>
> #include <linux/version.h>
> #include <linux/module.h>
> #include <linux/moduleparam.h>
>=20
> #include <native/task.h>
> #include <native/intr.h>
> #include <native/mutex.h>
> #include <native/sem.h>
>=20
>=20
> #define TASK_PRIO 99
> #define TASK_MODE (T_FPU | T_CPU(0))
> #define TASK_STKSZ 4096
>=20
> RT_INTR intr_desc;
> RT_TASK task_desc;
> RT_MUTEX mutex_desc;
>=20
> int demo_finalize;
>=20
> #define INTR_IRQ 76
>=20
> static irqreturn_t demo_irqhandler(void)
> {
>         rt_mutex_unlock(&mutex_desc);                        // IPC han=
dling

You cannot unlock a mutex from a non-task context like the IRQ handler
is. Actually, the return value of that call should be EPERM, indicating
the misuse.

>=20
>         return RT_INTR_HANDLED;
> }
>=20
>=20
>=20
> void rt_handler(void *data){
>=20
>         printk(KERN_ERR"entered in RT task\n");                // ok I =
know is
> not right use printk

There is actually no problem (except growing log files), printk is safe
from RT context under Xenomai.

>         rt_mutex_lock(&mutex_desc, TM_INFINITE);
>=20
>         for(;;){
>                 rt_mutex_lock(&mutex_desc, TM_INFINITE);
>=20
>                 if(demo_finalize =3D=3D 1)
>                         break;
>                 /* doing something */
>         }
>=20
>         return;
> }
>=20
> static int demo_init(void)
> {
>         int result;
>         // initialize MUTEX
>         int err;
>         err =3D rt_mutex_create(&mutex_desc, "demo_mutex");
>         printk(KERN_ERR"mutex created and locked\n");
>=20
>         demo_finalize =3D 0;
>=20
>         // create the real-time task waiting for data
>         err =3D rt_task_create(&task_desc, "demo_acq", TASK_STKSZ, TASK=
_PRIO,
> TASK_MODE);
>         if (!err) {
>                 rt_task_start(&task_desc, &rt_handler, NULL);
>                 printk(KERN_ERR"RT task started!\n");
>         } else
>                 printk(KERN_ERR"can't start RT thread!!!\n");
>=20
>         result =3D rt_intr_create(&intr_desc, "demo_intr", INTR_IRQ,
> demo_irqhandler, 0,
> 0);
>=20
>         return (0);
> }
>=20
> static void demo_exit(void)
> {
>         rt_intr_delete(&intr_desc);
>=20
>         demo_finalize =3D 1;
>         rt_mutex_unlock(&mutex_desc);
>=20
>=20
>         rt_task_delete(&task_desc);
>         printk(KERN_ERR"demo: RT task destroyed\n");
>=20
>         return;
> }
>=20
> module_init(demo_init);
> module_exit(demo_exit);
>=20
> /* --- END CODE HERE --------------------------------------------------=
-------*/
>=20
> With this code and Xenomai 2.2.0 you lose the machine control... I reso=
lve this
> using semaphores.

Using a semaphore to wake the blocked RT task up is actually the Right
Thing. Why not a mutex? A locked mutex always has an owner, which is the
task that successfully acquired it. That owner is ought to release the
mutex again - NO ONE ELSE. And having an owner allows do thing like
inheriting the priority of a waiter to the current owner - or to analyse
who forgot to release it...

Jan


--------------enigFA68BD5289F3B9CC14AACB2A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFfZ8ZniDOoMHTA+kRAi+tAJ9RX/GepKTsRErBcCPypR7kAc/73wCeJzbp
IbQINuzcQ3hZ1J/1OrAxyhE=
=F8JU
-----END PGP SIGNATURE-----

--------------enigFA68BD5289F3B9CC14AACB2A--

