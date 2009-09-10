Message-ID: <4AA9147A.3070205@domain.hid>
Date: Thu, 10 Sep 2009 17:00:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BB99A6BA28709744BF22A68E6D7EB51F032442FBF6@domain.hid>
	<4AA824F3.9090108@domain.hid>
	<BB99A6BA28709744BF22A68E6D7EB51F03248BD696@domain.hid>
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F03248BD696@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: Jonathan Haws <Jonathan.Haws@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Jonathan Haws wrote:
> Thu Jan  1 00:06:52 UTC 1970
> running: ./run -- -T 120 # switchtest
> *
> *
> * Type ^C to stop this application.
> *
> *
> == Testing FPU check routines...
> r0: 1 != 2
> r1: 1 != 2
> r2: 1 != 2
> r3: 1 != 2
> r4: 1 != 2
> r5: 1 != 2
> r6: 1 != 2
> r7: 1 != 2
> r8: 1 != 2
> r9: 1 != 2
> r10: 1 != 2
> r11: 1 != 2
> r12: 1 != 2
> r13: 1 != 2
> r14: 1 != 2
> r15: 1 != 2
> r16: 1 != 2
> r17: 1 != 2
> r18: 1 != 2
> r19: 1 != 2
> r20: 1 != 2
> r21: 1 != 2
> r22: 1 != 2
> r23: 1 != 2
> r24: 1 != 2
> r25: 1 != 2
> r26: 1 != 2
> r27: 1 != 2
> r28: 1 != 2
> r29: 1 != 2
> r30: 1 != 2
> r31: 1 != 2
> == FPU check routines: OK.
> == Threads: sleeper_ufps-0 rtk-1Oops: Exception in kernel mode, sig: 11 [#1]
> PREEMPT Kilauea
> Modules linked in:
> NIP: c01e876c LR: c01e86e8 CTR: c0070fb0
> REGS: cf1e5440 TRAP: 0700   Not tainted  (2.6.30.3-wolverine-dirty)
> MSR: 00029030 <EE,ME,CE,IR,DR>  CR: 40000002  XER: 0000005f
> TASK = cd412000[819] 'switchtest' THREAD: cd448000
> GPR00: 00000005 cf1e54f0 cd412000 00000000 00000005 00000001 a4500f69 00000000
> GPR08: 000011af 00000000 00000017 c0390000 20000002 00000000 00021030 c0070d8c
> GPR16: cd471208 00000000 00000000 00000000 c0394108 c0381248 003d0900 00000000
> GPR24: c02f5580 cf1e5500 cd4711d0 cd4560b8 00000006 cd471208 00000000 00000000
> NIP [c01e876c] rtswitch_ktask+0xb0/0x3e4
> LR [c01e86e8] rtswitch_ktask+0x2c/0x3e4
> Call Trace:
> Instruction dump:
> 7c0003b8 7f9c0038 7f892278 21290000 7d3c0194 7d3c4b78 4182009c 1c1703e8
> 39200000 7c002214 9001000c 91210008 <c8010008> fc200090 fc400090 fc600090
> Kernel panic - not syncing: Fatal exception in interrupt
> Call Trace:
> Rebooting in 180 seconds..

One thing I can tell for sure reading this trace is that the error is
not caused by the FPU. The error is a "program check exception".

-- 
                                          Gilles


