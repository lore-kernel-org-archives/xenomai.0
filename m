Message-ID: <4396DA95.5060001@domain.hid>
Date: Wed, 07 Dec 2005 13:50:29 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [bug] don't try this at home...
References: <438DD4E2.9080208@domain.hid>
	<438DE166.5090303@domain.hid>
	<438DE551.7080708@domain.hid>
In-Reply-To: <438DE551.7080708@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDEA687A7AE555ACE9E96A6FF"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDEA687A7AE555ACE9E96A6FF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Jan Kiszka wrote:
>>
>>> Hi Philippe,
>>>
>>> I'm afraid this one is serious: let the attached migration stress tes=
t
>>> run on likely any Xenomai since 2.0, preferably with
>>> CONFIG_XENO_OPT_DEBUG on. Will give a nice crash sooner or later (I'm=

>>> trying to set up a serial console now).
>>>
>=20
> Confirmed here. My test box went through some nifty triple salto out of=

> the window running this frag for 2mn or so. Actually, the semop
> handshake is not even needed to cause the crash. At first sight, it
> looks like a migration issue taking place during the critical phase whe=
n
> a shadow thread switches back to Linux to terminate.
>=20
>>
>>
>> As it took some time to persuade my box to not just reboot but to give=
 a
>> message, I'm posting here the kernel dump of the P-III running
>> nat_migration:
>>
>> [...]
>> Xenomai: starting native API services.
>> ce649fb4 ce648000 00000b17 00000202 c0139246 cdf2819c cdf28070 0b12d31=
0
>>        00000037 ce648000 00000000 c02f0700 00009a28 00000000 b7e94a70
>> bfed63c8
>>        00000000 ce648000 c0102fcb b7e94a70 bfed63dc b7faf4b0 bfed63c8
>> 00000000
>> Call Trace:
>>  [<c0139246>] __ipipe_dispatch_event+0x96/0x130
>>  [<c0102fcb>] work_resched+0x6/0x1c
>> Xenomai: fatal: blocked thread migration[22175] rescheduled?!
>> (status=3D0x300010, sig=3D0, prev=3Dwatchdog/0[3])
>=20
> This babe is awaken by Linux while Xeno sees it in a dormant state,
> likely after it has terminated. No wonder why things are going wild
> after that... Ok, job queued. Thanks.
>=20

I think I can explain this warning now: This happens during creation of
a new userspace real-time thread. In the context of the newly created
Linux pthread that is to become a real-time thread, Xenomai first sets
up the real-time part and then calls xnshadow_map. The latter function
does further init and then signals via xnshadow_signal_completion to the
parent Linux thread (the caller of rt_task_create e.g.) that the thread
is up. This happens before xnshadow_harden, i.e. still in preemptible
linux context.

The signalling should normally do not cause a reschedule as the caller -
the to-be-mapped linux pthread - has higher prio than the woken up
thread. And Xenomai implicitly assumes with this fatal-test above that
there is no preemption! But it can happen: the watchdog thread of linux
does preempt here. So, I think it's a false positive.

I disabled this particular warning and came a bit further:

I-pipe: Domain Xenomai registered.
Xenomai: hal/x86 started.
Xenomai: real-time nucleus v2.1 (Surfing With The Alien) loaded.
Xenomai: starting native API services.
Unable to handle kernel paging request at virtual address 75c08732
 printing eip:
d0acec80
*pde =3D 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: xeno_native xeno_nucleus eepro100 mii
CPU:    0
EIP:    0060:[<d0acec80>]    Not tainted VLI
EFLAGS: 00010086   (2.6.14.3)
EIP is at xnpod_schedule+0x790/0xcf0 [xeno_nucleus]
eax: 8005003b   ebx: d09c1a60   ecx: 75c08500   edx: d0ae441c
esi: d0ae4210   edi: ceab1f28   ebp: ceab1f28   esp: ceab1ef4
ds: 007b   es: 007b   ss: 0068
I-pipe domain Xenomai
Stack: 00000096 00000001 c039cce0 0000000e ceab1f28 00000002 ceab1f20
c010e080
       00000000 cee1ba90 0000000e 00000004 c0103224 00000000 cee00000
cee1ba90
       cee1ba90 ce86f700 00000004 cee1b570 0000007b cee1007b ffffffff
c028450c
Call Trace:
 [<c0103606>] show_stack+0x86/0xc0
 [<c01037a4>] show_registers+0x144/0x200
 [<c01039c7>] die+0xd7/0x1e0
 [<c0286994>] do_page_fault+0x1e4/0x667
 [<c010e094>] __ipipe_handle_exception+0x34/0x80
 [<c0103224>] error_code+0x54/0x70
 [<cee00000>] 0xcee00000
Code: b8 05 e4 01 00 00 39 82 18 02 00 00 74 68 0f 20 c0 83 c8 08 0f 22
c0 8b 4d e8 8b 7d c4 85 ff 8b 49 04 89 4d b8
0f 84 37 fa ff ff <f6> 81 32 02 00 00 40 0f 84 2a fa ff ff b8 00 e0 ff
ff 21 e0 8b
scheduling while atomic: migration/0x00000002/17646
 [<c0103655>] dump_stack+0x15/0x20
 [<c02847fb>] schedule+0x63b/0x720
 [<d0ad6573>] xnshadow_harden+0x83/0x140 [xeno_nucleus]
 [<d0ad6d7a>] xnshadow_wait_barrier+0x7a/0x130 [xeno_nucleus]
 [<d0ad7287>] exec_nucleus_syscall+0x77/0xa0 [xeno_nucleus]
 [<d0ad7769>] losyscall_event+0x139/0x1a0 [xeno_nucleus]
 [<c0139296>] __ipipe_dispatch_event+0x96/0x130
 [<c010dfb7>] __ipipe_syscall_root+0x27/0xc0
 [<c0102e82>] sysenter_past_esp+0x3b/0x67
Xenomai: Switching migration to secondary mode after exception #14 from
user-space at 0xc028450c (pid 17646)
 <3>Debug: sleeping function called from invalid context at
include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():0
 [<c0103655>] dump_stack+0x15/0x20
 [<c01120b8>] __might_sleep+0x88/0xb0
 [<c01315ad>] futex_wait+0xed/0x2f0
 [<c0131a35>] do_futex+0x45/0x80
 [<c0131ab0>] sys_futex+0x40/0x110
 [<c0102f28>] syscall_call+0x7/0xb


Still problems ahead. I got the impression that the migration path is
not yet well reviewed. :(

Any further ideas welcome!

Jan


PS: Tests performed with splhigh/splexit removed from __rt_task_create
(and splnone from gatekeeper_thread) as Philippe privately acknowledged
to be ok. This removes some critical latency source.


--------------enigDEA687A7AE555ACE9E96A6FF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDltqVncNeS9Q0k+IRAtEtAKC1X0uZenCahYZOIEKauuH2Jca08wCfVmqX
nzyhFXamM3vNGGrjIDSeHCk=
=wreu
-----END PGP SIGNATURE-----

--------------enigDEA687A7AE555ACE9E96A6FF--

