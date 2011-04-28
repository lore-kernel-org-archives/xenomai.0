MIME-Version: 1.0
In-Reply-To: <BANLkTimc7+mvdqosEw+1YGonxKYUQnrcsA@mail.gmail.com>
References: <BANLkTi=UuSsFMmin_vGQFp3-vn=7JVT8Cg@domain.hid>
	<1303941212.1932.38.camel@domain.hid>
	<BANLkTimc7+mvdqosEw+1YGonxKYUQnrcsA@mail.gmail.com>
From: Jean-Michel Hautbois <jhautbois@domain.hid>
Date: Thu, 28 Apr 2011 10:33:55 +0200
Message-ID: <BANLkTikG9UFeR0C69oh+=umQLJN2Zva3dQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] [PowerPC]Badness at mmu_context_nohash
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

2011/4/27 Philippe Gerum <rpm@xenomai.org>:
> On Wed, 2011-04-27 at 20:42 +0200, Jean-Michel Hautbois wrote:
>> Hi list,
>>
>> I am currently using a Xenomai port on a linux 2.6.35.11 linux kernel
>> and the adeos-ipipe-2.6.35.7-powerpc-2.12-01.patch.
>> I am facing a scheduling issue on a P2020 (dual core PowerPC), and I
>> get the following message :
>>
>> Badness at arch/powerpc/mm/mmu_context_nohash.c:209
>> NIP: c0018d20 LR: c039b94c CTR: c00343e4
>> REGS: ecfadce0 TRAP: 0700 =C2=A0 Tainted: G =C2=A0 =C2=A0 =C2=A0 =C2=A0W=
 =C2=A0 =C2=A0(2.6.35.11)
>> MSR: 00021000 <ME,CE> =C2=A0CR: 24000488 =C2=A0XER: 00000000
>> TASK =3D ec5220d0[496] 'sipaq' THREAD: ecfac000 CPU: 1
>> GPR00: 00000001 ecfadd90 ec5220d0 ec5df340 ec58a700 00000000 ffffffff 00=
000003
>> GPR08: c04a2d98 00000007 c04a2d98 0067e000 0002f385 1007f1f8 c04a5b40 ec=
fac040
>> GPR16: c04a5b40 c04deb80 c04a2120 c04a2d98 c04a5b40 c04d008c ecfac000 00=
029000
>> GPR24: c04d0000 c04d1e6c 00000001 ec58a700 eceaf390 c04d1e78 c0b23b40 ec=
5df340
>> NIP [c0018d20] switch_mmu_context+0x80/0x438
>> LR [c039b94c] schedule+0x774/0x7dc
>> Call Trace:
>> [ecfadd90] [44000484] 0x44000484 (unreliable)
>> [ecfadde0] [c039b94c] schedule+0x774/0x7dc
>> [ecfade50] [c039cb98] do_nanosleep+0xc8/0x114
>> [ecfade80] [c0059bf8] hrtimer_nanosleep+0xd8/0x158
>> [ecfadf10] [c0059d48] sys_nanosleep+0xd0/0xd4
>> [ecfadf40] [c0013c0c] ret_from_syscall+0x0/0x3c
>> --- Exception: c01 at 0xffa6cc4
>> =C2=A0 =C2=A0LR =3D 0xffa6cb0
>> Instruction dump:
>> 40a2fff0 4c00012c 2f800000 409e0128 813b018c 2f830000 39290001 913b018c
>> 419e0020 8003018c 7c000034 5400d97e <0f000000> 8123018c 3929ffff 9123018=
c
>>
>> Do you have a clue on how to start debugging it ?
>
> Yes, but that can't be easily summarized here. In short, we have a
> serious problem with the sharing of the MMU context between the Linux
> and Xenomai schedulers in the SMP case on powerpc.

OK, good to know that it is a known issue. If there is a thread with
some thoughts about it, I am interested ;).

>> It is happening quite randomly... :).
>
> Does disabling CONFIG_XENO_HW_UNLOCKED_SWITCH clear this issue?
>

Well, yes and no. It starts well, but when booting the kernel I get :

