Subject: Re: [Xenomai-help] Bad EIP kernel-Oops
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <58168.129.217.4.64.1158067468.squirrel@domain.hid>
References: <58168.129.217.4.64.1158067468.squirrel@domain.hid>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 22:11:15 +0200
Message-Id: <1158091876.5020.8.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: nils.kemper@domain.hid
Cc: xenomai@xenomai.org

On Tue, 2006-09-12 at 15:24 +0200, Nils Kemper wrote:
> Hi,
> I want to use Xenomai, but I get (sometimes, but everytime the same)
> kernel-Oops just by running xeno-test:
> 
> [..]
> Xenomai: stopping native API services.
> I-pipe: Domain Xenomai unregistered.
> Xenomai: hal/x86 stopped.
> Xenomai: real-time nucleus unloaded.

Does the issue still pop up if you set the Xenomai nucleus as static
(i.e. not as a module) in the kernel configuration?

>  Unable to handle kernel NULL pointer dereference at virtual address 00000000
>  printing eip:
>  00000000
>  *pde = 00000000
>  Oops: 0000 [#1]
>  PREEMPT
>  Modules linked in: netconsole 8139too crc32 ipv6 nfs lockd sunrpc
> intel_agp ehci_hcd uhci_hcd usbcore i810_audio ac97_codec soundcore 3c59x
> mii agpgart
>  CPU:    0
>  EIP:    0060:[<00000000>]    Not tainted VLI
>  EFLAGS: 00010246   (2.6.16.27n-xeno222 #7)
>  EIP is at rest_init+0x3feffde0/0x63
>  eax: c030ba80   ebx: c030ba80   ecx: 00000002   edx: 00000003
>  esi: c030ba80   edi: 00000246   ebp: 00000021   esp: cc1bbf80
>  ds: 007b   es: 007b   ss: 0068
>  Process dd (pid: 11490, threadinfo=cc1ba000 task=d56f8a70)
>  Stack: <0>c013f158 00000021 c030ba80 cc1bbfbc 00000001 c0314408 c030ba80
> cc1bbfbc
>         00000000 00000200 08051000 cc1ba000 c0111c3d 00000000 c0102ec6
> 00000000
>         08051000 00000200 00000200 08051000 bfda2568 00000003 0000007b
> 0000007b
>  Call Trace:
>         [<c013f158>] __ipipe_dispatch_event+0xcd/0xeb
>         [<c0111c3d>] __ipipe_syscall_root+0x2f/0xd8
>         [<c0102ec6>] sysenter_past_esp+0x3b/0x67
>  Code:  Bad EIP value.
>  <4>I-pipe: Domain Xenomai registered.
> Xenomai: hal/x86 started.
> Xenomai: real-time nucleus v2.2.2 (Ride) loaded.
> Xenomai: SMI-enabled chipset found, enabling SMI workaround.
> [..]
> 
> I'm sure somthing is wrong with my kernel-config, so I have attached it,
> together with the xeno-test-output.
> BTW: I tried noapic, acpi=off with no success.
> 
> TIA,
> Nils
> _______________________________________________ Xenomai-help mailing list Xenomai-help@domain.hid https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



