Message-ID: <44B3E4F8.5040008@domain.hid>
Date: Tue, 11 Jul 2006 19:50:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] binding without root access..
References: <e325d110607110905i40097009n517ad8b05c4b6cb4@domain.hid>	
	<44B3DA74.1070405@domain.hid>
	<e325d110607111035g238d240fo862ce480eb6f3cff@domain.hid>
In-Reply-To: <e325d110607111035g238d240fo862ce480eb6f3cff@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig57F4547D890B711C9EDCBFB1"
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
To: Kim Chuan Lim <lim.kim.chuan@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig57F4547D890B711C9EDCBFB1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Kim Chuan Lim wrote:
> Hi Jan,
>=20
> I try to run some old example from http://www.captain.at/xenomai.php
> I am getting feddup with some examples which keep on hanging my system.=

> I thought maybe if i run the old examples with normal user mode, i
> will not crash the system.

Every program with RT power can hang your system: in an endless loop
with raise priority. That's why it's not that simple to allow non-root
RT access.

>=20
> Between, the examples program in testsuits are too much complicated
> for beginner like me.
> Is there any up to date and easy understandable examples?

What about ksrc/skins/native/snippets/? They may not run but they can
give some ideas. Here is one of the simplest that does run (my classic
version):

#include <signal.h>
#include <sys/mman.h>
#include <native/task.h>

void demo(void *arg)
{
    rt_task_set_periodic(NULL, TM_NOW, 200000);
    while (1) {
        rt_task_wait_period(NULL);
        /* real-time jobs */
    }
}

void catch_signal(int sig) { }

int main(int argc, char* argv[])
{
    RT_TASK demo_task;

    signal(SIGINT, catch_signal);
    mlockall(MCL_CURRENT|MCL_FUTURE);
    rt_task_create(&demo_task, "mydemo", 0, 99, 0);
    rt_task_start(&demo_task, &demo, NULL);
    pause();
    rt_task_delete(&demo_task);
    return 0;
}

Jan


--------------enig57F4547D890B711C9EDCBFB1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEs+T4niDOoMHTA+kRAo0QAJkBkEbVMKKuMxgnD2cOM0beacD4mQCfSsf3
+cg4XyfLvlYYlIWSXHfVbNE=
=Ihux
-----END PGP SIGNATURE-----

--------------enig57F4547D890B711C9EDCBFB1--

