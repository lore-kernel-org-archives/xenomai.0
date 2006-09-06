Message-ID: <44FEDF79.6080507@domain.hid>
Date: Wed, 06 Sep 2006 16:47:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: AW: AW: [Xenomai-help] resubmission : memset of heap	crashes
	Xenomai-Task
References: <5D63919D95F87E4D9D34FF7748CE2C2A4E9D41@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A4E9D41@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF162F014F26AFDC693A24268"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF162F014F26AFDC693A24268
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Roderik_Wildenburg@domain.hid wrote:
> jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid] :
> =20
>> First of all, do we know where the demo precisely faults? In=20
>> which heap's memset? We could then analyse how this heap is=20
>> being set up in the kernel, if all mappings are done as=20
>> expected, if reasonable address are passed to the user, etc.
>>
>=20
> It crashs when the last heap is touched (please see programs output bel=
ow).

Where precisely? What address is touched? Already tried to catch the
SEGV with a debugger?

> Astonishingly it does not crash every time !? In fact I had to reboot t=
o produce this output (after running the program several times without a =
crash; don=C2=B4t ask me why) :
> =20
> Start Heap
> root_thread_init :
> timer startedt
> display task created
> root_thread_init beendet
> Available Memory 113377280 (Pagesize 4096)
> heap 0 of size 16000000 created
> Heap 0 allocated size 16000000
> heap 1 of size 16000000 created
> Heap 1 allocated size 16000000
> heap 2 of size 16000000 created
> Heap 2 allocated size 16000000
> heap 3 of size 16000000 created
> Heap 3 allocated size 16000000
> heap 4 of size 16000000 created
> Heap 4 allocated size 16000000
> heap 5 of size 16000000 created
> Heap 5 allocated size 16000000
> heap 6 of size 16000000 created
> Heap 6 allocated size 16000000
> Available Memory after allocation 4317184
> Heap 7 created with size 1505280
> Heap 7 allocated size 1505280
> Memory allocated in total : 113505280
> Setting heap 0. Size 16000000
> Setting heap 1. Size 16000000
> Setting heap 2. Size 16000000
> Setting heap 3. Size 16000000
> Setting heap 4. Size 16000000
> Setting heap 5. Size 16000000
> Setting heap 6. Size 16000000
> Setting heap 7. Size 1505280
> Segmentation fault=20
>=20
>>> I may have my hands on a 405 board on Friday, but I'm not=20
>> sure if I can do much more testing than a simple run of the=20
>> program. Of course, testing will primarily take place over=20
>> latest Xenomai...
>>
>=20
> This certainly would be helpful, especially if you could reproduce the =
problem (so I know I don=C2=B4t hunt a phantasm).
>=20
>> Roderik, you said you tested under Qemu as well? For PPC or x86 arch?
>=20
> I thought, you tested with Qemu without success (crash). But perhaps my=
 rememberence mixes something up. When I said, that the crash could not b=
e reproduced with Qemu I thought to reference your test. Isn=C2=B4t this =
correct ? =20

Ok, misunderstanding. I tried with Qemu and real x86 hardware, but only
over 2.6 so far. Will have to check with 2.4 as well because of the
over-commitment 2.6 does when requesting memory + the OOM killer
shooting the test immediately.

Jan


--------------enigF162F014F26AFDC693A24268
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE/t95niDOoMHTA+kRAgmXAJ4m0cTgOGZbigASM878f+fVEmtvkgCfZTVZ
pEkDittTKB6YI2RuLSRJp9g=
=MDRj
-----END PGP SIGNATURE-----

--------------enigF162F014F26AFDC693A24268--

