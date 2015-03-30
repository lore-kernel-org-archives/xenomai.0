MIME-Version: 1.0
Sender: had2006@gmail.com
In-Reply-To: <CAKk99t2LDG0+CC3360XmaQ-F6zb=OuKLMRCtEgfKYFYouoOYqw@mail.gmail.com>
References: <CAKk99t15m2dbUzGNxi4TsAVk4suZGc14qxv2cBh+iG1nWcM-kQ@mail.gmail.com>
 <55196828.9020207@xenomai.org>
 <20150330152002.GL32766@hermes.click-hack.org>
 <55196B64.9010901@xenomai.org>
 <20150330152957.GN32766@hermes.click-hack.org>
 <55196DB0.8020308@xenomai.org>
 <CAKk99t2LDG0+CC3360XmaQ-F6zb=OuKLMRCtEgfKYFYouoOYqw@mail.gmail.com>
Date: Mon, 30 Mar 2015 16:55:42 +0100
Message-ID: <CAKk99t0m=CoE7qw+4aH_UwhK+JYt5Ry5YtDA-7W79q91nOaWsw@mail.gmail.com>
From: Helder Daniel <hdaniel@ualg.pt>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] There is XDDP Sockets support in kernel?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

After moving rtdm_bind() to the module initialization the module loads, but
now something wrong happened to the kernel :). Probably I left the program
buggy when moving the xddp-echo example to kernel space. I will take a
deeper look.

Thanks

[  450.392941] senderK successfully loaded
[  450.643664] BUG: unable to handle kernel paging request at
000000004fcf4200
[  450.644714] IP: [<ffffffffa03950c8>] sender+0x26/0xc9 [senderK]
[  450.645497] PGD 0
[  450.645930] Oops: 0000 [#1] SMP
[  450.646600] Modules linked in: senderK(O) xeno_rtipc cfg80211 bnep nfsd
auth_rpcgss oid_registry nfs_acl nfs lockd fscache sunrpc fuse vmhgfs(O)
loop snd_ens1371 snd_ac97_codec coretemp snd_rawmidi snd_seq_device
microcode ac97_bus gameport ecb snd_pcm snd_timer snd psmouse soundcore
evdev serio_raw pcspkr btusb bluetooth rfkill vmwgfx ttm drm_kms_helper
ehci_pci drm shpchp rt_e1000 i2c_piix4 i2c_core rtnet vmci(O) ext4 crc16
jbd2 mbcache vmw_pvscsi vmxnet3 hid_generic usbhid hid sd_mod sg crc_t10dif
crct10dif_common sr_mod cdrom ata_generic uhci_hcd ehci_hcd usbcore e1000
usb_common mptspi scsi_transport_spi mptscsih mptbase ata_piix libata
scsi_mod
[  450.660900] CPU: 0 PID: 3840 Comm: XDDPsender Tainted: G           O
 3.16.0-ipipe #1
[  450.662123] Hardware name: VMware, Inc. VMware Virtual Platform/440BX
Desktop Reference Platform, BIOS 6.00 05/20/2014
[  450.663030] task: ffff8800149cd2b0 ti: ffff88001f98c000 task.ti:
ffff88001f98c000
[  450.663743] RIP: 0010:[<ffffffffa03950c8>]  [<ffffffffa03950c8>]
sender+0x26/0xc9 [senderK]
[  450.664627] RSP: 0018:ffff88001f98fdf8  EFLAGS: 00010286
[  450.669222] RAX: 0000000015f2bbe8 RBX: ffffffffa03972c0 RCX:
ffffffffffffffff
[  450.669835] RDX: ffff880016000000 RSI: 0000000000000000 RDI:
0000000000000000
[  450.670409] RBP: ffff880015f2bbe8 R08: 0000000080000000 R09:
ffff8800160948f8
[  450.671019] R10: 00000000000004b9 R11: ffffffffa03972c0 R12:
0000000000000000
[  450.671630] R13: ffffffff810d2e44 R14: 0000000000000000 R15:
0000000000000000
[  450.672529] FS:  0000000000000000(0000) GS:ffff880016000000(0000)
knlGS:0000000000000000
[  450.673360] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  450.673897] CR2: 000000004fcf4200 CR3: 000000001ed28000 CR4:
00000000000407f0
[  450.674624] I-pipe domain Linux
[  450.675519] Stack:
[  450.675837]  0000000000000000 0000000000000003 0000000000000082
ffffffffa03972c0
[  450.677144]  0000000000000000 0000000000000000 ffff8800149cd2b0
ffffffff810d1fba
[  450.678336]  ffff8800160506a8 ffffffff810d2e17 0000000000000000
0000000000000018
[  450.680082] Call Trace:
[  450.680514]  [<ffffffff810d1fba>] ? xnthread_test_cancel+0x6/0x1f
[  450.681074]  [<ffffffff810d2e17>] ? xnthread_map+0x164/0x191
[  450.681691]  [<ffffffff810d0c90>] ? ipipe_set_ti_thread_flag+0xa/0xa
[  450.682308]  [<ffffffff810d2eec>] ? kthread_trampoline+0xa8/0xcc
[  450.682903]  [<ffffffff81053bea>] ? kthread+0x99/0xa1
[  450.683378]  [<ffffffff81053b51>] ? __kthread_parkme+0x59/0x59
[  450.683969]  [<ffffffff813663ed>] ? ret_from_fork+0x7d/0xb0
[  450.684518]  [<ffffffff81053b51>] ? __kthread_parkme+0x59/0x59
[  450.685061] Code: 48 83 c4 48 c3 55 53 48 81 ec 88 00 00 00 31 ff e8 12
cb d3 e0 85 c0 79 0b 89 c6 48 c7 c7 24 60 39 a0 eb 7c 48 63 c5 48 83 c9 ff
<4c> 8b 04 c5 c0 62 39 a0 31 c0 4c 89 c7 4c 89 c6 f2 ae 8b 3d a0
[  450.695959] RIP  [<ffffffffa03950c8>] sender+0x26/0xc9 [senderK]
[  450.696681]  RSP <ffff88001f98fdf8>
[  450.697063] CR2: 000000004fcf4200
[  450.697573] ---[ end trace 573e93c96f32000b ]---


