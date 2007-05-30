Message-ID: <465D304D.6020606@domain.hid>
Date: Wed, 30 May 2007 10:05:33 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0F3@domain.hid>	<465ADB44.2070705@domain.hid>
	<1180360288.4727.50.camel@domain.hid>	<7289437c0705290130k627df2f9j2940c509311c75c5@domain.hid>	<465BE777.7010204@domain.hid>	<7289437c0705290347y20eeff5bq3e86cd0cd4984ddb@domain.hid>	<465C6268.1090704@domain.hid>	<18012.28254.882249.144005@domain.hid>	<7289437c0705292257u57e991a1l270d478fdf7f757d@domain.hid>
	<7289437c0705300051i2634264avc5f2db1fcdb91da8@domain.hid>
In-Reply-To: <7289437c0705300051i2634264avc5f2db1fcdb91da8@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE40913E7AFF12E77758EAFF3"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] =?iso-8859-1?q?Xenomai_with_=B5Clibc?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE40913E7AFF12E77758EAFF3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Perrine Martignoni wrote:
> I compiled cyclictest with this command line and it works with no probl=
em :
>=20
>=20
> arm-linux-gcc -I/usr/xenomai_arm-2.3.1uClibc/include -I/usr/xenomai_arm=
-
> 2.3.1uClibc/include/posix -D_GNU_SOURCE -D_REENTRANT -D__XENO__
> -D__IN_XENO__ -Wstrict-prototypes -DIPIPE_TRACE=3D1 -g cyclictest.c -c =
-o
> cyclictest.o
>=20
> arm-linux-gcc -Wl,--wrap,pthread_create -Wl,--wrap,pthread_setschedpara=
m
> -Wl,--wrap,pthread_getschedparam -Wl,--wrap,pthread_yield
> -Wl,--wrap,sched_yield -Wl,--wrap,sem_init -Wl,--wrap,sem_destroy
> -Wl,--wrap,sem_post -Wl,--wrap,sem_timedwait -Wl,--wrap,sem_wait
> -Wl,--wrap,sem_trywait -Wl,--wrap,sem_getvalue -Wl,--wrap,sem_open
> -Wl,--wrap,sem_close -Wl,--wrap,sem_unlink -Wl,--wrap,clock_getres
> -Wl,--wrap,clock_gettime -Wl,--wrap,clock_settime
> -Wl,--wrap,clock_nanosleep
> -Wl,--wrap,nanosleep -Wl,--wrap,pthread_mutexattr_init
> -Wl,--wrap,pthread_mutexattr_destroy -Wl,--wrap,pthread_mutexattr_getty=
pe
> -Wl,--wrap,pthread_mutexattr_settype
> -Wl,--wrap,pthread_mutexattr_getprotocol
> -Wl,--wrap,pthread_mutexattr_setprotocol
> -Wl,--wrap,pthread_mutexattr_getpshared
> -Wl,--wrap,pthread_mutexattr_setpshared -Wl,--wrap,pthread_mutex_init
> -Wl,--wrap,pthread_mutex_destroy -Wl,--wrap,pthread_mutex_lock
> -Wl,--wrap,pthread_mutex_trylock -Wl,--wrap,pthread_mutex_timedlock
> -Wl,--wrap,pthread_mutex_unlock -Wl,--wrap,pthread_condattr_init
> -Wl,--wrap,pthread_condattr_destroy -Wl,--wrap,pthread_condattr_getcloc=
k
> -Wl,--wrap,pthread_condattr_setclock -Wl,--wrap,pthread_condattr_getpsh=
ared
> -Wl,--wrap,pthread_condattr_setpshared -Wl,--wrap,pthread_cond_init
> -Wl,--wrap,pthread_cond_destroy -Wl,--wrap,pthread_cond_wait
> -Wl,--wrap,pthread_cond_timedwait -Wl,--wrap,pthread_cond_signal
> -Wl,--wrap,pthread_cond_broadcast -Wl,--wrap,mq_open -Wl,--wrap,mq_clos=
e
> -Wl,--wrap,mq_unlink -Wl,--wrap,mq_getattr -Wl,--wrap,mq_setattr
> -Wl,--wrap,mq_send -Wl,--wrap,mq_timedsend -Wl,--wrap,mq_receive
> -Wl,--wrap,mq_timedreceive -Wl,--wrap,mq_notify -Wl,--wrap,open
> -Wl,--wrap,socket -Wl,--wrap,close -Wl,--wrap,ioctl -Wl,--wrap,read
> -Wl,--wrap,write -Wl,--wrap,recvmsg -Wl,--wrap,sendmsg -Wl,--wrap,recvf=
rom
> -Wl,--wrap,sendto -Wl,--wrap,recv -Wl,--wrap,send -Wl,--wrap,getsockopt=

> -Wl,--wrap,setsockopt -Wl,--wrap,bind -Wl,--wrap,connect -Wl,--wrap,lis=
ten
> -Wl,--wrap,accept -Wl,--wrap,getsockname -Wl,--wrap,getpeername
> -Wl,--wrap,shutdown -Wl,--wrap,timer_create -Wl,--wrap,timer_delete
> -Wl,--wrap,timer_settime -Wl,--wrap,timer_getoverrun
> -Wl,--wrap,timer_gettime -Wl,--wrap,ftruncate -Wl,--wrap,close
> -Wl,--wrap,shm_open -Wl,--wrap,shm_unlink -Wl,--wrap,mmap -Wl,--wrap,mu=
nmap
> -L/usr/xenomai_arm-2.3.1uClibc/lib cyclictest.o -lpthread_rt -lpthread =
-lrt
> -o cyclictest
>=20
>=20
>=20
> I don't see the difference with my own test.
> I try again with my code with this command line exactly and I have the =
same
> error :
>=20
>=20
> /usr/src/ELDK_arm/usr/../arm/lib/libpthread.so: undefined reference to
> `__wrap_mmap'
>=20
> /usr/src/ELDK_arm/usr/../arm/lib/librt.so: undefined reference
> to`__wrap_close'
>=20
> /usr/src/ELDK_arm/usr/../arm/lib/libpthread.so: undefined reference to
> `__wrap_munmap'
>=20
> collect2: ld returned 1 exit status
>=20

I don't see the reason either. But as the compiled code seems to have an
effect here, could you try to reduce your program until is builds fine?
Maybe this will give us some more hints where to dig.

Jan


--------------enigE40913E7AFF12E77758EAFF3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGXTBQniDOoMHTA+kRAo9SAJ0YsFtIk7uiU5PWg5njClVconi7VwCfRTUf
wXCLRCIA1ww6erN2WTV7qUk=
=nKuH
-----END PGP SIGNATURE-----

--------------enigE40913E7AFF12E77758EAFF3--

