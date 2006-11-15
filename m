From: Stephan Zimmermann <s.zimmermann@domain.hid>
Subject: Re: [Xenomai-help] Kernel crash during queue create/destroy
Date: Wed, 15 Nov 2006 15:44:00 +0100
References: <200611151121.51836.s.zimmermann@domain.hid>
	<b647ffbd0611150519w1a510582n40782bdccaa7562d@domain.hid>
In-Reply-To: <b647ffbd0611150519w1a510582n40782bdccaa7562d@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611151544.00429.s.zimmermann@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Am Mittwoch, 15. November 2006 14:19 schrieb Dmitry Adamushko:
> Hello,
>
> I got some trouble with the native skin and queues, when creating /
> deleting
>
> > queues, my Kernel sometimes (actually very often...) crashes, leading to
> > a frozen system, with my Xenomai program continuing until it returns. I
> > tried
> > to isolate / reproduce the problem, which lead me to the following
> > demo-code.
>
> it looks like there is some "misunderstanding" between
>
> (1) rt_queue_delete() -> xnregistry_remove()
>
> and
>
> (2) registry_proc_callback() which crushes in remove_proc_entry().
>
> You may follow the logic in ksrc/nucleus/registry.c.
>
> rt_queue_create() -> xnregistry_enter() -> ... -> registry_proc_callback()
>
> rt_queue_delete() -> xnregistry_remove() -> ... registry_proc_unexport()
>
> I don't have enough time to investigate further right now, but
> nevertheless, could you apply the following patch and let us know of the
> outcome?

Thanks for your fast response. I just applied (and recompiled everything...) 
the patch you attached to your last Post. It doesn't seem to change  anything 
for me. I attached the entries from syslog the test produced.

<syslog>
Nov 15 15:34:56 localhost kernel: BUG: unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Nov 15 15:34:56 localhost kernel:  printing eip:
Nov 15 15:34:56 localhost kernel: c01a6f7e
Nov 15 15:34:56 localhost kernel: *pde = 00000000
Nov 15 15:34:56 localhost kernel: Oops: 0000 [#1]
Nov 15 15:34:56 localhost kernel: PREEMPT
Nov 15 15:34:56 localhost kernel: Modules linked in: ipv6 nfs lockd sunrpc 
snd_mpu401 floppy pcspkr rtc snd_via82xx gameport snd_ac97_codec snd_ac97_bus 
snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device 
snd soundcore i2c_viapro i2c_core generic 8139cp tsdev mousedev amd64_agp 
agpgart ehci_hcd usbhid uhci_hcd usbcore via82cxxx 8139too mii psmouse 
ide_generic ide_disk ide_cd cdrom ide_core unix
Nov 15 15:34:56 localhost kernel: CPU:    0
Nov 15 15:34:56 localhost kernel: EIP:    0060:[remove_proc_entry+51/333]    
Not tainted VLI
Nov 15 15:34:56 localhost kernel: EFLAGS: 00010286   (2.6.17.14 #1)
Nov 15 15:34:56 localhost kernel: EIP is at remove_proc_entry+0x33/0x14d
Nov 15 15:34:56 localhost kernel: eax: 00000000   ebx: c03d10f4   ecx: 
ffffffff   edx: 00000000
Nov 15 15:34:56 localhost kernel: esi: c03d0a98   edi: 00000000   ebp: 
f433e0c0   esp: c1907f00
Nov 15 15:34:56 localhost kernel: ds: 007b   es: 007b   ss: 0068
Nov 15 15:34:56 localhost kernel: Process events/0 (pid: 4, 
threadinfo=c1906000 task=c190ea90)
Nov 15 15:34:56 localhost kernel: Stack: 00000000 c03d10f4 c03d0a98 c03464cc 
c0148919 00000000 f433e0c0 00000000
Nov 15 15:34:56 localhost kernel:        00000000 c02ff32d c02ff2a2 f6153740 
f433ec40 c18e0640 c03460e0 00000200
Nov 15 15:34:56 localhost kernel:        00000000 c0126773 00000000 c0147fa5 
c1906000 c190ea90 fffffffb c18e0640
Nov 15 15:34:56 localhost kernel: Call Trace:
Nov 15 15:34:57 localhost kernel:  <c0148919> 
registry_proc_callback+0x974/0x9ec  <c0126773> run_workqueue+0xd7/0x172
Nov 15 15:34:57 localhost kernel:  <c0147fa5> registry_proc_callback+0x0/0x9ec  
<c0126906> worker_thread+0xf8/0x12a
Nov 15 15:34:57 localhost kernel:  <c0112a33> default_wake_function+0x0/0x12  
<c02e04bc> schedule+0x62e/0x64d
Nov 15 15:34:57 localhost kernel:  <c0112a33> default_wake_function+0x0/0x12  
<c012680e> worker_thread+0x0/0x12a
Nov 15 15:34:57 localhost kernel:  <c0129922> kthread+0x79/0xa3  <c01298a9> 
kthread+0x0/0xa3
Nov 15 15:34:57 localhost kernel:  <c0101385> kernel_thread_helper+0x5/0xb
Nov 15 15:34:57 localhost kernel: Code: 00 8b 54 24 14 89 14 24 75 19 89 e0 50 
8d 44 24 1c 50 52 e8 a4 f5 ff ff 83 c4 0c 85 c0 0f 85 1d 01 00 00 8b 3c 24 31 
c0 83 c9 ff <f2> ae f7 d1 49 81 3d 80 5c 34 c0 00 39 34 c0 89 ce 75 0a b8 01
Nov 15 15:34:57 localhost kernel: EIP: [remove_proc_entry+51/333] 
remove_proc_entry+0x33/0x14d SS:ESP 0068:c1907f00
</syslog>

