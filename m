Message-ID: <451A9C64.7040802@domain.hid>
Date: Wed, 27 Sep 2006 17:44:36 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20060927151753.9409.qmail@domain.hid>
In-Reply-To: <20060927151753.9409.qmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1C6BE6F054D0D50991C1491C"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-help] Re: [Xenomai-core] aperiodic xenomai tasks
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: mani bhatti <imranbashirbhatti@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1C6BE6F054D0D50991C1491C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

mani bhatti wrote:
> Thanks Jan for your reply
> Actually the semaphore and mutexes stuff you have referred to i have
> already grounds for them.The only problem i have is please some body
> tell me that i dont want to make a thread periodic i,e i dont want to
> call a thread after periodic time interval i wanted it to  make it
> aperiodic like threads in C++ are scheduled by scheduler byitself

This has nothing to do with C++, rather with the class library you are
used to.

> and sleep on waiting condition with out any specific time interval
> and wake  only when  signalled from  pariodic thread. I hope you
> understand my point.Thanks a lot .

Let's try it differently:

thread_a()
{
	rt_task_set_periodic(...);
	while (1) {
		rt_task_wait_period(NULL);
		/* do some work */
		if (I_should_trigger_thread_b)
			rt_sem_v(&sem);
	}
}

thread_b()
{
	while (1) {
		rt_sem_p(&sem, TM_INFINITE);
		/* so some other work */
	}
}

Again, read up what the services are exactly doing or you will be lost
once you have to modify things only slightly.

Jan


--------------enig1C6BE6F054D0D50991C1491C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFGpxkniDOoMHTA+kRAl1oAJ4oQDpdi2EeS7AOi4zrri2j9Q8JYgCfbiag
PD1kUGu3pswlxdMdUAUEEeI=
=1Mi5
-----END PGP SIGNATURE-----

--------------enig1C6BE6F054D0D50991C1491C--

