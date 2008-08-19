Message-ID: <48AB2560.5060804@domain.hid>
Date: Tue, 19 Aug 2008 21:56:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48AAF7DB.1080603@domain.hid> <48AB1B29.4040001@domain.hid>
	<48AB1EE6.8070003@domain.hid> <48AB241D.9000308@domain.hid>
In-Reply-To: <48AB241D.9000308@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEE810318D5283D9AB7AF3BA1"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [BUG] Lock stealing is borken
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEE810318D5283D9AB7AF3BA1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> Jan Kiszka wrote:
>>>> Hi,
>>>>
>>>> bad news, everyone :(. According to the result of some lengthy debug=

>>>> session with a customer and several ad-hoc lttng instrumentations, w=
e
>>>> have a fatal bug in the nucleus' implementation of the lock stealing=

>>>> algorithm. Consider this scenario:
>>>>
>>>> 1. Thread A acquires Mutex X successfully, ie. it leaves the (in thi=
s
>>>>    case) rt_mutex_acquire service, and its XNWAKEN flag is therefore=

>>>>    cleared.
>>>>
>>>> 2. Thread A blocks on some further Mutex Y (in our case it was a
>>>>    semaphore, but that doesn't matter).
>>>>
>>>> 3. Thread B signals the availability of Mutex Y to Thread A, thus it=

>>>>    also set XNWAKEN in Thread A. But Thread A is not yet scheduled o=
n
>>>>    its CPU.
>>>>
>>>> 4. Thread C tries to acquire Mutex X, finds it assigned to Thread A,=
 but
>>>>    also notices that the XNWAKEN flag of Thread A is set. Thus it st=
eals
>>>>    the mutex although Thread A already entered the critical section =
-
>>>>    and hell breaks loose...
>>>>
>>> See commit #3795, and change log entry from 2008-05-15. Unless I misu=
nderstood
>>> your description, this bug was fixed in 2.4.4.
>> Oh, fatally missed that fix.
>>
>> Anyway, the patch looks a bit unclean to me. Either you are lacking
>> wwake =3D NULL in xnpod_suspend_thread, or the whole information encod=
ed
>> in XNWAKEN can already be covered by wwake directly.
>>
>=20
> Clearing wwake has to be done when returning from xnsynch_sleep_on, onl=
y when
> the code knows that ownership is eventually granted to the caller; maki=
ng such a
> decision in xnpod_suspend_thread() would be wrong.

What about

http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pod.c#1411=


then?

>=20
> The awake bit has been kept mainly because the nucleus commonly uses bi=
tmasks to
> get fast access to thread status & information. It's not mandatory to h=
ave this
> one in, it's just conforming to the rest of the implementation.

I see, but redundancy come with some ugliness as well. And we add more
code to hot paths.

Jan


--------------enigEE810318D5283D9AB7AF3BA1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkirJWcACgkQniDOoMHTA+kL9ACePdFSCdTC+SVDXqcyQ/qRqJYX
2BcAn2kNIKOzmF9zHQz5vE1Ge0VwlEZj
=nnD6
-----END PGP SIGNATURE-----

--------------enigEE810318D5283D9AB7AF3BA1--

