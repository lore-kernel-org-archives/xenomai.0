Message-ID: <15523442.1168430357436.JavaMail.ngmail@domain.hid>
Date: Wed, 10 Jan 2007 12:59:17 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_30044_11252437.1168430357435"
Subject: [Xenomai-help] Xenomai Bug: rt_intr_create with NULL-name leads to
 Kernel oops in /proc/xenomai/irq
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_30044_11252437.1168430357435
Content-Type: multipart/alternative; 
	boundary="----=_Part_30043_8275978.1168430357435"

------=_Part_30043_8275978.1168430357435
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,

I am just trying out the interrupt mechanism of Xenomai.
For that, I have create a kernel module that uses rt_intr_create (from the =
native skin) to
create an IRQ handler. So far that looks fine.
However, I noticed, that I have to pass a non-NULL argument  name to rt_int=
r_create().
Otherwise, cat /proc/xenomai/irq crashes with a kernel oops.
I think this is a bug as the API documentation allows the usage of a NULL n=
ame in rt_intr_create.
Probably, the zero pointer will not be checked in the proc reading function=
.
I am using 2.6.19.1 on a Pentium 4 (UP) with Xenomai 2.3.

I have enclosed a minimum kernel module that leads to a kernel oops to see =
the effect.

Here is the kernel oops:
---------- BEGIN ----------
BUG: unable to handle kernel NULL pointer dereference at virtual address 00=
00000
0
 printing eip:
*pde =3D 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: irqtest e1000
CPU:    0
EIP:    0060:[<c0144daf>]    Not tainted VLI
EFLAGS: 00010046   (2.6.19.1 #5)
EIP is at xnintr_irq_proc+0x8c/0xcd
eax: d881a02a   ebx: d881a021   ecx: 00000580   edx: e097770c
esi: 00000000   edi: d881a02a   ebp: 00000000   esp: d9443ee4
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 2480, ti=3Dd9442000 task=3Dc15c6030 task.ti=3Dd9442000)
Stack: d881a015 0000000b 00000580 d881a02a c0261afb d881a015 d881a021 00000=
00b
       00000580 d881a000 c0145836 0000000b d881a021 00000000 d9443fa4 00000=
400
       d881a000 00000400 c01bced0 d881a000 d9443f50 00000000 00000400 d9443=
f54
Call Trace:
 [<c0261afb>] sprintf+0x2b/0x2f
 [<c0145836>] irq_read_proc+0x85/0xea
 [<c01bced0>] proc_file_read+0x11c/0x24c
 [<c0185fc7>] vfs_read+0xa0/0x170
 [<c0186407>] sys_read+0x4b/0x71
 [<c0103146>] syscall_call+0x7/0xb
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Code: 83 e5 01 c1 e1 07 8b 91 8c e5 4c c0 89 de 85 d2 74 34 be 3f 27 3e c0 =
89 df
 ac aa 84 c0 75 fa 8d 43 09 89 44 24 0c 8b 72 18 89 c7 <ac> aa 84 c0 75 fa =
8b 52
 18 31 c0 83 c9 ff 89 d7 f2 ae f7 d1 49
EIP: [<c0144daf>] xnintr_irq_proc+0x8c/0xcd SS:ESP 0068:d9443ee4
--------- END ---------------

Regards

Mathias



--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2
------=_Part_30043_8275978.1168430357435--

------=_Part_30044_11252437.1168430357435
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=irqtest.tgz

H4sIAO3SpEUAA+2V32/aMBDHeZ3/ilNHp9BRSKoCEh2TUGEdKtCJttIeJkXGMSIjONR2KqZp//vs
ODC2ov14aPuw+zzkh+/u6/M5vsTyTnOla6z0ePiG5umpvQethp+/B+7dPfqtUuA3GkHQ8FvNk5If
nBj/EviPmNOWTGkqAUoJnTIqf+fHpXqKhJ4W8jIWLMkiDm+SWGTr+jKNsoTX5m8fWBSb82ifYcGl
4ImxwEPqR7CSsdALrwJH9QehXEqR7o+0ocacSmBpxNW+aKNrPLKVtlmRHbOgOr7n1i5z0+iqdzvs
h8PBeX983fcOLj4MDypnhJi91zGDyU04GN9MwPqH6fSzsZhHiOUddCAIzogrSriiki49M1y1rlXw
rcZWxYasuUiXNA6NTzinIkq49JSWGTMmYeXhyF4r5CuxS7QhNjpTZqIii/B9d9wb9ntnuYfkOpOi
cDKzfStSE7EOXVbeVmwGntRhvggmOdXce7VZURXGt8NhFfLc9yRp1mKXU8mFnJyl2LqDvt2HNvys
DjMaJzz6JGwpNxFFvoEbMdnuylxd5hnYhgNzqmDKuYAkpRGPQGWMcaVmWZJ8cZJktwC+E8wLQO7T
OAKWcCqyVVEFyMtgfVxUkWnEE75bByvrEt2RMzz3MXw2RnTBZ2YbH3OOP/R/v/Wj/we+HQ+CZjPA
/v8UkJew+QRApzDN4iSCeL2mOmRUgGvt4M4YIeYEHTNodzanuMbc2BLsYNlbUa2yqTndhzVWPayl
1bKXh5jGYu+LdK/b4le/KVV8n+eOGyH9jzeTbnj+bti9uIbXHTge1DMl60Vzq2/+BYTMuWkw0nZY
QmiStMGpLFKjsn3cjLLKth7kRdkbdS/7FTg+h1xbSVbP/zww6pS989tJbzCpFMVRxHZm8zHZGf4x
NCwCCcmbWvtvw3Pv/7t/IQiCIAiCIAiCIAiCIAiCIAiCIAiCII7v7hefHwAoAAA=
------=_Part_30044_11252437.1168430357435--


