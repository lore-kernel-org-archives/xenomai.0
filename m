Message-ID: <4CB40261.40903@domain.hid>
Date: Tue, 12 Oct 2010 08:38:25 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <AANLkTi=6d4sZN11G0TfDXZPfwS8dDkhgE=LjnGcS4AG1@domain.hid>	<AANLkTinrw0yUPApypmaN4L+Auv4WtE+BRJr-wkDjiAE-@domain.hid>	<4CB36116.8090507@domain.hid>	<201010112309.22031.kisda@domain.hid>
	<4CB3857C.30303@domain.hid>
In-Reply-To: <4CB3857C.30303@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF9BC234B5A07DDDF41956F65"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai and PEAK can bus card problem
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
--------------enigF9BC234B5A07DDDF41956F65
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 11.10.2010 23:45, Gilles Chanteperdrix wrote:
> Stefan Kisdaroczi wrote:
>> Am Montag 11 Oktober 2010, 21:10:14 schrieb Gilles Chanteperdrix:
>>> Peter Pastor wrote:
>>>> Hey Gilles,
>>>>
>>>> Thanks for the hint. I "fixed" this problem by loading the nvidia dr=
iver
>>>> (instead of nv) as default. Now the graphic cards uses IRQ 24 which =
does
>>>> not collide with IRQ 11 of the CAN bus card (see attached lspci.txt)=
=2E
>>>>
>>>> The only other device that uses IRQ 11 is
>>>> # 00:00.0 Host bridge [0600]: Intel Corporation 5520 I/O Hub to ESI =
Port
>>>> [8086:3406] (rev 13)
>>>>
>>>> But I guess that is ok, is it ? I checked the FAQs and went through =
the
>>>> list but I feel I can't do much. I will try a few things and disable=

>>>> everything that is unneeded. The FAQ list also suggests to enable
>>>> CONFIG_PCI_MSI which is disabled right now. What would now be a
>>>> reasonable thing to do ?
>>> Keep PCI_MSI disabled. The FAQ is wrong and should be fixed.
>>
>> Hi Gilles and Jan,
>>
>> what is wrong with PCI_MSI? In late june there was a discussion on thi=
s list=20
>> about irq-sharing [1]. Jan's statement at the end of the discussion:
>>> The better news is that modern hardware now more and more provides MS=
I,
>>> and that's an inherently unshared IRQ source.
>>
>> We consider ordering custom built pcie boards (msi) to solve the irq-s=
haring=20
>> problem i have with my pci board. Bad idea ?
>>
>> Stefan
>>
>> [1] https://mail.gna.org/public/xenomai-help/2010-06/msg00194.html
>=20
> The patch Adeos as-is does not support MSI. See the thread here:
> https://mail.gna.org/public/adeos-main/2008-08/threads.html
>=20

Provided the chipset allows fast PCI config access, this should still be
fixable. Will see if I can find some cycles for this.

Moreover, there is long-term hope: MSI-X does not suffer from that need
to interact with shared resources - for a good reasons: the old way
scales poorly.

Jan


--------------enigF9BC234B5A07DDDF41956F65
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAky0AmEACgkQitSsb3rl5xQypACgwuLeufjuwcoMRmey/LasaR7d
vHkAoMw6CIqngcjAqtVJM28Dw7CzFOIy
=c3Om
-----END PGP SIGNATURE-----

--------------enigF9BC234B5A07DDDF41956F65--

