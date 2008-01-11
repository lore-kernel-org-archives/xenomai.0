Message-ID: <4787B3DB.5010507@domain.hid>
Date: Fri, 11 Jan 2008 19:22:19 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <d3623eab0801110744y63764ba2sb122db96a85bde80@domain.hid>
	<d3623eab0801110806y75b51c1kc31efe7d357de522@domain.hid>
In-Reply-To: <d3623eab0801110806y75b51c1kc31efe7d357de522@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7BD5F53AEEFA500E034DE002"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] cannot make system() calls anymore
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jay@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7BD5F53AEEFA500E034DE002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Jerome Pasquero wrote:
> Hi,
>=20
> I recently upgraded from xenomai 2.3.0 under linux 2.6.17.14 to the lat=
est
> stable version of xenomai 2.4.1 under linux 2.6.23.12.
> Everything seems to be working just fine, except that I seem to  no lon=
ger
> be able to make system calls inside a real-time task. It simply freezes=

> everything and I need to restart my computer.
> I don't know if it was just a fluke that it was working with 2.3.0 and =
that
> I am not supposed to do that at all. Could it be that I forgot to inclu=
de an
> option when recompiling the kernel?

A system freeze is not a valid reaction of Xenomai on invalid user=20
activity - unless that freeze just means one of your high-prio tasks=20
decided to enter an endless loop. Have you already tried to enable the=20
Xenomai watchdog?

>=20
> Note that I have no problem making system calls from outside a real tim=
e
> task (for instance, right before a rt_task_shadow() call).
> Also, it seems that the problem only occurs when other libraries are us=
ed.
> For instance, if one compiles the code below with no other libraries th=
an
> the xenomai libs (and stdc++), it works just fine:
> gcc  `/usr/xenomai/bin/xeno-config --xeno-cflags`
> `/usr/xenomai/bin/xeno-config --xeno-ldflags` -lstdc++ -lnative main.cp=
p
>=20
> However, as soon as I add the libxml2 library, it crashes:
> gcc  -D_GNU_SOURCE -D_REENTRANT -D__XENO__  -I/usr/include/libxml2
> -I/usr/xenomai-2.4.1/include  -L/usr/local/lib -L/usr/xenomai-2.4.1/lib=

> -lxml2 -lnative -lpthread `/usr/xenomai/bin/xeno-config --xeno-cflags`
> `/usr/xenomai/bin/xeno-config --xeno-ldflags` -lstdc++ -lnative main.cp=

>=20
> This is true with other libraries as well (e.g. gsl lib) but not of all=

> libraries (for instance, it seems to work with the math library i.e. -l=
m)
>=20
> Am I doing something wrong?
> In case you were wondering, I want to be able to make system calls from=

> inside real time threads cause I want to load/unload realtime modules
> directly from my application. In the code snippet below, I am simply tr=
ying
> to do a  'ls'  command to keep it as simple as possible.

Thanks for the demo. This one already bricks your box? But only when=20
linked against libxml?

>=20
> Thanks for your help in advance.
>=20
>=20
> #include <iostream>
> #include <sys/mman.h>
> #include <signal.h>
> #include <native/mutex.h>
> #include <native/timer.h>
> #include <native/task.h>
>=20
> void cleanup(int unused)
> {
>     // delete current task
>     rt_task_delete(NULL);
> }
>=20
> int main(int argc, char *argv[])
> {
>     signal(SIGABRT, cleanup);
>     signal(SIGKILL, cleanup);
>     signal(SIGINT, cleanup);
>     signal(SIGTERM, cleanup);
>     signal(SIGHUP, cleanup);
>     signal(SIGALRM, cleanup);
>=20
>=20
>     RT_TASK mainTask;
>=20
>     mlockall(MCL_CURRENT | MCL_FUTURE);
>     rt_task_shadow(&mainTask, "gui", 50, T_FPU);
>=20
>     rt_task_sleep((RTIME) 1E9);
>=20
>     system("ls"); // this is what causes the problem...

Ah, you mean "system" with system call - or actually any call of=20
Standard-Linux kernel services?

In any case, let's first check for runaway threads with the watchdog.

Jan


--------------enig7BD5F53AEEFA500E034DE002
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHh7PjniDOoMHTA+kRAstdAJ94Gnp6yaL+/M4WFeBW/CLX8hXMhwCfQGho
tNXnUUjZF+25cM46wokiFnc=
=T10f
-----END PGP SIGNATURE-----

--------------enig7BD5F53AEEFA500E034DE002--

