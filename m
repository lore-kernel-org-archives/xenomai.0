Message-ID: <451BDADC.30101@domain.hid>
Date: Thu, 28 Sep 2006 16:23:24 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Problems booting after Adeos patch
References: <451AEEED.1050708@domain.hid> <451B0978.5020108@domain.hid>
	<451BD6FC.9080205@domain.hid>
In-Reply-To: <451BD6FC.9080205@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE41BBCB91344678A71F81948"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: "J.D. Yamokoski" <yamokosk@domain.hid>
Cc: adeos-main@gna.org, Philippe Gerum <rpm@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE41BBCB91344678A71F81948
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

J.D. Yamokoski wrote:
> Jan Kiszka wrote:
>> J.D. Yamokoski wrote:
>> =20
>>> Greetings,
>>>
>>> I have recently run into some trouble trying to boot a custom confige=
d
>>> linux kernel with Adeos. During boot the system seems to have problem=
s
>>> with the SATA hard drives with messages like,
>>>
>>> ata1: slow completion (cmd ef)
>>> ATA: abnormal status 0x0FF
>>> ata1: command 0x25 timeout, stat 0x50 host-stat 0x24
>>>
>>> And then finally towards the end of the boot sequence, I get "ALERT!
>>> /dev/sda3 does not exist. Dropping to a shell!"
>>>
>>> I am using a highly modified config customized for this machine
>>> (Highlights of the config: It excludes a lot of drivers, SMP build, a=
nd
>>> both SATA-as-SCSI-driver and the regular PCI IDE driver are enabled.)=

>>> Unpatched this customized kernel works fine. And as expected, if I us=
e a
>>> more general config file (one that came with my distro) the Adeos
>>> patched kernel boots normally. Its just the combination of Adeos and
>>> customized config that seems to be the problem. Does anything jump ou=
t
>>> at anyone? I have include my config file with this email.
>>>
>>>    =20
>>
>> What I-pipe patch version are you using?
>>
>> Could you try with CONFIG_PCI_MSI disabled? There has been other repor=
ts
>> on MSI issues recently, maybe yours belong to the same group.
>>
>> Thanks,
>> Jan
>>
>>
>> PS: Unrelated to the problem but maybe still interesting: If you plan =
to
>> use Adeos/I-pipe as a real-time enabler (e.g. with Xenomai), you shoul=
d
>> switch off CONFIG_ACPI_PROCESSOR, CONFIG_CPU_FREQ, and CONFIG_APM.
>> Recent Xenomai versions should warn you about this fact as well.
>>
>>  =20
> That seems to have fixed the problem! The new kernel with this disabled=

> boots just fine. Thanks!

Well, I wouldn't say "fixed", it works around the bug.

>=20
> By the way, I was using I-pipe patch 2.6.15-i386-1.3-07.

Philippe, any news on the MSI issue?

Jan


--------------enigE41BBCB91344678A71F81948
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFG9rcniDOoMHTA+kRAqZaAJ42JR1H1eD9cUzd70zOeQgiANIjPACfQe7u
Iof6NkEAn5UyJlka5sbqdiA=
=Ftvf
-----END PGP SIGNATURE-----

--------------enigE41BBCB91344678A71F81948--