On 30 March 2015 at 16:40, Helder Daniel <hdaniel@ualg.pt> wrote:

> I think it is.
> xeno_rtipc was successfully loaded before inserting my module.
>
>
>
> On 30 March 2015 at 16:37, Philippe Gerum <rpm@xenomai.org> wrote:
>
>> On 03/30/2015 05:29 PM, Gilles Chanteperdrix wrote:
>> > On Mon, Mar 30, 2015 at 05:27:32PM +0200, Philippe Gerum wrote:
>> >> On 03/30/2015 05:20 PM, Gilles Chanteperdrix wrote:
>> >>> On Mon, Mar 30, 2015 at 05:13:44PM +0200, Philippe Gerum wrote:
>> >>>> On 03/30/2015 04:55 PM, Helder Daniel wrote:
>> >>>>> Hi,
>> >>>>>
>> >>>>> When trying to compile a kernel module that sets up a XDDP socket
>> (code
>> >>>>> snippet below) with Xenomai 3.x-rc3 on Cobalt setup,
>> >>>>> rtdm_bind() returns ENOSYS.
>> >>>>> This means that XDDP sockets can not be used in kernel?
>> >>>>>
>> >>>>
>> >>>> No, in this case it likely means that you are calling it from a
>> >>>> real-time context (i.e. a real-time kthread started with
>> >>>> rtdm_task_create()). The binding op can only run from a non-rt
>> context,
>> >>>> e.g. module init code, regular kthread context, _nrt handler.
>> >>>
>> >>> Or that XDDP is not enabled in the kernel configuration, maybe?
>> >>>
>> >>
>> >> It's an intra-kernel call, so it must be there.
>> >
>> > Not sure I follow. If RTDM is enabled in the kernel configuration,
>> > and XDDP is not, then rtdm_bind will return -ENOSYS.
>> >
>>
>> It's a binding operation, so if the code did receive a valid XDDP
>> socket, the XDDP support must be there.
>>
>> --
>> Philippe.
>>
>
>
>
> --
> Helder Daniel
> UALG - FCT
> DEEI
>
> http://w3.ualg.pt/~hdaniel
>



-- 
Helder Daniel
UALG - FCT
DEEI

http://w3.ualg.pt/~hdaniel
