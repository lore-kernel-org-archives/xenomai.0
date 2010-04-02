Message-ID: <4BB5B2D3.80708@domain.hid>
Date: Fri, 02 Apr 2010 11:03:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20100401230843.GF3755@domain.hid>
	<4BB53566.3010601@domain.hid> <4BB53643.2080604@domain.hid>
	<4BB5AA44.6000006@domain.hid> <4BB5AACE.7020602@domain.hid>
	<4BB5B1BD.6020903@domain.hid>
In-Reply-To: <4BB5B1BD.6020903@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig971E58ADB9AB54F88D3FE093"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] New scheduler class
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
--------------enig971E58ADB9AB54F88D3FE093
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Andreas Glatz wrote:
>>>>>> Hi Philippe,
>>>>>>
>>>>>> At the Xenomai Users Meeting last year I asked you if Xenomai woul=
d offer a possibility to lower the priority of certain Xenomai tasks belo=
w that of Linux. We need this feature since we have tasks in our RT appli=
cation which should only run when Linux is idle (A statistics collection =
task which part of the RT application and hard to isolate from this appli=
cation).
>>>>>>
>>>>> What prevents using a borderline thread (if you need to interact wi=
th
>>>>> blocking Xenomai services) with SCHED_OTHER and a Linux nice level =
of 19?
>>>> Well, this does not really guarantee that the thread will run only w=
hen
>>>> linux is idle. The thread will eat some cpu time, the nice level is =
not
>>>> a strict priority, as you know.
>>> Where do you really need anything stricter? It's the opposite of "I n=
eed
>>> true 100% CPU for my task, and that forever."
>>>
>>>> But in fact, I wonder why Andreas wants
>>>> a new scheduling policy for xenomai, what is needed, is simply a
>>>> SCHED_IDLE (maybe it exists ?!) policy for Linux.
>>>>
>>> There is no such thing AFAIK. If you are concerned that some CPU
>>> intensive low prio job eats too much CPU, you normally reduce its
>>> nice-level and/or confine its CPU bandwidth via cgroups.
>> SCHED_IDLE exists.
>>
>=20
> Ah, as "nice 20". Same mechanism, just another level.
>=20

=2E..and before trying something else:

"SCHED_IDLE: This is even weaker than nice 19, but its not a true
idle timer scheduler in order to avoid to get into priority
inversion problems which would deadlock the machine."

Jan


--------------enig971E58ADB9AB54F88D3FE093
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAku1stMACgkQitSsb3rl5xSh0gCfRznCbMC84QxLLFAj5tt9cjp+
2oMAniMBxZG3RpFqAIhMoKJ+L+AJTxg6
=knRo
-----END PGP SIGNATURE-----

--------------enig971E58ADB9AB54F88D3FE093--

