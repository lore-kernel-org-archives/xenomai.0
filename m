From: Jonathan Haws <Jonathan.Haws@domain.hid>
Date: Thu, 10 Sep 2009 08:33:51 -0600
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F03248BD696@domain.hid>
References: <BB99A6BA28709744BF22A68E6D7EB51F032442FBF6@domain.hid>
	<4AA824F3.9090108@domain.hid>
In-Reply-To: <4AA824F3.9090108@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Testsuite fails on 2.5-rc3
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

> > All,
> >
> > I am trying to run Xenomai 2.5-rc3 on a 2.6.30.3 kernel from Denx
> on an AMCC 405EX CPU.  I have it all installed and ran the
> testsuite, but the latency, switchtest, switchbench, and cyclictest
> tests fail with these messages:
> >
> >
> >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D
> >
> > running: ./run -- -sh -T 120 -t0 # latency
> > *
> > *
> > * Type ^C to stop this application.
> > *
> > *
> > Xenomai: open: No such file or directory
> > Xenomai: mmap(local sem heap): No such file or directory
>=20
> You probably have not run make install correctly, so you are missing
> /dev/rtheap on the target.

You are right, there is no /dev/rtheap on the target.  However, I am buildi=
ng a ramdisk that uses a device table file to create all the devices in /de=
v when I create them EXT2 image.  What are the major/minor numbers for /dev=
/rtheap and how many of those devices does Xenomai need?  If I have that in=
formation, I should be able to add the device to the table.

I have used RTAI in the past and it seems like when I would insmod an RTAI =
module, it would create the necessary devices.  How does Xenomai get its de=
vices into /dev normally?

> > /usr/local/xenomai/bin/xeno-test: cd: line 1: can't cd to
> /usr/local/xenomai/share/xenomai/testsuite/switchbench
>=20
> Do you have a /usr/local/xenomai/share/xenomai/testsuite/switchbench
> on
> the target ?
>=20
> >
> > Thu Jan  1 00:00:22 UTC 1970
> > running: ./run -- -h # switchbench
> > /usr/local/xenomai/bin/xeno-test: eval: line 1: ./run: not found
>=20
> That follows from the previous error (can not cd to the directory
> where
> "run" is supposed to be found, so can not run "run" either).

Right again.  There is no switchbench on the target's testsuite.

=20
> > =3D=3D FPU check routines: OK.
> > =3D=3D Threads: sleeper_ufps-0 rtk-1Oops: Exception in kernel mode,
> sig: 11 [#1]
> > PREEMPT Kilauea
> > Modules linked in:
> > NIP: c01e876c LR: c01e86e8 CTR: c0070fb0
> > REGS: cf1e5440 TRAP: 0700   Not tainted  (2.6.30.3-wolverine-
> dirty)
> > MSR: 00029030 <EE,ME,CE,IR,DR>  CR: 40000002  XER: 0000005f
> > TASK =3D cd459520[817] 'switchtest' THREAD: cd450000
> > GPR00: 00000005 cf1e54f0 cd459520 00000000 00000005 00000001
> 6829524c 00000000
> > GPR08: 00001164 00000000 00000017 c0390000 20000002 00000000
> 00021030 c0070d8c
> > GPR16: cd469208 00000000 00000000 00000000 c0394108 c0381248
> 003d0900 00000000
> > GPR24: c02f5580 cf1e5500 cd4691d0 cd45eb78 00000006 cd469208
> 00000000 00000000
> > NIP [c01e876c] rtswitch_ktask+0xb0/0x3e4
> > LR [c01e86e8] rtswitch_ktask+0x2c/0x3e4
> > Call Trace:
> > Instruction dump:
> > 7c0003b8 7f9c0038 7f892278 21290000 7d3c0194 7d3c4b78 4182009c
> 1c1703e8
> > 39200000 7c002214 9001000c 91210008 <c8010008> fc200090 fc400090
> fc600090
> > ---[ end trace 203da9216e563608 ]---
>=20
> This is powerpc, I seem to remember that Philippe told me about this
> one, but I do not remember what was its cause.
>=20
> Could you run /proc/ipipe/version on the machine where you observe
> this?

The version returned in 2.7-00.  However, that is after I ran the 2.5-rc3 p=
atch on the kernel.  I ran prepare_kernel.sh again on my kernel source tree=
 from 2.4.9.1 to try and make sure I was using version 2.4.9.1 and my xeno-=
test ran like it did before, but with slightly different output:

Thu Jan  1 00:06:52 UTC 1970
running: ./run -- -T 120 # switchtest
*
*
* Type ^C to stop this application.
*
*
=3D=3D Testing FPU check routines...
r0: 1 !=3D 2
r1: 1 !=3D 2
r2: 1 !=3D 2
r3: 1 !=3D 2
r4: 1 !=3D 2
r5: 1 !=3D 2
r6: 1 !=3D 2
r7: 1 !=3D 2
r8: 1 !=3D 2
r9: 1 !=3D 2
r10: 1 !=3D 2
r11: 1 !=3D 2
r12: 1 !=3D 2
r13: 1 !=3D 2
r14: 1 !=3D 2
r15: 1 !=3D 2
r16: 1 !=3D 2
r17: 1 !=3D 2
r18: 1 !=3D 2
r19: 1 !=3D 2
r20: 1 !=3D 2
r21: 1 !=3D 2
r22: 1 !=3D 2
r23: 1 !=3D 2
r24: 1 !=3D 2
r25: 1 !=3D 2
r26: 1 !=3D 2
r27: 1 !=3D 2
r28: 1 !=3D 2
r29: 1 !=3D 2
r30: 1 !=3D 2
r31: 1 !=3D 2
=3D=3D FPU check routines: OK.
=3D=3D Threads: sleeper_ufps-0 rtk-1Oops: Exception in kernel mode, sig: 11=
 [#1]
PREEMPT Kilauea
Modules linked in:
NIP: c01e876c LR: c01e86e8 CTR: c0070fb0
REGS: cf1e5440 TRAP: 0700   Not tainted  (2.6.30.3-wolverine-dirty)
MSR: 00029030 <EE,ME,CE,IR,DR>  CR: 40000002  XER: 0000005f
TASK =3D cd412000[819] 'switchtest' THREAD: cd448000
GPR00: 00000005 cf1e54f0 cd412000 00000000 00000005 00000001 a4500f69 00000=
000
GPR08: 000011af 00000000 00000017 c0390000 20000002 00000000 00021030 c0070=
d8c
GPR16: cd471208 00000000 00000000 00000000 c0394108 c0381248 003d0900 00000=
000
GPR24: c02f5580 cf1e5500 cd4711d0 cd4560b8 00000006 cd471208 00000000 00000=
000
NIP [c01e876c] rtswitch_ktask+0xb0/0x3e4
LR [c01e86e8] rtswitch_ktask+0x2c/0x3e4
Call Trace:
Instruction dump:
7c0003b8 7f9c0038 7f892278 21290000 7d3c0194 7d3c4b78 4182009c 1c1703e8
39200000 7c002214 9001000c 91210008 <c8010008> fc200090 fc400090 fc600090
Kernel panic - not syncing: Fatal exception in interrupt
Call Trace:
Rebooting in 180 seconds..

Thanks,

Jonathan

