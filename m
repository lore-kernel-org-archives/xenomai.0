From: Jonathan Haws <Jonathan.Haws@domain.hid>
Date: Wed, 9 Sep 2009 15:48:43 -0600
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F032442FBF6@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai-help] Testsuite fails on 2.5-rc3
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

All,

I am trying to run Xenomai 2.5-rc3 on a 2.6.30.3 kernel from Denx on an AMC=
C 405EX CPU.  I have it all installed and ran the testsuite, but the latenc=
y, switchtest, switchbench, and cyclictest tests fail with these messages:


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

running: ./run -- -sh -T 120 -t0 # latency
*
*
* Type ^C to stop this application.
*
*
Xenomai: open: No such file or directory
Xenomai: mmap(local sem heap): No such file or directory

Thu Jan  1 00:00:20 UTC 1970
running: ./run -- -sh -T 120 -t1 # latency
*
*
* Type ^C to stop this application.
*
*
Xenomai: open: No such file or directory
Xenomai: mmap(local sem heap): No such file or directory

Thu Jan  1 00:00:21 UTC 1970
running: ./run -- -sh -T 120 -t2 # latency
*
*
* Type ^C to stop this application.
*
*
Xenomai: open: No such file or directory
Xenomai: mmap(local sem heap): No such file or directory

Thu Jan  1 00:00:22 UTC 1970
running: ./run -- -T 120 # switchtest
*
*
* Type ^C to stop this application.
*
*
Xenomai: open: No such file or directory
Xenomai: mmap(local sem heap): No such file or directory
/usr/local/xenomai/bin/xeno-test: cd: line 1: can't cd to /usr/local/xenoma=
i/share/xenomai/testsuite/switchbench

Thu Jan  1 00:00:22 UTC 1970
running: ./run -- -h # switchbench
/usr/local/xenomai/bin/xeno-test: eval: line 1: ./run: not found

Thu Jan  1 00:00:23 UTC 1970
running: ./run -- -p 10 -n -l 1000 # cyclictest
*
*
* Type ^C to stop this application.
*
*
Xenomai: open: No such file or directory
Xenomai: mmap(local sem heap): No such file or directory

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


Has anyone seen this behavior and know what my problem is?  It may just be =
a dumb configuration issue.

Note, the reason I went with the development branch instead of the stable r=
elease (2.4.9.1) is because I tried 2.4.9.1 and ran xeno-test, which crashe=
d my kernel during the FPU portion of the test.  Here is the output from th=
ere:


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Thu Jan  1 00:06:28 UTC 1970
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
TASK =3D cd459520[817] 'switchtest' THREAD: cd450000
GPR00: 00000005 cf1e54f0 cd459520 00000000 00000005 00000001 6829524c 00000=
000
GPR08: 00001164 00000000 00000017 c0390000 20000002 00000000 00021030 c0070=
d8c
GPR16: cd469208 00000000 00000000 00000000 c0394108 c0381248 003d0900 00000=
000
GPR24: c02f5580 cf1e5500 cd4691d0 cd45eb78 00000006 cd469208 00000000 00000=
000
NIP [c01e876c] rtswitch_ktask+0xb0/0x3e4
LR [c01e86e8] rtswitch_ktask+0x2c/0x3e4
Call Trace:
Instruction dump:
7c0003b8 7f9c0038 7f892278 21290000 7d3c0194 7d3c4b78 4182009c 1c1703e8
39200000 7c002214 9001000c 91210008 <c8010008> fc200090 fc400090 fc600090
---[ end trace 203da9216e563608 ]---

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


According to the website, these bugs should be fixed in 2.5-rc3.

Thanks for the help!

Jonathan