Badness at kernel/lockdep.c:2327
NIP: c006e554 LR: c006e53c CTR: 000186a0
REGS: effe9e00 TRAP: 0700 =C2=A0 Not tainted =C2=A0(2.6.35.11)
MSR: 00021000 <ME,CE> =C2=A0CR: 24242022 =C2=A0XER: 00000000
TASK =3D c0508398[0] 'swapper' THREAD: c052e000 CPU: 0
GPR00: 00000000 effe9eb0 c0508398 00000001 80021000 ea000050 00000060 00000=
003
GPR08: c0501e80 c0530000 c0510000 00000001 44242028 100488d8 3ff91200 00000=
000
GPR16: 00000000 3ff85950 3ff85950 3ffb1254 c0a446e0 c0a44700 c0530000 c0a44=
704
GPR24: c0537084 00000010 00000000 c0539838 80029000 c001444c c0530000 c0508=
398
NIP [c006e554] trace_hardirqs_on_caller+0x148/0x18c
LR [c006e53c] trace_hardirqs_on_caller+0x130/0x18c
Call Trace:
[effe9eb0] [c006e50c] trace_hardirqs_on_caller+0x100/0x18c (unreliable)
[effe9ed0] [c001444c] restore+0x10/0x64
[effe9f90] [00000010] 0x10
[effe9fb0] [c001c568] mpic_unmask_irq+0x84/0xb8
[effe9fd0] [c00816f4] handle_fasteoi_irq+0xe4/0x138
[effe9ff0] [c0013628] call_handle_irq+0x18/0x28
[c052fdc0] [c0004fe0] handle_one_irq+0x94/0x100
[c052fde0] [c000b120] __ipipe_do_IRQ+0x78/0xa8
[c052fe10] [c0085234] __ipipe_sync_stage+0x1b0/0x33c
[c052fe50] [c000a404] __ipipe_handle_irq+0x20c/0x260
[c052fe90] [c000a614] __ipipe_grab_irq+0x4c/0x188
[c052fec0] [c0014a60] __ipipe_ret_from_except+0x0/0xc
[c052ff80] [c0009224] cpu_idle+0x64/0xe0
[c052ffa0] [c000234c] rest_init+0xd0/0xe4
[c052ffc0] [c04c9ae0] start_kernel+0x2b0/0x348
[c052fff0] [c00003c4] skpinv+0x2dc/0x318
Instruction dump:
2f800000 409eff5c 800205d8 2f800000 419eff50 481b8281 2f830000 41beff00
3d20c053 8009732c 2f800000 40befef0 <0fe00000> 4bfffee8 7fe3fb78 38800001

And after starting my applications, it gets really bad :

