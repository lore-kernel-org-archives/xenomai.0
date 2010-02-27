Message-ID: <4B8903E1.3020805@domain.hid>
Date: Sat, 27 Feb 2010 12:37:05 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1Nl4tX-0001N9-Hb@domain.hid> <4B881E9D.1050101@domain.hid>
	<4B88203F.2020907@domain.hid>
In-Reply-To: <4B88203F.2020907@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8137396683B5A436C621F03D"
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
--------------enig8137396683B5A436C621F03D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> GIT version control wrote:
>>> diff --git a/ksrc/skins/posix/mq.c b/ksrc/skins/posix/mq.c
>>> index 11f47c0..a896031 100644
>>> --- a/ksrc/skins/posix/mq.c
>>> +++ b/ksrc/skins/posix/mq.c
>>> @@ -1283,6 +1283,7 @@ int pse51_mq_select_bind(mqd_t fd, struct xnsel=
ector *selector,
>>>  	return 0;
>>> =20
>>>        unlock_and_error:
>>> +	xnfree(binding):
>>>  	xnlock_put_irqrestore(&nklock, s);
>>>  	return err;
>>>  }
>> Ok. Will pull. But I really need to fix that.
>>
>=20
> Ack - now that I see it myself.
>=20

I fixed this in my branch and added another patch to transform EIDRM
into EBADF when selecting a (half-)deleted RTDM device. Please merge.

Thanks,
Jan


--------------enig8137396683B5A436C621F03D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkuJA+UACgkQitSsb3rl5xRprACfXmt62wHXTnMgEgnLOBq/ovgq
ESsAoJDzVEJ4x8cmPVCohHEQbDAyu+hr
=RnjJ
-----END PGP SIGNATURE-----

--------------enig8137396683B5A436C621F03D--

