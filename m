Subject: Re: [Xenomai-core] xeno task debigging
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44A519C4.3080900@domain.hid>
References: <44A519C4.3080900@domain.hid>
Content-Type: text/plain
Date: Mon, 03 Jul 2006 15:19:08 +0200
Message-Id: <1151932749.5002.5.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "s.a." <sancelot@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Fri, 2006-06-30 at 12:32 +0000, s.a. wrote:
> Hi,
> I have got the following kernel message in a process that crashes sometimes
> the action to obtain it is console switching with ctrl alt  Fx
> the two processes are xeno tasks
> 
> any idea about the problem ?
> 
> how to debug this in xenomai ?

The first step is always to check if the same issue occurs using the
standard Xenomai testsuite, e.g. running the latency and switch tests.
Nobody knows what your application is doing and the way it does it,
including the kernel module you seem to be using for that purpose; so
let's properly segregate issues if need be. Try to reproduce the crash
with a freshly patched kernel, without running neither extra modules nor
applications.

> is there a workaround ?
> 
> general protection fault: 0000 [#1]
> PREEMPT
> Modules linked in: nls_iso8859_1 nls_cp437 i915 rtcan_sja1000 e100
> usb_storage eepro100 mii rtc unix
> CPU:    0
> EIP:    0060:[<c0103112>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.16.19-ipipe #1)
> EIP is at sysenter_exit+0xf/0x11
> eax: 00000010   ebx: 00000000   ecx: b7d1223c   edx: ffffe410
> esi: b7d122cc   edi: 00000000   ebp: 00000000   esp: dc1a7fbc
> ds: 007b   es: 007b   ss: 0068
> Process EnvoiPDO0 (pid: 1879, threadinfo=dc1a6000 task=de35d030)
> Stack: <0>00000000 b7d122cc 00000000 b7d122cc 00000000 b7d12268 00000010
> 0000007b
>        0000007b 0802022b ffffe410 00000073 00000206 b7d1223c 0000007b
> 00000000
>        00000000
> Call Trace:
> Code: 44 24 18 e8 81 ca 03 00 fb 8b 4d 08 66 f7 c1 ff fe 0f 85 4e 01 00
> 00 e8 ed ea 00 00 8b 44 24 18 8b 54 24 28 8b 4c 24 34 31 ed fb <0f> 35
> 50 fc 06 1e 50 55 57 56 52 51 53 ba 7b 00 00 00 8e da 8e
>  <0>general protection fault: 0000 [#2]
> PREEMPT
> Modules linked in: nls_iso8859_1 nls_cp437 i915 rtcan_sja1000 e100
> usb_storage eepro100 mii rtc unix
> CPU:    0
> EIP:    0060:[<c0103112>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.16.19-ipipe #1)
> EIP is at sysenter_exit+0xf/0x11
> eax: 00000000   ebx: 00000000   ecx: b7ce6a2c   edx: ffffe410
> esi: 00669627   edi: 00000000   ebp: 00000000   esp: d704ffbc
> ds: 007b   es: 007b   ss: 0068
> Process Automat (pid: 1882, threadinfo=d704e000 task=d701b030)
> Stack: <0>00000000 00000001 b7d8a660 00669627 00000000 b7ce6a58 00000000
> 2801007b
>        0000007b 0801022b ffffe410 00000073 00000206 b7ce6a2c 0000007b
> 00000000
>        00000000
> Call Trace:
> Code: 44 24 18 e8 81 ca 03 00 fb 8b 4d 08 66 f7 c1 ff fe 0f 85 4e 01 00
> 00 e8 ed ea 00 00 8b 44 24 18 8b 54 24 28 8b 4c 24 34 31 ed fb <0f> 35
> 50 fc 06 1e 50 55 57 56 52 51 53 ba 7b 00 00 00 8e da 8e
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



