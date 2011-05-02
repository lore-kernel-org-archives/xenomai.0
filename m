MIME-Version: 1.0
In-Reply-To: <BANLkTi=WWysZb0kV6cuPcwS8u8mrr6ch8g@domain.hid>
References: <BANLkTi=UuSsFMmin_vGQFp3-vn=7JVT8Cg@domain.hid>
	<1303941212.1932.38.camel@domain.hid>
	<BANLkTimc7+mvdqosEw+1YGonxKYUQnrcsA@mail.gmail.com>
	<BANLkTikG9UFeR0C69oh+=umQLJN2Zva3dQ@mail.gmail.com>
	<1304066654.2845.12.camel@domain.hid>
	<BANLkTim+cY=KkurCjqUTTNt-Ocv7ZUQd6A@mail.gmail.com>
	<1304159360.1823.7.camel@domain.hid>
	<BANLkTi=WWysZb0kV6cuPcwS8u8mrr6ch8g@domain.hid>
From: Jean-Michel Hautbois <jhautbois@domain.hid>
Date: Mon, 2 May 2011 11:56:28 +0200
Message-ID: <BANLkTinkL_X8J+PzkntmUE7=oK417wBmxQ@mail.gmail.com>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

2011/5/2 Jean-Michel Hautbois <jhautbois@domain.hid>:
> 2011/4/30 Philippe Gerum <rpm@xenomai.org>:
>> On Fri, 2011-04-29 at 18:08 +0200, Jean-Michel Hautbois wrote:
>>> 2011/4/29 Philippe Gerum <rpm@xenomai.org>:
>>> > On Thu, 2011-04-28 at 10:33 +0200, Jean-Michel Hautbois wrote:
>>> >> 2011/4/27 Philippe Gerum <rpm@xenomai.org>:
>>> >> > On Wed, 2011-04-27 at 20:42 +0200, Jean-Michel Hautbois wrote:
>>> >> >> Hi list,
>>> >> >>
>>> >> >> I am currently using a Xenomai port on a linux 2.6.35.11 linux ke=
rnel
>>> >> >> and the adeos-ipipe-2.6.35.7-powerpc-2.12-01.patch.
>>> >> >> I am facing a scheduling issue on a P2020 (dual core PowerPC), an=
d I
>>> >> >> get the following message :
>>> >> >>
>>> >> >> Badness at arch/powerpc/mm/mmu_context_nohash.c:209
>>> >> >> NIP: c0018d20 LR: c039b94c CTR: c00343e4
>>> >> >> REGS: ecfadce0 TRAP: 0700 =C2=A0 Tainted: G =C2=A0 =C2=A0 =C2=A0 =
=C2=A0W =C2=A0 =C2=A0(2.6.35.11)
>>> >> >> MSR: 00021000 <ME,CE> =C2=A0CR: 24000488 =C2=A0XER: 00000000
>>> >> >> TASK =3D ec5220d0[496] 'sipaq' THREAD: ecfac000 CPU: 1
>>> >> >> GPR00: 00000001 ecfadd90 ec5220d0 ec5df340 ec58a700 00000000 ffff=
ffff 00000003
>>> >> >> GPR08: c04a2d98 00000007 c04a2d98 0067e000 0002f385 1007f1f8 c04a=
5b40 ecfac040
>>> >> >> GPR16: c04a5b40 c04deb80 c04a2120 c04a2d98 c04a5b40 c04d008c ecfa=
c000 00029000
>>> >> >> GPR24: c04d0000 c04d1e6c 00000001 ec58a700 eceaf390 c04d1e78 c0b2=
3b40 ec5df340
>>> >> >> NIP [c0018d20] switch_mmu_context+0x80/0x438
>>> >> >> LR [c039b94c] schedule+0x774/0x7dc
>>> >> >> Call Trace:
>>> >> >> [ecfadd90] [44000484] 0x44000484 (unreliable)
>>> >> >> [ecfadde0] [c039b94c] schedule+0x774/0x7dc
>>> >> >> [ecfade50] [c039cb98] do_nanosleep+0xc8/0x114
>>> >> >> [ecfade80] [c0059bf8] hrtimer_nanosleep+0xd8/0x158
>>> >> >> [ecfadf10] [c0059d48] sys_nanosleep+0xd0/0xd4
>>> >> >> [ecfadf40] [c0013c0c] ret_from_syscall+0x0/0x3c
>>> >> >> --- Exception: c01 at 0xffa6cc4
>>> >> >> =C2=A0 =C2=A0LR =3D 0xffa6cb0
>>> >> >> Instruction dump:
>>> >> >> 40a2fff0 4c00012c 2f800000 409e0128 813b018c 2f830000 39290001 91=
3b018c
>>> >> >> 419e0020 8003018c 7c000034 5400d97e <0f000000> 8123018c 3929ffff =
9123018c
>>> >> >>
>>> >> >> Do you have a clue on how to start debugging it ?
>>> >> >
>>> >> > Yes, but that can't be easily summarized here. In short, we have a
>>> >> > serious problem with the sharing of the MMU context between the Li=
nux
>>> >> > and Xenomai schedulers in the SMP case on powerpc.
>>> >>
>>> >> OK, good to know that it is a known issue. If there is a thread with
>>> >> some thoughts about it, I am interested ;).
>>> >>
>>> >> >> It is happening quite randomly... :).
>>> >> >
>>> >> > Does disabling CONFIG_XENO_HW_UNLOCKED_SWITCH clear this issue?
>>> >> >
>>> >>
>>> >> Well, yes and no. It starts well, but when booting the kernel I get =
:
>>> >
>>> >
>>> > The mm switch issue was specifically addressed by this patch, which i=
s
>>> > part of 2.12-01:
>>> > http://git.denx.de/?p=3Dipipe-2.6.git;a=3Dcommit;h=3Dc14a47630d62d032=
8de1957636dceb1d498f7048
>>> >
>>> > However, it the last 2.6.35 patch issued was based on 2.6.35.7, not
>>> > 2.6.35.11, so there is still the possibility that something went wron=
g
>>> > while you forward ported this code.
>>> >
>>> > - Please check that mmu_context_nohash.c does contain the fix above a=
s
>>> > it should
>>>
>>> It is ok, I have the fix.
>>
>> Does 2.6.35.7-2.12-02 exhibit the issue as well?
>
> It doesn't seem to exhibit the issue... I didn't try during a long
> time though...
>
>>>
>>> > - Please try Richard's suggestion, i.e. moving to 2.6.36, which may g=
ive
>>> > us more hints.
>>>
>>> It is better. I don't have the badness on mmu context anymore.
>>> This gives some hints ;).
>>>
>>
>> Yes and no. The mmu management code involved was untouched between
>> 2.6.35 and 2.6.36, so I still don't get why this activity counter gets
>> trashed yet.
>>
>>> >> Badness at kernel/lockdep.c:2327
>>> >> NIP: c006e554 LR: c006e53c CTR: 000186a0
>>> >
>>> > Adeos sometimes conflicts with the vanilla IRQ state tracer. I'll hav=
e a
>>> > look at this. Disable CONFIG_TRACE_IRQFLAGS.
>>>
>>> Yes, but I *want* to have the CONFIG_TRACE_IRQFLAGS on. I just wanted
>>> to tell that I had the problem, in order to be sure it is known ;).
>>>
>>
>> Sure, but one issue at a time.
>>
>>> JM
>>
>> --
>> Philippe.
>>

OK, the badness disappears, but the 2.6.36 kernel seems more stable
than 2.6.35 with this patch.

