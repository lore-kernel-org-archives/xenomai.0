Message-ID: <4BDC357A.30803@domain.hid>
Date: Sat, 01 May 2010 16:06:50 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1O78nO-0008PE-EK@xenomai.org> <4BDC332E.2010804@domain.hid>
In-Reply-To: <4BDC332E.2010804@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig51BC60414BA08F536A6AC26D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : native: Improve fault
 tolerance /wrt multiple task deletions
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig51BC60414BA08F536A6AC26D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> GIT version control wrote:
>> Module: xenomai-jki
>> Branch: for-upstream
>> Commit: 5d2fa6c7578683e036d88bc6dbb6a7f458dfe705
>> URL:    http://git.xenomai.org/?p=3Dxenomai-jki.git;a=3Dcommit;h=3D5d2=
fa6c7578683e036d88bc6dbb6a7f458dfe705
>>
>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>> Date:   Wed Apr 28 15:08:11 2010 +0200
>>
>> native: Improve fault tolerance /wrt multiple task deletions
>>
>> As we may pass the pthread handle of an RT_TASK directly to glibc, we
>> may trigger a SIGSEGV if the underlying thread was already terminated.=

>> Try to catch this application mistakes by clearing the handle at least=

>> in that task descriptor which successfully ran rt_task_delete or
>> rt_task_join.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>=20
> Ok. I have tested this patch (though I could not find whether it was
> discussed on the mailing list). And in fact, it looks to me like it
> turns an application error into a silently working application.

Then there is probably something broken: rt_task_delete is supposed to
return -EIDRM of the passed handle no longer exists. That's at least
what the doc says. The point of this patch is to turn an application
crash into a proper error return value (and that not only for
--enable-debug).

Jan


--------------enig51BC60414BA08F536A6AC26D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvcNX0ACgkQitSsb3rl5xRDNgCfXFAKEim1AuWGC7M04UgUL1vD
GHwAn0J4QG67ZXbrl1PN6BRelplj5lw2
=CXD6
-----END PGP SIGNATURE-----

--------------enig51BC60414BA08F536A6AC26D--

