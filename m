Message-ID: <46FF8BB9.9080207@domain.hid>
Date: Sun, 30 Sep 2007 13:42:49 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46F9167F.20008@domain.hid> <1190756271.26427.0.camel@domain.hid>	
	<46FA26ED.4070505@domain.hid> <46FF78DF.7090104@domain.hid>
	<1191149545.5989.7.camel@domain.hid> <46FF81BA.1020506@domain.hid>
In-Reply-To: <46FF81BA.1020506@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCA14AD0911E4ED3434ED9A34"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] crashing 2.6.22 (was: [Xenomai-help] Non-APIC setup
	broken for 2.4-SVN?)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCA14AD0911E4ED3434ED9A34
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> On Sun, 2007-09-30 at 12:22 +0200, Jan Kiszka wrote:
=2E..
>>>  And a third
>>> one only gives me "Detected illicit call from domain Xenomai" before =
the
>>> box reboots. :(
>> Grmff... Do you run with your smp_processor_id() instrumentation in?
>=20
> Yes, but I suspect this is just a symptom of some severe memory
> corruption that (also?) hits I-pipe data structures. I just put in some=

> different instrumentation, and that warning is gone, the box just hangs=

> hard at a different point. Very unfriendly.

Hah! Got some crash log by hacking a raw printk-to-uart:

[...]
<6>Xenomai: starting RTDM services.
<6>NET: Registered protocol family 10
<6>lo: Disabled Privacy Extensions
<6>ADDRCONF(NETDEV_UP): eth0: link is not ready
<3>I-pipe: Detected illicit call from domain 'Xenomai'
<3>        into a service reserved for domain 'Linux' and below.
       f3a6bc18 00000000 00000000 c05dad6c f3a6bc3c c0105fc3 c03513c7 c05=
dc100
       00000009 f3a6bc54 c01479cb c03592f8 c0357ae2 c035e069 f3a6bc88 f3a=
6bc70
       c0127224 c0111df8 00000000 f3a6bd74 00000000 f3a6bd74 f3a6bc80 c01=
2727f
Call Trace:
 [<c010520f>] show_trace_log_lvl+0x1f/0x40
 [<c01052e1>] show_stack_log_lvl+0xb1/0xe0
 [<c0105fc3>] show_stack+0x33/0x40
 [<c01479cb>] ipipe_check_context+0x7b/0x90
 [<c0127224>] __atomic_notifier_call_chain+0x24/0x60
 [<c012727f>] atomic_notifier_call_chain+0x1f/0x30
 [<c0131e02>] notify_die+0x32/0x40
 [<c0105d29>] do_invalid_op+0x59/0xa0
 [<c0111d0b>] __ipipe_handle_exception+0x7b/0x144
 [<c02dfaeb>] error_code+0x6f/0x7c
 [<c0111d13>] __ipipe_handle_exception+0x83/0x144
 [<c02dfaeb>] error_code+0x6f/0x7c
 [<c01117df>] __ipipe_handle_irq+0x4f/0x140
 [<c0104c5e>] ipipe_ipi3+0x26/0x40
 [<c0111df8>] mcount+0x24/0x29
 [<c0115c49>] kunmap_atomic+0x9/0x60
 [<c015a040>] __handle_mm_fault+0x210/0x910
 [<c0114dac>] do_page_fault+0x1dc/0x5f0
 [<c0111d0b>] __ipipe_handle_exception+0x7b/0x144
 [<c02dfaeb>] error_code+0x6f/0x7c
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
I-pipe tracer log (30 points):
    #*func                    0 ipipe_trace_panic_freeze+0x8 (ipipe_check=
_context+0x40)
    #*func                    0 ipipe_check_context+0xc (__atomic_notifie=
r_call_chain+0x24)
    #*func                    0 __atomic_notifier_call_chain+0x14 (atomic=
_notifier_call_chain+0x1f)
    #*func                    0 atomic_notifier_call_chain+0xb (notify_di=
e+0x32)
    #*func                    0 notify_die+0xb (do_invalid_op+0x59)
    #*func                    0 do_invalid_op+0x10 (__ipipe_handle_except=
ion+0x7b)
    #*func                   -1 __ipipe_handle_exception+0xe (error_code+=
0x6f)
    #*func                   -1 __ipipe_restore_root+0x8 (__ipipe_handle_=
exception+0x83)
 |  #*func                   -2 do_page_fault+0xe (__ipipe_handle_excepti=
on+0x7b)
 |  # func                   -2 __ipipe_handle_exception+0xe (error_code+=
0x6f)
 |   +func                   -3 __ipipe_dispatch_wired+0x16 (__ipipe_hand=
le_irq+0x4f)
 |   +func                   -3 __ipipe_ack_apic+0x8 (__ipipe_handle_irq+=
0x8f)
 |   +func                   -3 __ipipe_handle_irq+0x14 (ipipe_ipi3+0x26)=

     +func                   -3 kunmap_atomic+0x9 (__handle_mm_fault+0x21=
0)
     +func                   -3 ipipe_check_context+0xc (__handle_mm_faul=
t+0x204)
     +func                   -4 page_add_file_rmap+0x8 (__handle_mm_fault=
+0x586)
     +func                   -4 ipipe_check_context+0xc (__handle_mm_faul=
t+0x196)
     +func                   -4 kmap_atomic_prot+0xb (kmap_atomic+0x13)
     +func                   -4 kmap_atomic+0x8 (__handle_mm_fault+0x186)=

     +func                   -4 mark_page_accessed+0x9 (filemap_nopage+0x=
13c)
     +func                   -4 ipipe_check_context+0xc (find_get_page+0x=
65)
     #func                   -4 __ipipe_unstall_root+0x8 (find_get_page+0=
x5b)
     #func                   -4 radix_tree_lookup+0x16 (find_get_page+0x3=
6)
     #func                   -4 ipipe_check_context+0xc (find_get_page+0x=
2d)
     +func                   -5 ipipe_check_context+0xc (find_get_page+0x=
18)
     +func                   -5 find_get_page+0xa (filemap_nopage+0x1de)
     +func                   -5 filemap_nopage+0xe (__handle_mm_fault+0x1=
1f)
     +func                   -5 ipipe_check_context+0xc (kunmap_atomic+0x=
50)
     +func                   -5 kunmap_atomic+0x9 (__handle_mm_fault+0xcc=
)
     +func                   -5 kmap_atomic_prot+0xb (kmap_atomic+0x13)
<0>PANIC: double fault, gdt at c0392000 [255 bytes]
<0>double fault, tss at c038d7e0
<0>eip =3D c0127266, esp =3D dfec1ff8
<0>eax =3D c05dad6c, ebx =3D dfec20f4, ecx =3D dfec2008, edx =3D 00000009=

<0>esi =3D 00000000, edi =3D dfec20f4

Double fault, explains why it is so slippery... And the crash looks a
bit like that backtrace I once posted for an earlier ipipe version.

Time for a break, will dig deeper later - now that I have the tools :)

Jan


--------------enigCA14AD0911E4ED3434ED9A34
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFG/4u5niDOoMHTA+kRAkDkAJ944wd8SAlconwgLwTwOVutkeDgoACeLTW+
/a44aW13OWH8hmqH8Ewex+w=
=T4LQ
-----END PGP SIGNATURE-----

--------------enigCA14AD0911E4ED3434ED9A34--

