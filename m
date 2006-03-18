Message-ID: <441C5371.1080208@domain.hid>
Date: Sat, 18 Mar 2006 19:37:37 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: get the simulator running...
References: <441C2574.4030901@domain.hid> <441C4279.10800@domain.hid>
	<441C4460.9030103@domain.hid>
In-Reply-To: <441C4460.9030103@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig599B82B0AB612C1F77C8D9F3"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig599B82B0AB612C1F77C8D9F3
Content-Type: multipart/mixed; boundary="------------080809060205070606040902"

This is a multi-part message in MIME format.
--------------080809060205070606040902
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Philippe Gerum wrote:
>> Jan Kiszka wrote:
>>  Fortunately, I had that demo I once produced
>>
>>> (last year), but that one was easier to build. I first had to drag in=

>>> the libs and includes of both the simulator and a regular xenomai
>>> installation (I think to remember this once worked without this
>>> add-ons). Then I need this additional trick in the simulators include=

>>> dir:
>>>
>>> mkdir asm
>>> ln -s <xeno-inst-dir>/include/asm-sim asm/xenomai
>>>
>>> This maps #include <asm/xenomai/system.h> to the correct "arch".
>>> Shouldn't this be created automatically during the simulator
>>> installation? Or is something else broken on my box?
>>>
>>
>> You clearly should not need this trick to compile apps against the
>> simulation environment; the instrumenter (gcic) sets the proper flags.=

>> I'm going to rebuild one and let you know.
>=20
> Confirmed. You don't need this hand-made link.
>=20

Err, "confirmed" means that it works for you without the link and the
extra paths for gcic? The compilation of the simulator runs fine with
latest SVN here, but gcic still does not know any include paths.
Attached is the native skin demo I tried.

Jan

--------------080809060205070606040902
Content-Type: text/plain;
 name="nat-demo.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="nat-demo.c"

/*
 * nat-demo.c
 *
 * Simple demonstration for a native-skin application inside the MVM simu=
lator
 * (C) 2005-2006 by Jan Kiszka <jan.kiszka@domain.hid>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

#include <native/task.h>
#include <native/sem.h>

RT_TASK demo_task1;
RT_TASK demo_task2;
RT_SEM sem;

void demo1(void *arg)
{
    RTIME now, previous;

    rt_task_set_periodic(NULL, TM_NOW, 1000000000);
    previous =3D rt_timer_read();

    while (1) {
        rt_task_wait_period(NULL);
        now =3D rt_timer_read();

        printk("%s: delay since last invocation:: %ld.%06ld ms\n",
               __FUNCTION__,
               (long)(now - previous) / 1000000,
               (long)(now - previous) % 1000000);
        previous =3D now;

        rt_sem_v(&sem);
    }
}


void demo2(void *arg)
{
    RTIME now, previous;

    previous =3D rt_timer_read();

    while (1) {
        rt_sem_p(&sem, TM_INFINITE);
        now =3D rt_timer_read();

        printk("%s: delay since last invocation:: %ld.%06ld ms\n",
               __FUNCTION__,
               (long)(now - previous) / 1000000,
               (long)(now - previous) % 1000000);
        previous =3D now;
    }
}


/* Note: simulator requires exactly this function name! */
int __xeno_user_init(void)
{
    rt_task_create(&demo_task1, "kdemo1", 0, 99, 0);
    rt_task_create(&demo_task2, "kdemo2", 0, 98, 0);
    rt_sem_create(&sem, NULL, 0, S_PRIO);

    rt_task_start(&demo_task1, &demo1, NULL);
    rt_task_start(&demo_task2, &demo2, NULL);

    return 0;
}


/* Note: simulator requires exactly this function name! */
void __xeno_user_exit(void)
{
    rt_task_delete(&demo_task1);
    rt_task_delete(&demo_task2);
    rt_sem_delete(&sem);
}

module_init(__xeno_user_init);
module_exit(__xeno_user_exit);

MODULE_LICENSE("GPL");

--------------080809060205070606040902--

--------------enig599B82B0AB612C1F77C8D9F3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEHFNxniDOoMHTA+kRApy0AJ4iSZ7Oq0/luL38h5asoi/V2GFghACfZHK6
xoXaUQniTK9Hll9BPhSNvgA=
=qfbV
-----END PGP SIGNATURE-----

--------------enig599B82B0AB612C1F77C8D9F3--

