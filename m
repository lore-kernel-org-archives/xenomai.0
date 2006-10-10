Message-ID: <452B6816.8070904@domain.hid>
Date: Tue, 10 Oct 2006 11:29:58 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200609191523.39696.andza@domain.hid>
	<200609210856.41261.andza@domain.hid>
	<451220FF.10108@domain.hid>
	<200609221106.21060.andza@domain.hid> <4513B27B.3030509@domain.hid>
	<4513BCDD.7050002@domain.hid> <20061010065701.GA14976@domain.hid>
In-Reply-To: <20061010065701.GA14976@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE1E5A0C92D960E44B74A3929"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] Re: SMP-problem with cvs-vulcano/3.4
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org
Cc: Philippe Gerum <rpm@xenomai.org>, rtai@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE1E5A0C92D960E44B74A3929
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Anders Zachrison wrote:
> Reviving an old thread of mine, in the rtai-mail-list. As suggested by
> Jan, I will also try to send it to the adeos list (if this doesn't
> succeed, could you forward it, Jan?) (And last, for possible readers on=

> the adeos-list, pleas CC-me, as I'm not following that list).
>=20
> * Jan Kiszka <jan.kiszka@domain.hid> [060922 12:37]:
>> Jan Kiszka wrote:
>>> Anders Zachrison wrote:
>>>> ...  As a short summary, as soon as I patch the 2.6.17-kernels with
>>>> the rtai-patch from vulcano-cvs (and apparently magma-cvs) the
>>>> kernel stops booting. Quite often the call-trace shows calls to
>>>> various ipipe-functions mainly setup and initialization functions.
>>>> Other times it is around a call to smp_call_function.
>=20
> A short summary for possible readers; as stated above, the computer
> stops booting as soon as the 2.6.17.x kernel is patched with either an
> adeos-ipipe patch or with the patch supplied by RTAI. It turned out the=

> the problem was MSI related (see the end of the mail).
>=20
> It is an old SMP-box with double PII-400MHz processors.=20
>=20
> The kernel config is available at
> http://hydra.ikp.liu.se/~andza/adeos_oops/config and a further
> specification of the computer (from `lspci -vv`) is found at
> http://hydra.ikp.liu.se/~andza/adeos_oops/lspci-vv.txt . The computer i=
s
> running Debian stable.
>=20
>>> Could you do the Adeos project a favour and test the vanilla Ipipe
>>> patch as well (http://download.gna.org/adeos/patches/v2.6/i386)?
>>> Please report breakages with precise version number, system
>>> description, and .config
>=20
> I've used a 2.6.17.11-kernel (same problems occurs with a 2.6.17 one)
> and I've patched it with the adeos-ipipe-2.6.17-i386-1.4-00.patch from
> (http://download.gna.org/adeos/patches/v2.6/i386).
>=20
>> ... and the oops if you can catch it (syslog, serial console, etc.).
>=20
> Three oopses are available;
> http://hydra.ikp.liu.se/~andza/adeos_oops/oops1.txt
> http://hydra.ikp.liu.se/~andza/adeos_oops/oops2.txt
> http://hydra.ikp.liu.se/~andza/adeos_oops/oops3.txt .
> (Well, they should be all or most of the boot process, as received by
> the serial console. However, at least the latter two lacks some parts o=
f
> the beginning, although the oopses at the end should be complete.)

Thanks for the oopses. They seem to point in the same direction Philippe
already guessed: IRQ migration (the Linux code screams for some spinlock
being acquired, which is probably not the case when the pipeline is activ=
e).

>=20
>>> to adeos-main@gna.org or to me (will forward then).
>>>
>>> Many thanks in advance!
>>> Jan
>>>
>=20
>> BTW, there used to be problems around MSI with I-pipe patches, though
>> my current information is that they are fixed. If you have MSI on your=

>> box, it might be worth trying to switch related kernel support off
>> (CONFIG_PCI_MSI).
>=20
> As stated in a previous reply, this was the case. Disableing the MSI in=

> the kernel config solved the problem, while disableing it in the kernel=

> boot parameter did not.
>=20
> Anders
>=20

There were some commits to Adeos CVS recently regarding
kernel/irq/migration.c [1], but the result looks unfinished to me (no
more differences to vanilla?). Philippe, is this supposed to solve the
issue?

Jan

[1]http://cvs.gna.org/cvsweb/ipipe/v2.6/2.6.17/kernel/irq/migration.c?cvs=
root=3Dadeos


--------------enigE1E5A0C92D960E44B74A3929
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFK2gWniDOoMHTA+kRArENAJ9OvcdMerdJgVS0NfsXqbmi+UsRqACePsfs
9Umaigerj5WHU5WY4WCVbq4=
=Us8i
-----END PGP SIGNATURE-----

--------------enigE1E5A0C92D960E44B74A3929--

