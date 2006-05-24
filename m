From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Re: Xenomai v2.2-rc2. PowerPC 405GPr board does
	not start up
Date: Wed, 24 May 2006 07:10:31 +0200
References: <446F852B.7090400@domain.hid>
	<200605222208.15908.niklaus.giger@domain.hid>
	<44722DCF.80208@domain.hid>
In-Reply-To: <44722DCF.80208@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605240710.31616.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
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
Cc: xenomai@xenomai.org

Am Montag, 22. Mai 2006 23:31 schrieb Philippe Gerum:
> Niklaus Giger wrote:
<..>
>
> Ok, relatively good news. Now I need to find why starting the timer
> early breaks the system...
>
I do not know whether this is related to our problem.

I started to adapt xeno-test to my busybox environment. I used the kernel with 
only native built-in and all others as modules. Then I discovered that 
running manually latency on a freshly booted system gets the following 
segmentation fault.
Here the relevant output 
/usr/xenomai/testsuite/latency # mount -a
/usr/xenomai/testsuite/latency # modprobe xeno_native
/usr/xenomai/testsuite/latency # modprobe xeno_rtdm
/usr/xenomai/testsuite/latency # modprobe xeno_timerbench
/usr/xenomai/testsuite/latency # lsmod
Module                  Size  Used by    Not tainted
xeno_timerbench 7460 0 - Live 0xc3030000
xeno_rtdm 27412 1 xeno_timerbench, Live 0xc3091000
xeno_native 84780 0 - Live 0xc3130000
/usr/xenomai/testsuite/latency # ./latency
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microsecondOops: kernel access of bad area, sig: 11 [#1]
NIP: C001C5EC LR: C004CEA8 SP: C19ABDB0 REGS: c19abd00 TRAP: 0300    Not 
tainted
MSR: 00029030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 0000000C, DSISR: 00000000
TASK = c198f830[36] 'display-34' THREAD: c19aa000
Last syscall: 50332203
GPR00: 00000000 C19ABDB0 C198F830 00000000 00000001 00000062 00000000 00000000
GPR08: 04FB0D6D C01FF720 00000001 C020AF40 000009F3 1001EA64 01FFBC00 007FFF77
GPR16: 00000000 00000001 FFFFFFFF 00000000 C19ABF50 C020AF40 00000000 C01E0000
GPR24: C01E0000 00000001 00000000 00000062 00000001 C01E0000 00000000 00000000
NIP [c001c5ec] ipipe_reenter_root+0x30/0xe8
LR [c004cea8] xnshadow_relax+0x11c/0x18c
Call trace:
 [c004cea8] xnshadow_relax+0x11c/0x18c
 [c0047a88] xnpod_fault_handler+0x8c/0xf0
 [c004892c] xnpod_trap_fault+0x64/0x7c
 [c00432cc] xnarch_trap_fault+0x1c/0x2c
 [c0117b84] exception_event+0x6c/0x7c
 [c003fbec] __ipipe_dispatch_event+0xf0/0x158
 [c000aecc] do_page_fault+0x50/0x52c
 [c0003258] handle_page_fault+0xc/0x80
s
Segmentation fault

Best regards

-- 
Niklaus Giger

