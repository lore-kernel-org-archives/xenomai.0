Message-ID: <460019CA.1090308@domain.hid>
Date: Tue, 20 Mar 2007 18:28:42 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [Xenomai-help] Xenomai v2.3.1
References: <1174379951.5068.5.camel@domain.hid> <46000AFE.9070504@domain.hid>
	<4600125A.6000304@domain.hid>
In-Reply-To: <4600125A.6000304@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig00570DA6DE9ED7B4AF74B43B"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig00570DA6DE9ED7B4AF74B43B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Bill Gatliff wrote:
>> Guys:
>>
>> Philippe Gerum wrote:
>>
>>> 	[posix]
>>> 	* Fix pthread_cond_wait() upon signal receipt (grab mutex anew).
>>> =20
>>
>> Probably OT, but someone was complaining to me the other day that=20
>> pthreads running on SCHED_FIFO/SCHED_RR that are blocked on mutexes=20
>> don't release in priority order.  This was on a stock 2.6.18 kernel,=20
>> "recent glibc" (I didn't catch which version or config), ARM9 platform=
=2E
>>
>> First question: Is this actually true?
>>
>> Second question: Does Xenomai fix this?  Do more recent kernel=20
>> developments fix this?
>>
>> Point me at the appropriate RTFM or code if that's the appropriate=20
>> answer.  :)
>=20
> The appropriate RTFM is the POSIX spec [1]
>=20
> In short, it says: "If there are threads blocked on the mutex object
> referenced by 'mutex' when pthread_mutex_unlock() is called, resulting
> in the mutex becoming available, the scheduling policy shall determine
> which thread shall acquire the mutex."
>=20
> So, the correct implementation is to release a mutex in priority order.=

>=20
> I think the glibc implements this correctly (at least NPTL), on the
> other hand, I believe it is not true for threads running with the
> SCHED_OTHER policy, in order to prevent starvation.

The problem with stock kernel is the FUTEX_WAIT operation: That one is
used by glibc to block on non-PI mutexes. It dequeues in FIFO order,
regardless of the waiter's priority. FUTEX_LOCK_PI (used e.g. for
PTHREAD_PRIO_INHERIT mutexes since glibc 2.5) is fine again.

The -rt patch contains a fix for FUTEX_WAIT, and I think I saw some
mainline patch once circulating as well. But it received a bit
scepticism due to possible performance regression for futex users that
don't care about priorities. And so nothing happened yet (I just checked
latest git)...

Jan


--------------enig00570DA6DE9ED7B4AF74B43B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGABnKniDOoMHTA+kRAthnAJ9vqT30Dk6WPN2V9cf/NkL5iJgQSACcD4kd
jSuN/9AYyiHgmjCgQ6oK00k=
=O3bO
-----END PGP SIGNATURE-----

--------------enig00570DA6DE9ED7B4AF74B43B--

