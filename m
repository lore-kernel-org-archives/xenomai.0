Message-ID: <464B3BC6.1030807@domain.hid>
Date: Wed, 16 May 2007 19:13:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <e2ceda030705160953h27bc4033q4c2ccdba6b65bc7@domain.hid>
In-Reply-To: <e2ceda030705160953h27bc4033q4c2ccdba6b65bc7@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBB8198A3C70F26C1F1024094"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Getting mutex state/rt <-> non-rt communication
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Maciek Godek <pstrychuj@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBB8198A3C70F26C1F1024094
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Maciek Godek wrote:
> Hi,
> is it obligatory to use the rt_mutex_inquire in order to get the mutex
> state, or could I possibly use the field lockcnt from struct RT_MUTEX
> directly? (the test should be, as I believe, atomic - so should I
> worry?)

UAAAH!!! Don't do this, never!

Locking a mutex means more, e.g. assigning a _schedulable_ Xenomai
thread as owner so that one can raise its priority if a higher thread
contents for the same lock. It also means blocking if the mutex is
currently locked, also requiring Xenomai thread context.

>=20
> The thing is that I'm using mutices for IPC between an rt-task and a
> regular linux process. The rt code is critical, but in the
> non-realtime code I can pay the cost of low latency polling to find
> out if the realtime code has finished. (Perhaps there is a better way
> to do it? The code now looks like this:
>=20
> RT_MUTEX busy;
> RT_COND data_ready;
> // both are initialized (elsewhere)
>=20
> void realtime_thread(void *) {
>   rt_mutex_acquire(&busy, 0);
>   for(;;) {
>     rt_cond_wait(&data_ready, &busy, TM_INFINITE);
>     // here it does something critical - it actually communicates
>     // with an external device over serial port using the famous rtdm
>     // serial driver developed and maintained by Jan Kiszka.
>   }
> }
>  ...
> // there is only one thread that communicates with the realtime
> // thread above - and this code is invoked within it.
> rt_cond_signal(&data_ready);
> // now the rt-thread does something. I can estimate the upper time limi=
t
> // of the one iteration of that task.
> usleep(predicted_time);
> if(busy.lockcnt) {
>   // timeout - this is possible as it depends on the external devices. =
Of course
>   // sooner or later the mutex will be released by the rt thread.
> }
>=20
> is there any wiser way to communicate these threads?)

Kernel or user space?

Jan


--------------enigBB8198A3C70F26C1F1024094
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGSzvGniDOoMHTA+kRAvboAJsEM2UBdw5Zk+E+sdJlT69pwDtz7QCeMUfO
JQuKZvKFH23Aod2i9Oaeg8A=
=9zsb
-----END PGP SIGNATURE-----

--------------enigBB8198A3C70F26C1F1024094--