Badness at arch/powerpc/mm/mmu_context_nohash.c:209
NIP: c0017958 LR: c039f560 CTR: c00347f8
REGS: ed38bdd0 TRAP: 0700 =C2=A0 Tainted: G =C2=A0 =C2=A0 =C2=A0 =C2=A0W =
=C2=A0 =C2=A0(2.6.35.11)
MSR: 00021000 <ME,CE> =C2=A0CR: 24000828 =C2=A0XER: 00000000
TASK =3D ecb2c260[405] 'ethctl' THREAD: ed38a000 CPU: 1
GPR00: 00000001 ed38be80 ecb2c260 ec70f200 ec89a200 00000025 c161ccc0 00000=
003
GPR08: ec7fb000 00000001 ec89a3c0 c0520000 0002a106 101110d0 c04e9cc0 c04e9=
cc0
GPR16: c04e9cc0 c04e9cc0 c04e92e0 c04e9cc0 ed38a000 c051b084 c051b084 c04e9=
cc0
GPR24: ecb2c4d0 c0519b2c 00000001 c04e92e0 c161ccc0 ecb2c260 ec89a200 ec70f=
200
NIP [c0017958] switch_mmu_context+0x54/0x3d8
LR [c039f560] schedule+0x780/0x824
Call Trace:
[ed38be80] [24000822] 0x24000822 (unreliable)
[ed38bed0] [c039f560] schedule+0x780/0x824
[ed38bf40] [c00133c0] recheck+0x0/0x24
Instruction dump:
7f49b02e 7c0000a6 54008ffe 0f000000 812401c8 2f830000 39290001 912401c8
419e0020 800301c8 7c000034 5400d97e <0f000000> 812301c8 3929ffff 912301c8
------------[ cut here ]------------
Badness at arch/powerpc/mm/mmu_context_nohash.c:209
NIP: c0017958 LR: c039f560 CTR: c0034a20
REGS: ed38bdd0 TRAP: 0700 =C2=A0 Tainted: G =C2=A0 =C2=A0 =C2=A0 =C2=A0W =
=C2=A0 =C2=A0(2.6.35.11)
MSR: 00021000 <ME,CE> =C2=A0CR: 24000888 =C2=A0XER: 00000000
TASK =3D ecb2c260[405] 'ethctl' THREAD: ed38a000 CPU: 1
GPR00: 00000001 ed38be80 ecb2c260 ec70f200 ec70e600 00000025 c161ccc0 00000=
003
GPR08: ec7f6000 00000001 ec70e7c0 c0520000 0002a134 101110d0 c04e9cc0 c04e9=
cc0
GPR16: c04e9cc0 c04e9cc0 c04e92e0 c04e9cc0 ed38a000 c051b084 c051b084 c04e9=
cc0
GPR24: ecb2c4d0 c0519b2c 00000001 c04e92e0 c161ccc0 ecb2c260 ec70e600 ec70f=
200
NIP [c0017958] switch_mmu_context+0x54/0x3d8
LR [c039f560] schedule+0x780/0x824
Call Trace:
[ed38be80] [c020984c] plist_check_list+0x24/0x60 (unreliable)
[ed38bed0] [c039f560] schedule+0x780/0x824
[ed38bf40] [c00133c0] recheck+0x0/0x24
--- Exception: c01 at 0xfdcfa28
=C2=A0 =C2=A0LR =3D 0xfdcfa14
Instruction dump:
7f49b02e 7c0000a6 54008ffe 0f000000 812401c8 2f830000 39290001 912401c8
419e0020 800301c8 7c000034 5400d97e <0f000000> 812301c8 3929ffff 912301c8
------------[ cut here ]------------
Badness at arch/powerpc/mm/mmu_context_nohash.c:209
NIP: c0017958 LR: c039f560 CTR: c002808c
REGS: ec051e30 TRAP: 0700 =C2=A0 Tainted: G =C2=A0 =C2=A0 =C2=A0 =C2=A0W =
=C2=A0 =C2=A0(2.6.35.11)
MSR: 00021000 <ME,CE> =C2=A0CR: 24000028 =C2=A0XER: 00000000
TASK =3D ec041620[0] 'swapper' THREAD: ec050000 CPU: 1
GPR00: 00000001 ec051ee0 ec041620 ec70f200 ec70ec00 00000025 c161ccc0 00000=
003
GPR08: ec9d1000 00000001 ec70edc0 c0520000 0002a13b 00000000 c04e9cc0 c04e9=
cc0
GPR16: c04e9cc0 c04e9cc0 c04e92e0 c04e9cc0 ec050000 c051b084 c051b084 c04e9=
cc0
GPR24: ec041890 c0519b2c 00000001 c04e92e0 c161ccc0 ec041620 ec70ec00 ec70f=
200
NIP [c0017958] switch_mmu_context+0x54/0x3d8
LR [c039f560] schedule+0x780/0x824
Call Trace:
[ec051ee0] [24000022] 0x24000022 (unreliable)
[ec051f30] [c039f560] schedule+0x780/0x824
[ec051fa0] [c0008b40] cpu_idle+0xd0/0xe0
[ec051fc0] [c04d1cbc] start_secondary+0x2a4/0x364
[ec051ff0] [c0001ca0] __secondary_start+0x30/0x84
Instruction dump:
7f49b02e 7c0000a6 54008ffe 0f000000 812401c8 2f830000 39290001 nstruction d=
ump:
7f49b02e 7c0000a6 54008ffe 0f000000 812401c8 2f830000 39290001 912401c8
419e0020 800301c8 7c000034 5400d97e <0f000000> 812301c8 3929ffff 912301c8
------------[ cut here ]------------
Badness at arch/powerpc/mm/mmu_context_nohash.c:209
NIP: c0017958 LR: c039f560 CTR: c0034a20
REGS: ec051e30 TRAP: 0700 =C2=A0 Tainted: G =C2=A0 =C2=A0 =C2=A0 =C2=A0W =
=C2=A0 =C2=A0(2.6.35.11)
MSR: 00021000 <ME,CE> =C2=A0CR: 24000028 =C2=A0XER: 00000000
TASK =3D ec041620[0] 'swapper' THREAD: ec050000 CPU: 1
GPR00: 00000001 ec051ee0 ec041620 ec70f200 ec70e600 00000025 c161ccc0 00000=
003
GPR08: ec7f6000 00000001 ec70e7c0 c0520000 0002a40f 00000000 c04e9cc0 c04e9=
cc0
GPR16: c04e9cc0 c04e9cc0 c04e92e0 c04e9cc0 ec050000 c051b084 c051b084 c04e9=
cc0
GPR24: ec041890 c0519b2c 00000001 c04e92e0 c161ccc0 ec041620 ec70e600 ec70f=
200
NIP [c0017958] switch_mmu_context+0x54/0x3d8
LR [c039f560] schedule+0x780/0x824
Call Trace:
[ec051ee0] [c020984c] plist_check_list+0x24/0x60 (unreliable)
[ec051f30] [c039f560] schedule+0x780/0x824
[ec051fa0] [c0008b40] cpu_idle+0xd0/0xe0
[ec051fc0] [c04d1cbc] start_secondary+0x2a4/0x364
[ec051ff0] [c0001ca0] __secondary_start+0x30/0x84
Instruction dump:
7f49b02e 7c0000a6 54008ffe 0f000000 812401c8 2f830000 39290001 912401c8
419e0020 800301c8 7c000034 5400d97e <0f000000> 812301c8 3929ffff 912301c8


And it continues, again and again, only a reset can stop it :).

JM

