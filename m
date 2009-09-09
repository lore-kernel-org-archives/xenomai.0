Message-ID: <4AA824F3.9090108@domain.hid>
Date: Wed, 09 Sep 2009 23:58:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BB99A6BA28709744BF22A68E6D7EB51F032442FBF6@domain.hid>
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F032442FBF6@domain.hid>
Content-Type: text/plain; charset=UTF-8
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
> All,
> 
> I am trying to run Xenomai 2.5-rc3 on a 2.6.30.3 kernel from Denx on an AMCC 405EX CPU.  I have it all installed and ran the testsuite, but the latency, switchtest, switchbench, and cyclictest tests fail with these messages:
> 
> 
> =====================================================================
> 
> running: ./run -- -sh -T 120 -t0 # latency
> *
> *
> * Type ^C to stop this application.
> *
> *
> Xenomai: open: No such file or directory
> Xenomai: mmap(local sem heap): No such file or directory

You probably have not run make install correctly, so you are missing
/dev/rtheap on the target.


> /usr/local/xenomai/bin/xeno-test: cd: line 1: can't cd to /usr/local/xenomai/share/xenomai/testsuite/switchbench

Do you have a /usr/local/xenomai/share/xenomai/testsuite/switchbench on
the target ?

> 
> Thu Jan  1 00:00:22 UTC 1970
> running: ./run -- -h # switchbench
> /usr/local/xenomai/bin/xeno-test: eval: line 1: ./run: not found

That follows from the previous error (can not cd to the directory where
"run" is supposed to be found, so can not run "run" either).

> == FPU check routines: OK.
> == Threads: sleeper_ufps-0 rtk-1Oops: Exception in kernel mode, sig: 11 [#1]
> PREEMPT Kilauea
> Modules linked in:
> NIP: c01e876c LR: c01e86e8 CTR: c0070fb0
> REGS: cf1e5440 TRAP: 0700   Not tainted  (2.6.30.3-wolverine-dirty)
> MSR: 00029030 <EE,ME,CE,IR,DR>  CR: 40000002  XER: 0000005f
> TASK = cd459520[817] 'switchtest' THREAD: cd450000
> GPR00: 00000005 cf1e54f0 cd459520 00000000 00000005 00000001 6829524c 00000000
> GPR08: 00001164 00000000 00000017 c0390000 20000002 00000000 00021030 c0070d8c
> GPR16: cd469208 00000000 00000000 00000000 c0394108 c0381248 003d0900 00000000
> GPR24: c02f5580 cf1e5500 cd4691d0 cd45eb78 00000006 cd469208 00000000 00000000
> NIP [c01e876c] rtswitch_ktask+0xb0/0x3e4
> LR [c01e86e8] rtswitch_ktask+0x2c/0x3e4
> Call Trace:
> Instruction dump:
> 7c0003b8 7f9c0038 7f892278 21290000 7d3c0194 7d3c4b78 4182009c 1c1703e8
> 39200000 7c002214 9001000c 91210008 <c8010008> fc200090 fc400090 fc600090
> ---[ end trace 203da9216e563608 ]---

This is powerpc, I seem to remember that Philippe told me about this
one, but I do not remember what was its cause.

Could you run /proc/ipipe/version on the machine where you observe this?

-- 
					    Gilles.

