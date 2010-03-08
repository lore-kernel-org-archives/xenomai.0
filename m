From: "Charlton, John" <john.charlton@domain.hid>
Date: Mon, 8 Mar 2010 16:13:22 -0500
Message-ID: <CF7FB0793253794F9F45991443E5FE20076A70F4C2@domain.hid>
References: <4B8D9711.5090704@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2006483DE99F@us194mx002.tycoelectronics.net>
	<4B914F4B.1040205@domain.hid>
	<CF7FB0793253794F9F45991443E5FE20076A70F4C0@domain.hid>
	<4B95463D.2040705@domain.hid>
	<CF7FB0793253794F9F45991443E5FE20076A70F4C1@domain.hid>
	<4B956133.5070203@domain.hid>
In-Reply-To: <4B956133.5070203@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [pull request] Fixes and workarounds for the
	cond issues
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: "'jan.kiszka@domain.hid'" <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

These tests also pass:

root@domain.hid# ./cond-torture-native
simple_condwait
relative_condwait
absolute_condwait
sig_norestart_condwait
sig_restart_condwait
sig_norestart_condwait_mutex
sig_restart_condwait_mutex
sig_norestart_double
sig_restart_double
cond_destroy_whilewait
Test OK
root@domain.hid# ./cond-torture-posix
simple_condwait
relative_condwait
absolute_condwait
sig_norestart_condwait
sig_restart_condwait
sig_norestart_condwait_mutex
sig_restart_condwait_mutex
sig_norestart_double
sig_restart_double
cond_destroy_whilewait
Test OK
root@domain.hid#
=20
If you want me to run other tests let me know.  I have run xeno-test as wel=
l as these torture tests.  My unit test code tests a custom sja1000 can dri=
ver that I wrote based on the xenomai rtcan_peak_pci.c driver module.  If y=
ou want source for that I will send it but it is of limited value since it =
is written for our custom PLX9030 PCI interface.

--

John

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Sent: Monday, March 08, 2010 3:42 PM
To: Charlton, John
Cc: 'jan.kiszka@domain.hid'; xenomai-core
Subject: Re: [pull request] Fixes and workarounds for the cond issues

Charlton, John wrote:
> Yes with the xenomai-2.5 branch latest as of 1900 UTC everything works wi=
thout error including the mutex-torture tests (output below):
>=20
> root@domain.hid# ./mutex-torture-native simple_wait=20
> recursive_wait timed_mutex mode_switch pi_wait lock_stealing
> NOTE: lock_stealing mutex_trylock: not supported simple_condwait=20
> recursive_condwait Test OK root@domain.hid
> ./mutex-torture-posix simple_wait recursive_wait errorcheck_wait=20
> timed_mutex mode_switch pi_wait lock_stealing
> NOTE: lock_stealing mutex_trylock: not supported simple_condwait=20
> recursive_condwait Test OK root@domain.hid#
>=20
> pthread_set_mode_np(NULL, PTHREAD_WARNSW) also works with this branch. Th=
ank you for the help.

You also have cond-torture-posix, and cond-torture-native, which should tes=
t, among other things, the fix for the condition variable bug you had.

--=20
					    Gilles.

