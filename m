From: "Charlton, John" <john.charlton@domain.hid>
Date: Mon, 8 Mar 2010 13:42:31 -0500
Message-ID: <CF7FB0793253794F9F45991443E5FE20076A70F4C0@domain.hid>
References: <4B8D9711.5090704@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2006483DE99F@us194mx002.tycoelectronics.net>
	<4B914F4B.1040205@domain.hid>
In-Reply-To: <4B914F4B.1040205@domain.hid>
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

I configured and built with linux-2.6.32.7 and xenomai-jki for-upstream sna=
pshot: f98569c8eec5df605f806ff58e789668720805ee. I noticed that you removed=
 the PTHREAD_WARNSW so I removed the call to pthread_set_mode_np to remove =
the following errors:

PosixThread/PosixThread.cpp:1607: error: 'PTHREAD_WARNSW' was not declared =
in this scope
PosixThread/PosixThread.cpp:1607: error: 'pthread_set_mode_np' was not decl=
ared in this scope

I am able to run all of my user space application code and unit test code w=
hich uses CanFestival open source CAN library.  I am also able to run the x=
eno-test which runs to completion with no errors.  When I run the mutex-tor=
ture tests I still get the following errors which I have not looked into in=
 more detail yet:


root@domain.hid# ./mutex-torture-native
simple_wait
recursive_wait
timed_mutex
FAILURE: timed_waiter, waited 4.110 us
root@domain.hid# ./mutex-torture-posix
simple_wait
recursive_wait
errorcheck_wait
timed_mutex
FAILURE: timed_mutex mutex_destroy: 22 (Invalid argument)

I am now looking at xenomai-rpm branch which one is close to 2.5.2 release?

--

John

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Sent: Friday, March 05, 2010 1:37 PM
To: Charlton, John
Cc: 'jan.kiszka@domain.hid'; xenomai-core
Subject: Re: [pull request] Fixes and workarounds for the cond issues

Charlton, John wrote:
> I merged some changes from git://git.xenomai.org/xenomai-jki.git=20
> for-upstream  to my xenomai-2.5.1 release distribution to include the rt_=
cond_wait and pthread_cond_[timed]wait work arounds.  I also merged changes=
 to the mutex_torture.c.  Everything builds and most tests seem to pass but=
 I get the following output from the mutex-torture tests:

You are probably missng the changes for recursive_cond_wait for the posix s=
kin which were commited in the development branch. You do not see it becaus=
e the new mutex-torture tests were added before the recursive cond test.

>=20
> root@domain.hid# ./mutex-torture-native simple_wait=20
> recursive_wait timed_mutex
> FAILURE: timed_waiter, waited 3.870 us root@domain.hid
> ./mutex-torture-posix simple_wait recursive_wait errorcheck_wait=20
> timed_mutex
> FAILURE: timed_mutex mutex_destroy: 22 (Invalid argument)
>=20
> Do you have suggestions on how to resolve these errors hopefully without =
moving to the full development branch?

This kind of thing is exactly the reason why I told I would work quietly on=
 this issue. Things will be ready on monday, but it would help us a great d=
eal if you could test the development branch on monday, at the same time as=
 when we are validating it on our test platforms.

Can not do better right now.

--=20
					    Gilles.

