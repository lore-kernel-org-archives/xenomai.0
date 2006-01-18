Message-ID: <43CEA91F.6080308@domain.hid>
Date: Wed, 18 Jan 2006 21:46:23 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Scheduling while atomic
References: <fd6a47a90601171559x13acf2c2m@domain.hid>	<43CE9FCB.2070305@domain.hid>	<17358.42102.613327.327841@domain.hid>
	<43CEA56D.8000407@domain.hid>
In-Reply-To: <43CEA56D.8000407@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig50B721737A5FF1EAA37C0F6F"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig50B721737A5FF1EAA37C0F6F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>  > Jeroen Van den Keybus wrote:
>>  > > Gilles,
>>  > >=20
>>  > >=20
>>  > > I cannot reproduce those messages after turning nucleus debugging=
 on.
>>  > > Instead, I now either get relatively more failing mutexes or even=
 hard
>>  > > lockups with the test program I sent to you. If the computer didn=
't crash,
>>  > > dmesg contains 3 Xenomai messages relating to a task being movend=
 to
>>  > > secondary domain after exception #14. As when the computer crashe=
s: I have
>>  > > written the last kernel panic message on a paper. Please tell if =
you want
>>  > > also the addresses or (part of) the call stack.
>>  > >=20
>>  > > I'm still wondering if there's a programming error in the mutex t=
est
>>  > > program. After I sent my previous message, and before I turned nu=
cleus
>>  > > debugging on, I managed (by reducing the sleeptimes to max. 5.0e4=
) to
>>  > > fatally crash the computer, while spewing out countless 'scheduli=
ng while
>>  > > atomic messages'. Is the mutex error reproducible ?
>>  >=20
>>  > I was not able to crash my box or generate that scheduler warnings,=
 but
>>  > the attached patch fixes the false positive warnings of unlocked
>>  > mutexes. We had a "leak" in the unlock path when someone was alread=
y
>>  > waiting. Anyway, *this* issues should not have caused any other pro=
blems
>>  > then the wrong report of rt_mutex_inquire().
>>
>> Actually the patch seem insufficient, the whole block :
>> 	{
>> 	xnsynch_set_owner(&mutex->synch_base,&task->thread_base);
>> 	mutex->owner =3D task;
>> 	mutex->lockcnt =3D 1;
>> 	goto unlock_and_exit;
>> 	}
>>
>> should be done after xnsynch_sleep_on in rt_mutex_lock.
>>
>=20
> Damn, of course - except for "mutex->owner =3D task". Then this missing=

> xnsync_set_owner() may have caused serious issues? Will test...

Correction: xnsynch_wakeup_one_sleeper() updates synch->owner, so all
fine with my patch in this regard. I guess it is really some migration
issue again.

Jan


--------------enig50B721737A5FF1EAA37C0F6F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDzqkfniDOoMHTA+kRAuuQAJwII3YWYfcyDGA0hZ94FfAiOLxCrgCggaSX
5emOrL43eJUdxfPsSRX/r2I=
=RHWO
-----END PGP SIGNATURE-----

--------------enig50B721737A5FF1EAA37C0F6F--

