MIME-Version: 1.0
From: Jean-Michel Hautbois <jhautbois@domain.hid>
Date: Wed, 27 Apr 2011 20:42:57 +0200
Message-ID: <BANLkTi=UuSsFMmin_vGQFp3-vn=7JVT8Cg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai-core] [PowerPC]Badness at mmu_context_nohash
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi list,

I am currently using a Xenomai port on a linux 2.6.35.11 linux kernel
and the adeos-ipipe-2.6.35.7-powerpc-2.12-01.patch.
I am facing a scheduling issue on a P2020 (dual core PowerPC), and I
get the following message :

Badness at arch/powerpc/mm/mmu_context_nohash.c:209
NIP: c0018d20 LR: c039b94c CTR: c00343e4
REGS: ecfadce0 TRAP: 0700   Tainted: G        W    (2.6.35.11)
MSR: 00021000 <ME,CE>  CR: 24000488  XER: 00000000
TASK = ec5220d0[496] 'sipaq' THREAD: ecfac000 CPU: 1
GPR00: 00000001 ecfadd90 ec5220d0 ec5df340 ec58a700 00000000 ffffffff 00000003
GPR08: c04a2d98 00000007 c04a2d98 0067e000 0002f385 1007f1f8 c04a5b40 ecfac040
GPR16: c04a5b40 c04deb80 c04a2120 c04a2d98 c04a5b40 c04d008c ecfac000 00029000
GPR24: c04d0000 c04d1e6c 00000001 ec58a700 eceaf390 c04d1e78 c0b23b40 ec5df340
NIP [c0018d20] switch_mmu_context+0x80/0x438
LR [c039b94c] schedule+0x774/0x7dc
Call Trace:
[ecfadd90] [44000484] 0x44000484 (unreliable)
[ecfadde0] [c039b94c] schedule+0x774/0x7dc
[ecfade50] [c039cb98] do_nanosleep+0xc8/0x114
[ecfade80] [c0059bf8] hrtimer_nanosleep+0xd8/0x158
[ecfadf10] [c0059d48] sys_nanosleep+0xd0/0xd4
[ecfadf40] [c0013c0c] ret_from_syscall+0x0/0x3c
--- Exception: c01 at 0xffa6cc4
   LR = 0xffa6cb0
Instruction dump:
40a2fff0 4c00012c 2f800000 409e0128 813b018c 2f830000 39290001 913b018c
419e0020 8003018c 7c000034 5400d97e <0f000000> 8123018c 3929ffff 9123018c

Do you have a clue on how to start debugging it ?
It is happening quite randomly... :).

Thanks in advance !
JM

