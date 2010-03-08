From: "Charlton, John" <john.charlton@domain.hid>
Date: Mon, 8 Mar 2010 15:39:50 -0500
Message-ID: <CF7FB0793253794F9F45991443E5FE20076A70F4C1@domain.hid>
References: <4B8D9711.5090704@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2006483DE99F@us194mx002.tycoelectronics.net>
	<4B914F4B.1040205@domain.hid>
	<CF7FB0793253794F9F45991443E5FE20076A70F4C0@domain.hid>
	<4B95463D.2040705@domain.hid>
In-Reply-To: <4B95463D.2040705@domain.hid>
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

Yes with the xenomai-2.5 branch latest as of 1900 UTC everything works with=
out error including the mutex-torture tests (output below):

root@domain.hid# ./mutex-torture-native
simple_wait
recursive_wait
timed_mutex
mode_switch
pi_wait
lock_stealing
NOTE: lock_stealing mutex_trylock: not supported
simple_condwait
recursive_condwait
Test OK
root@domain.hid# ./mutex-torture-posix=20
simple_wait
recursive_wait
errorcheck_wait
timed_mutex
mode_switch
pi_wait
lock_stealing
NOTE: lock_stealing mutex_trylock: not supported
simple_condwait
recursive_condwait
Test OK
root@domain.hid

pthread_set_mode_np(NULL, PTHREAD_WARNSW) also works with this branch. Than=
k you for the help.

--

John

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Sent: Monday, March 08, 2010 1:47 PM
To: Charlton, John
Cc: 'jan.kiszka@domain.hid'; xenomai-core
Subject: Re: [pull request] Fixes and workarounds for the cond issues

Charlton, John wrote:
> I configured and built with linux-2.6.32.7 and xenomai-jki for-upstream s=
napshot: f98569c8eec5df605f806ff58e789668720805ee. I noticed that you remov=
ed the PTHREAD_WARNSW so I removed the call to pthread_set_mode_np to remov=
e the following errors:
>=20
> PosixThread/PosixThread.cpp:1607: error: 'PTHREAD_WARNSW' was not=20
> declared in this scope
> PosixThread/PosixThread.cpp:1607: error: 'pthread_set_mode_np' was not=20
> declared in this scope

This should come with #include <pthread.h>, provided you use xeno-config --=
posix-cflags (soon to be deprecated way) or xeno-config --skin=3Dposix --cf=
lags to get the compilation flags.

>=20
> I am able to run all of my user space application code and unit test
code which uses CanFestival open source CAN library. I am also able to run =
the xeno-test which runs to completion with no errors. When I run the mutex=
-torture tests I still get the following errors which I have not looked int=
o in more detail yet:
>=20
>=20
> root@domain.hid# ./mutex-torture-native simple_wait=20
> recursive_wait timed_mutex
> FAILURE: timed_waiter, waited 4.110 us root@domain.hid
> ./mutex-torture-posix simple_wait recursive_wait errorcheck_wait=20
> timed_mutex
> FAILURE: timed_mutex mutex_destroy: 22 (Invalid argument)
>=20
> I am now looking at xenomai-rpm branch which one is close to 2.5.2 releas=
e?

the master branch of the xenomai-2.5 repository. As explained here:
http://www.xenomai.org/index.php/Main_Page

in the "Fetching the source code repositories"

--=20
					    Gilles.

