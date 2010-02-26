Message-ID: <4B88203F.2020907@domain.hid>
Date: Fri, 26 Feb 2010 20:25:51 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1Nl4tX-0001N9-Hb@domain.hid> <4B881E9D.1050101@domain.hid>
In-Reply-To: <4B881E9D.1050101@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8C3F90DEE77196CBE347B748"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : RTDM+POSIX: Avoid
 leaking binding objects on errors
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8C3F90DEE77196CBE347B748
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> GIT version control wrote:
>> diff --git a/ksrc/skins/posix/mq.c b/ksrc/skins/posix/mq.c
>> index 11f47c0..a896031 100644
>> --- a/ksrc/skins/posix/mq.c
>> +++ b/ksrc/skins/posix/mq.c
>> @@ -1283,6 +1283,7 @@ int pse51_mq_select_bind(mqd_t fd, struct xnsele=
ctor *selector,
>>  	return 0;
>> =20
>>        unlock_and_error:
>> +	xnfree(binding):
>>  	xnlock_put_irqrestore(&nklock, s);
>>  	return err;
>>  }
>=20
> Ok. Will pull. But I really need to fix that.
>=20

Ack - now that I see it myself.

Jan


--------------enig8C3F90DEE77196CBE347B748
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkuIIEcACgkQitSsb3rl5xQOHwCdGwl1EzkZ3nA/1yQgB28fqXqS
ZUMAoMiFdfiY8vDgV/yVlqv+9qp6oZH1
=CHOp
-----END PGP SIGNATURE-----

--------------enig8C3F90DEE77196CBE347B748--

