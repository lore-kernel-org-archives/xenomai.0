MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17229.14671.80367.846809@domain.hid>
Date: Wed, 12 Oct 2005 18:26:55 +0200
Subject: Re: [Xenomai-help] Kernel oops on posix threads
In-Reply-To: <434D370B.6090605@domain.hid>
References: <434D2CCD.4070802@domain.hid>
	<17229.12998.842183.402786@domain.hid>
	<434D370B.6090605@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Luotao Fu <devtty0@domain.hid>
Cc: xenomai@xenomai.org

Luotao Fu wrote:
 > Hi,
 > 
 > Gilles Chanteperdrix schrieb:
 > > Luotao Fu wrote:
 > >  > I scratched some simple code which causes this Kernel Ooops. Packed a
 > >  > tar ball together with the makefile and attached the tar ball it to this
 > >  > mail so that you might have a look at it yourself.
 > >  > I'm using
 > >  > Kernel: Vanilla 2.6.12 patched with adeos-linux-2.6.12-i386-r12.patch
 > >  > Distr. Debian 3.1
 > >  > Testhost: vmware 5.0
 > >  > compiler gcc 3.3.5
 > > 
 > > Sorry for the second answer: what version of RTAI/Fusion ?
 > > If it is easy for you, could you try with the current version of
 > > Xenomai ?
 > > 
 > Thanx for you answer.
 > 
 > Sorry for the insufficiency, I forgot to mention it. I use fusion 0.9.1,
 > compiled it just two weeks ago. To the questions in you last mail:
 > 1.Yes I get the oops also the first time after I inserted the posix module.
 > 2. The complete Oops message: see attachment
 > 
 > 
 > Hope it helps.
 > 
 > Thanx again
 > Cheers
 > Luotao Fu
 > Unable to handle kernel paging request at virtual address 6b6b6b77
 >  printing eip:
 > c4aaef89
 > *pde = 00000000
 > Oops: 0000 [#1]
 > PREEMPT
 > Modules linked in: nfs lockd sunrpc rtai_posix rtai_nucleus rtai_hal md5 ipv6 af_packet piix ide_generic intel_agp evdev sd_mod ide_cd cdrom ide_disk ide_core floppy vga16fb vgastate mptscsih mptbase scsi_mod unix
 > CPU:    0
 > EIP:    0060:[<c4aaef89>]    Not tainted VLI
 > EFLAGS: 00010082   (2.6.12.6-adeos-patched)
 > EIP is at xnpod_schedule+0x754/0x87b [rtai_nucleus]
 > eax: 6b6b6b6b   ebx: c4abf110   ecx: 8005003b   edx: c2d5b020
 > esi: 00000000   edi: c4b58330   ebp: c2d5b540   esp: c2f2bedc
 > ds: 007b   es: 007b   ss: 0068
 > Process test (pid: 1658, threadinfo=c2f2a000 task=c2d5b540)
 > Stack: 00000000 00200000 00000001 c4abede0 c4abf110 c4b50033 c0100000 00000000
 >        8005003b c4abf460 c4b58330 00000000 00000000 c4aadcf9 00000000 c4abede0
 >        00000100 00000000 c4b58330 c4a5bfa8 c0353868 c4ab1de1 c4b58330 00000100
 > Call Trace:
 >  [<c4aadcf9>] xnpod_suspend_thread+0x178/0x1d1 [rtai_nucleus]
 >  [<c4ab1de1>] xnshadow_relax+0xa6/0xf4 [rtai_nucleus]
 >  [<c4ab27cd>] hisyscall_event+0x261/0x2af [rtai_nucleus]
 >  [<c0129c76>] __adeos_handle_event+0x70/0x113
 >  [<c010d239>] __adeos_enter_syscall+0x16/0x83
 >  [<c0102851>] system_call+0x25/0x46
 > Code: 00 74 05 0f ae 08 eb 02 dd 20 8b 54 24 10 8b 44 24 0c 89 90 20 03 00 00 eb 5a 8b 5c 24 10 8b 93 10 02 00 00 85 d2 74 09 8b 42 04 <f6> 40 0c 01 74 43 0f 06 a1 8c d2 2a c0 a9 00 00 00 01 75 35 85
 >  <6>note: test[1658] exited with preempt_count 2
 > 

Ok, you really ought to try xenomai, because this strangely looks like a
bug that was fixed. It was not as reproducible as that in my test cases
though...

-- 


					    Gilles Chanteperdrix.

