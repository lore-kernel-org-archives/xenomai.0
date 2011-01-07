Message-ID: <4D26CEBE.6070308@domain.hid>
Date: Fri, 07 Jan 2011 09:28:46 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4D23435B.70603@domain.hid> <201101052040.24049.kisda@domain.hid>
	<4D24CCB1.30305@domain.hid> <201101052303.46018.kisda@domain.hid>
In-Reply-To: <201101052303.46018.kisda@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC72D1DE06FFE77589EC69221"
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
--------------enigC72D1DE06FFE77589EC69221
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 05.01.2011 23:03, Stefan Kisdaroczi wrote:
> Am Mittwoch 05 Januar 2011, 20:55:29 schrieb Jan Kiszka:
>> Am 05.01.2011 20:40, Stefan Kisdaroczi wrote:
>>> Am Dienstag 04 Januar 2011, 20:49:59 schrieben Sie:
>>>> Stefan Kisdaroczi wrote:
>>>>> Hi,
>>>>>
>>>>> the attached patch adds pci support to the 16550A serial driver. I =
have
>>>>> a Moxa CP-132 board and the first tests are looking good. If there =
is a
>>>>> chance to get the patch applied I kindly request you to review it. =
I'll
>>>>> add support for more Moxa boards if there is a interest to apply th=
e
>>>>> patch.
>>>>>
>>>>> thanks
>>>>> Stefan
>>>>
>>>> Looks fine to me, however, nit-picking a bit, could we do this diffe=
rently:
>>> new patches attached.
>>
>> Looks good to me as well except for a minor white space damage:
>>> +static int __devinit rt_16550_pci_probe(       struct pci_dev *pdev,=

>>
>>                                            ^^^^^^^
>>
>> I have one further suggestion which can be done on top: The RTDM_IRQTY=
PE
>> flags should be customized as well. So far we assume edge-type devices=
,
>> but PCI is level-triggered. Requesting edge works, but is suboptimal.
>>
>> Jan
>=20
> thanks for the input. updated patches attached with customizable irqtyp=
e.=20
> better? (not compiled and not tested -> tomorrow)
>=20

Fine with me (unless an even smarter solution shows up, but I don't see
it ATM). One simplification:

static unsigned long irqtype[MAX_DEVICES] =3D {
	[0 ... MAX_DEVICES-1] =3D RTDM_IRQTYPE_SHARED | RTDM_IRQTYPE_EDGE;
};

Jan


--------------enigC72D1DE06FFE77589EC69221
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk0mzr4ACgkQitSsb3rl5xTG1QCgsClJvKQJUOA2V5nyf7iQE9yb
i54AoNwqmAF58LBsJN9YWRFbAOFWR74G
=1Xwu
-----END PGP SIGNATURE-----

--------------enigC72D1DE06FFE77589EC69221--

