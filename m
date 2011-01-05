Message-ID: <4D24CCB1.30305@domain.hid>
Date: Wed, 05 Jan 2011 20:55:29 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4D23435B.70603@domain.hid> <4D2379E7.6050307@domain.hid>
	<201101052040.24049.kisda@domain.hid>
In-Reply-To: <201101052040.24049.kisda@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE0488338AFE3E9270799EFEC"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] RFC: 16550A pci serial board support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE0488338AFE3E9270799EFEC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 05.01.2011 20:40, Stefan Kisdaroczi wrote:
> Am Dienstag 04 Januar 2011, 20:49:59 schrieben Sie:
>> Stefan Kisdaroczi wrote:
>>> Hi,
>>>
>>> the attached patch adds pci support to the 16550A serial driver. I ha=
ve
>>> a Moxa CP-132 board and the first tests are looking good. If there is=
 a
>>> chance to get the patch applied I kindly request you to review it. I'=
ll
>>> add support for more Moxa boards if there is a interest to apply the
>>> patch.
>>>
>>> thanks
>>> Stefan
>>
>> Looks fine to me, however, nit-picking a bit, could we do this differe=
ntly:
>=20
> new patches attached.
>=20

Looks good to me as well except for a minor white space damage:

> +static int __devinit rt_16550_pci_probe(       struct pci_dev *pdev,
                                           ^^^^^^^

I have one further suggestion which can be done on top: The RTDM_IRQTYPE
flags should be customized as well. So far we assume edge-type devices,
but PCI is level-triggered. Requesting edge works, but is suboptimal.

Jan


--------------enigE0488338AFE3E9270799EFEC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk0kzLQACgkQitSsb3rl5xQNFACeINFz1Or5u3ZVo+rZIOSaYEjt
Pn0AnRhxzJ13QdtdJBhD5txWD0QFiIgL
=HUkc
-----END PGP SIGNATURE-----

--------------enigE0488338AFE3E9270799EFEC--

