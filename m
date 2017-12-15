References: <954f3936-9906-a33e-4d6a-fa5e640430e4@xenomai.org>
 <bb013c41-9b90-4bc1-a84a-6e5137061ceb@alaxarxa.net>
 <20f31474-8d30-fad7-c79d-bd4cf03295ae@xenomai.org>
From: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Message-ID: <56e8674c-9744-3bf4-ba7a-b3df1fd113fa@alaxarxa.net>
Date: Fri, 15 Dec 2017 13:25:17 +0100
MIME-Version: 1.0
In-Reply-To: <20f31474-8d30-fad7-c79d-bd4cf03295ae@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTnet fixes - testers needed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Hi,

I forgot something more:

On 15/12/17 12:04, Philippe Gerum wrote:

[...]
>>
>> I guess that there's something in the kernel config or somewhere in 3.x that
>> affects the PCI cards. In 2.6.x worked.
> 
> On x86, I'd dare to say that it worked mostly by accident, as revealed
> by SMAP later on. RTnet was out of the Xenomai tree in 2.6.x, some
> changes introduced during the merge into 3.x might have caused
> regressions, or maybe some latent issues started to bite when transposed
> in a different environment, just like the SMAP problem on x86, revealing
> an ancient Rnet bug. I genuinely don't know when things started to hit
> the fan.

I don't know if it's relevant or not, or I didn't understand it, but I think
that I still have problems with SMAP. If I activate it, I got:

