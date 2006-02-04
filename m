Message-ID: <43E46ADC.7010601@domain.hid>
Date: Sat, 04 Feb 2006 09:50:36 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAEEC553850C718F499AE6060"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [BUG] deleting a T_SUSP'ed native task
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAEEC553850C718F499AE6060
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Gilles,

were you able to successfully run my T_SUSP test-case after the latest
changes? For me this code still causes fatal exceptions:

#include <stdio.h>
#include <sys/mman.h>
#include <native/task.h>

void func(void *arg)
{
    printf("you should not see this\n");
    rt_task_suspend(NULL);
}

int main(int argc, char **argv)
{
    RT_TASK task;

    mlockall(MCL_CURRENT|MCL_FUTURE);
    rt_task_create(&task, "T_SUSP-test", 0, 10, T_SUSP);
    rt_task_start(&task, func, NULL);
    printf("deleting...\n");
    rt_task_delete(&task);
    return 0;
}


This is the output of the locked up system:

[  115.263641] Xenomai: fatal: xnshadow_relax() failed for thread
T_SUSP-test[871]
[  115.263650]  CPU  PID    PRI  TIMEOUT  STAT      NAME
[  115.263656]    0  0      10   0        00500088  ROOT
[  115.263661] >  0  871    10   0        00301880  T_SUSP-test
[  115.263666] Timer: oneshot [tickval=3D1 ns, elapsed=3D115298322556]
[  115.263671]
[  115.300112] ce853f24 d085fa78 c1300000 d08606f8 d0a21d70 00000367
ce853fbc c0301780
[  115.309231]        58454e4f ce853f74 d0859cfe 00000001 00000018
b7db4000 ce853f80 d0a21a60
[  115.319295]        cf09a570 c04f2d80 c0301780 c04f2d80 ce853fa8
c013b695 00000021 c04f2d80
[  115.329359] Call Trace:
[  115.332497]  [<c0103784>] show_stack+0x94/0xe0
[  115.337847]  [<d085903a>] xnshadow_relax+0x19a/0x230 [xeno_nucleus]
[  115.345418]  [<d0859cfe>] hisyscall_event+0xde/0x3a0 [xeno_nucleus]
[  115.352961]  [<c013b695>] __ipipe_dispatch_event+0x95/0x130
[  115.359657]  [<c010e571>] __ipipe_syscall_root+0x31/0xf0
[  115.366038]  [<c0103070>] system_call+0x20/0x41

And then this:

[  115.550244] Xenomai: watchdog triggered -- suspending runaway thread
'T_SUSP-test'
[  115.554242] Xenomai: watchdog triggered -- suspending runaway thread
'T_SUSP-test'
[  115.558241] Xenomai: watchdog triggered -- suspending runaway thread
'T_SUSP-test'
=2E..

Jan


--------------enigAEEC553850C718F499AE6060
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD5GrhniDOoMHTA+kRApsDAJ4rproffRA2iZmuudYuelLt4ykNEACfdsSx
Deowl6GTVhuN3VeaA5yOnCo=
=23dV
-----END PGP SIGNATURE-----

--------------enigAEEC553850C718F499AE6060--

