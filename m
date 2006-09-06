Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: AW: AW: [Xenomai-help] resubmission : memset of
	heap	crashes	Xenomai-Task
Date: Wed, 6 Sep 2006 16:07:55 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A4E9D41@domain.hid>
From: <Roderik_Wildenburg@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid, wg@domain.hid
Cc: xenomai@xenomai.org

jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid] :
=20
> First of all, do we know where the demo precisely faults? In=20
> which heap's memset? We could then analyse how this heap is=20
> being set up in the kernel, if all mappings are done as=20
> expected, if reasonable address are passed to the user, etc.
>=20

It crashs when the last heap is touched (please see programs output =
below).
Astonishingly it does not crash every time !? In fact I had to reboot to =
produce this output (after running the program several times without a =
crash; don=B4t ask me why) :
=20
Start Heap
root_thread_init :
timer startedt
display task created
root_thread_init beendet
Available Memory 113377280 (Pagesize 4096)
heap 0 of size 16000000 created
Heap 0 allocated size 16000000
heap 1 of size 16000000 created
Heap 1 allocated size 16000000
heap 2 of size 16000000 created
Heap 2 allocated size 16000000
heap 3 of size 16000000 created
Heap 3 allocated size 16000000
heap 4 of size 16000000 created
Heap 4 allocated size 16000000
heap 5 of size 16000000 created
Heap 5 allocated size 16000000
heap 6 of size 16000000 created
Heap 6 allocated size 16000000
Available Memory after allocation 4317184
Heap 7 created with size 1505280
Heap 7 allocated size 1505280
Memory allocated in total : 113505280
Setting heap 0. Size 16000000
Setting heap 1. Size 16000000
Setting heap 2. Size 16000000
Setting heap 3. Size 16000000
Setting heap 4. Size 16000000
Setting heap 5. Size 16000000
Setting heap 6. Size 16000000
Setting heap 7. Size 1505280
Segmentation fault=20

> > I may have my hands on a 405 board on Friday, but I'm not=20
> sure if I can do much more testing than a simple run of the=20
> program. Of course, testing will primarily take place over=20
> latest Xenomai...
>=20

This certainly would be helpful, especially if you could reproduce the =
problem (so I know I don=B4t hunt a phantasm).

> Roderik, you said you tested under Qemu as well? For PPC or x86 arch?

I thought, you tested with Qemu without success (crash). But perhaps my =
rememberence mixes something up. When I said, that the crash could not =
be reproduced with Qemu I thought to reference your test. Isn=B4t this =
correct ? =20

Roderik