Dec 15 12:39:03 bmm3 kernel: [ 1495.836505] [Xenomai] switching slaveinfo_rt to
secondary mode after exception #14 in kernel-space at 0xffffffffc046a981 (pid
Dec 15 12:39:03 bmm3 kernel: [ 1495.839892] PGD 45afb2067
Dec 15 12:39:03 bmm3 kernel: [ 1495.839901] PUD 45c07b067
Dec 15 12:39:03 bmm3 kernel: [ 1495.841014] PMD 459b3a067
Dec 15 12:39:03 bmm3 kernel: [ 1495.841019] PTE 8000000451600067
Dec 15 12:39:03 bmm3 kernel: [ 1495.842141]
Dec 15 12:39:03 bmm3 kernel: [ 1495.843237] Oops: 0001 [#2] SMP
Dec 15 12:39:03 bmm3 kernel: [ 1495.844342] Modules linked in: rt_e1000e
rt_loopback rtcfg rtudp rtipv4 rtmac rtpacket ctr ccm cdc_acm snd_hda_codec_hdmi snd
Dec 15 12:39:03 bmm3 kernel: [ 1495.850432]  efivars battery hci_uart btbcm
btqca btintel parport_pc parport bluetooth wmi rfkill intel_lpss_acpi video intel
Dec 15 12:39:03 bmm3 kernel: [ 1495.854316] CPU: 5 PID: 1306 Comm: slaveinfo_rt
Tainted: G      D    O    4.9.51-xenomai-3.0.6-ipipe #1
Dec 15 12:39:03 bmm3 kernel: [ 1495.855577] Hardware name: Gigabyte Technology
Co., Ltd. To be filled by O.E.M./Q170M-D3H, BIOS F2 01/11/2016
Dec 15 12:39:03 bmm3 kernel: [ 1495.856827] I-pipe domain: Linux
Dec 15 12:39:03 bmm3 kernel: [ 1495.858046] task: ffff9c4599fe90c0 task.stack:
ffffa485c090c000
Dec 15 12:39:03 bmm3 kernel: [ 1495.859254] RIP: 0010:[<ffffffffc046a981>]
[<ffffffffc046a981>] rt_packet_ioctl+0x1a1/0x380 [rtpacket]
Dec 15 12:39:03 bmm3 kernel: [ 1495.860460] RSP: 0018:ffffa485c090fdf8  EFLAGS:
00010202
Dec 15 12:39:03 bmm3 kernel: [ 1495.861640] RAX: ffffa485c090fdf8 RBX:
ffff9c45991bbe00 RCX: 0000000000000000
Dec 15 12:39:03 bmm3 kernel: [ 1495.862804] RDX: 0000000000000000 RSI:
00007ffe9ae5eec0 RDI: ffffa485c090fe08
Dec 15 12:39:03 bmm3 kernel: [ 1495.863965] RBP: ffffa485c090fec0 R08:
e4b5e00700000014 R09: 000000000000005c
Dec 15 12:39:03 bmm3 kernel: [ 1495.865114] R10: 00000000000000e4 R11:
0000000100048fc7 R12: 0000000000000003
Dec 15 12:39:03 bmm3 kernel: [ 1495.866255] R13: ffff9c45991bbf40 R14:
ffffa485c02de040 R15: 00007ffe9ae5ef20
Dec 15 12:39:03 bmm3 kernel: [ 1495.867384] FS:  00007f23b82edb80(0000)
GS:ffff9c45a0300000(0000) knlGS:0000000000000000
Dec 15 12:39:03 bmm3 kernel: [ 1495.868528] CS:  0010 DS: 0000 ES: 0000 CR0:
000000008005003b
Dec 15 12:39:03 bmm3 kernel: [ 1495.869662] CR2: 00007ffe9ae5ef20 CR3:
000000045b799000 CR4: 00000000003406e0
Dec 15 12:39:03 bmm3 kernel: [ 1495.870788] DR0: 0000000000000000 DR1:
0000000000000000 DR2: 0000000000000000
Dec 15 12:39:03 bmm3 kernel: [ 1495.871913] DR3: 0000000000000000 DR6:
00000000fffe0ff0 DR7: 0000000000000400
Dec 15 12:39:03 bmm3 kernel: [ 1495.873040] Stack:
Dec 15 12:39:03 bmm3 kernel: [ 1495.874139]  00007ffe9ae5ef20 e4b5e00700000014
ffff9c45991bbe00 ffffa485c090fec0
Dec 15 12:39:03 bmm3 kernel: [ 1495.875282]  0000000000000003 ffff9c4599fe90c0
ffffa485c02de040 0000000000011ba0
Dec 15 12:39:03 bmm3 kernel: [ 1495.876416]  ffffffffb7f6b9a8 00007ffe9ae5eeb0
4010002299fe96b8 0000000000000010
Dec 15 12:39:03 bmm3 kernel: [ 1495.877537] Call Trace:
Dec 15 12:39:03 bmm3 kernel: [ 1495.878636]  [<ffffffffb7f6b9a8>] ?
rtdm_fd_ioctl+0xa8/0x1e0
Dec 15 12:39:03 bmm3 kernel: [ 1495.879744]  [<ffffffffb7f70b20>] ?
CoBaLt_fcntl+0x10/0x10
Dec 15 12:39:03 bmm3 kernel: [ 1495.880865]  [<ffffffffb7e8298d>] ?
__ipipe_migrate_head+0x4d/0xb0
Dec 15 12:39:03 bmm3 kernel: [ 1495.881976]  [<ffffffffb7f70b20>] ?
CoBaLt_fcntl+0x10/0x10
Dec 15 12:39:03 bmm3 kernel: [ 1495.883084]  [<ffffffffb7f70b2a>] ?
CoBaLt_ioctl+0xa/0x10
Dec 15 12:39:03 bmm3 kernel: [ 1495.884169]  [<ffffffffb7f807ac>] ?
ipipe_syscall_hook+0xfc/0x2b0
Dec 15 12:39:03 bmm3 kernel: [ 1495.885265]  [<ffffffffb7efad9a>] ?
__ipipe_notify_syscall+0xba/0x170
Dec 15 12:39:03 bmm3 kernel: [ 1495.886356]  [<ffffffffb83868af>] ?
pipeline_syscall+0x8/0x1b
Dec 15 12:39:03 bmm3 kernel: [ 1495.887434] Code: 5f c3 b9 10 00 00 00 48 89 e6
e8 7b 16 46 00 48 3d 00 f0 ff ff 77 d8 83 78 08 13 4c 8b 38 4c 8d ab 40 01 00
Dec 15 12:39:03 bmm3 kernel: [ 1495.890982]  RSP <ffffa485c090fdf8>
Dec 15 12:39:03 bmm3 kernel: [ 1495.892126] CR2: 00007ffe9ae5ef20
Dec 15 12:39:03 bmm3 kernel: [ 1495.893272] ---[ end trace 6ba1d9fc8d294720 ]---


>>
>> Also, seeing the elephant, it's not obvious (at least for me) how to create or
>> upgrade a network driver to work with Xenomai. So, some tutorial would help.
>>
> 
> I see this file in the distro which looks like a promising starting
> point: kernels/drivers/net/doc/README.drvporting
> 

I'll look it.

Thanks,

Leopold

-- 
--
Linux User 152692     GPG: 05F4A7A949A2D9AA
Catalonia
-------------------------------------
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

