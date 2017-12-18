References: <954f3936-9906-a33e-4d6a-fa5e640430e4@xenomai.org>
 <bb013c41-9b90-4bc1-a84a-6e5137061ceb@alaxarxa.net>
 <20f31474-8d30-fad7-c79d-bd4cf03295ae@xenomai.org>
 <56e8674c-9744-3bf4-ba7a-b3df1fd113fa@alaxarxa.net>
 <657c0db4-6cb8-5876-3349-cd784ba69077@siemens.com>
 <7c3bd3a0-5d08-f1c9-1b39-1457b0826856@xenomai.org>
 <b8766709-ab3c-b6a8-c539-77343ca5aca1@siemens.com>
 <bde2e3b7-94a3-57bd-c33f-fac7bdcfb0be@xenomai.org>
 <1ca2dd05-123b-7d95-60ef-cd24156420eb@xenomai.org>
 <aa6f5c4c-7083-63f9-20aa-fb9929823065@siemens.com>
From: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Message-ID: <9e2e500f-d1a9-dcad-6c9a-fcdc6282d393@alaxarxa.net>
Date: Mon, 18 Dec 2017 16:19:28 +0100
MIME-Version: 1.0
In-Reply-To: <aa6f5c4c-7083-63f9-20aa-fb9929823065@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 18/12/17 07:33, Jan Kiszka wrote:
> On 2017-12-15 21:42, Philippe Gerum wrote:
>> On 12/15/2017 02:48 PM, Philippe Gerum wrote:
>>> On 12/15/2017 02:40 PM, Jan Kiszka wrote:
>>>> On 2017-12-15 14:29, Philippe Gerum wrote:
>>>>> On 12/15/2017 02:20 PM, Jan Kiszka wrote:
>>>>>> On 2017-12-15 13:25, Leopold Palomo-Avellaneda wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> I forgot something more:
>>>>>>>
>>>>>>> On 15/12/17 12:04, Philippe Gerum wrote:
>>>>>>>
>>>>>>> [...]
>>>>>>>>>
>>>>>>>>> I guess that there's something in the kernel config or somewhere in 3.x that
>>>>>>>>> affects the PCI cards. In 2.6.x worked.
>>>>>>>>
>>>>>>>> On x86, I'd dare to say that it worked mostly by accident, as revealed
>>>>>>>> by SMAP later on. RTnet was out of the Xenomai tree in 2.6.x, some
>>>>>>>> changes introduced during the merge into 3.x might have caused
>>>>>>>> regressions, or maybe some latent issues started to bite when transposed
>>>>>>>> in a different environment, just like the SMAP problem on x86, revealing
>>>>>>>> an ancient Rnet bug. I genuinely don't know when things started to hit
>>>>>>>> the fan.
>>>>>>>
>>>>>>> I don't know if it's relevant or not, or I didn't understand it, but I think
>>>>>>> that I still have problems with SMAP. If I activate it, I got:
>>>>>>
>>>>>> You must leave SMAP off until someone develops patches to convert the
>>>>>> complete RTnet userspace API over to rtdm_copy_to/from_user.
>>>>>>
>>>>>
>>>>> The patches in wip/rtnet-fixes address this issue, this is the patch
>>>>> series I was referring to in this discussion.
>>>>>
>>>>
>>>> Hmm, for the protocol core. I suspect you are missing further cases in
>>>> RTmac and RTcfg (provided anyone needs them).
>>>>
>>>
>>> The author of ioctl* support in both cases used copy_from_user directly,
>>> maybe that is a problem with the calling mode. Ok, I'll check whether
>>> rtnet_ioctls dispatcher actually routes from ioctl_nrt. Thanks.
>>>
>>
>> RTcfg and RTmac are fine in the wip/rtnet-fixes branch. The rtnet_ioctls
>> dispatcher runs over a regular ioctl_unlocked context from a chrdev, so
>> there is no mode issue. All user memory is accessed via copy_to/from
>> routines. I see no sendmsg/recvmsg which could raise the SMAP issue there.
>>
>> Do you have any hint about those missing cases?
>>
> 
> Nope, those two indeed seem to be fine. I didn't remember that we wrote
> them with proper copy_to/from, also for the RT part (tdma_dev.c). The
> core has a different, longer history, lacking any usercopy from day #1.
> 

Hi,

I have pulled wip/rtnet-fixes branch with the last commit of Philippe from Sun
Dec 17 15:27:04 2017 +0100: net/udp: ioctl: fix temp arg buffer type

I have created the packages and new kernel with the same configuration that I had.

I run my application, that it's a POSIX application Wrapped and I still have the
same error when I activate SMAP:

#######################################################3

Dec 18 14:58:13 bmm3 kernel: [  118.545908] [Xenomai] switching slaveinfo_rt to
secondary mode after exception #14 in kernel-space at 0xffffffffc0743981 (pid 1742)
Dec 18 14:58:13 bmm3 kernel: [  118.545924] BUG: unable to handle kernel paging
request at 00007ffcc7389470
Dec 18 14:58:13 bmm3 kernel: [  118.546586] IP: [<ffffffffc0743981>]
rt_packet_ioctl+0x1a1/0x380 [rtpacket]
Dec 18 14:58:13 bmm3 kernel: [  118.547264] PGD 458a90067
Dec 18 14:58:13 bmm3 kernel: [  118.547273] PUD 45a127067
Dec 18 14:58:13 bmm3 kernel: [  118.547941] PMD 4584fe067
Dec 18 14:58:13 bmm3 kernel: [  118.547946] PTE 8000000452fcb067
Dec 18 14:58:13 bmm3 kernel: [  118.548626]
Dec 18 14:58:13 bmm3 kernel: [  118.549302] Oops: 0001 [#1] SMP
Dec 18 14:58:13 bmm3 kernel: [  118.549979] Modules linked in: rt_e1000e
rt_loopback rtcfg rtudp rtipv4 rtmac rtpacket cdc_acm snd_hda_codec_hdmi
snd_hda_codec_realtek snd_hda_codec_generic binfmt_misc intel_rapl
x86_pkg_temp_thermal intel_powerclamp nls_ascii coretemp nls_cp437
crct10dif_pclmul crc32_pclmul vfat ghash_clmulni_intel arc4 fat ppdev
aesni_intel ath9k i915 aes_x86_64 ath9k_common lrw ath9k_hw gf128mul glue_helper
pcan(O) ablk_helper ath cryptd mac80211 pcmcia pcmcia_core intel_cstate
drm_kms_helper efi_pstore intel_uncore drm rtnet cfg80211 i2c_algo_bit
fb_sys_fops intel_rapl_perf snd_hda_intel xeno_can_peak_pci syscopyarea
sysfillrect iTCO_wdt xeno_can_sja1000 snd_hda_codec sysimgblt xeno_can
iTCO_vendor_support sg snd_hda_core snd_hwdep mei_me snd_pcm snd_timer mei
shpchp snd soundcore evdev pcspkr serio_raw efivars
Dec 18 14:58:13 bmm3 kernel: [  118.554017]  battery hci_uart btbcm parport_pc
btqca parport btintel bluetooth wmi video rfkill intel_lpss_acpi intel_lpss
tpm_crb acpi_als kfifo_buf button industrialio sunrpc efivarfs ip_tables
x_tables autofs4 ext4 crc16 jbd2 fscrypto mbcache sd_mod crc32c_intel i2c_i801
i2c_smbus ahci libahci xhci_pci libata xhci_hcd scsi_mod usbcore fan i2c_hid hid
fjes [last unloaded: rt_e1000e]
Dec 18 14:58:13 bmm3 kernel: [  118.556765] CPU: 5 PID: 1742 Comm: slaveinfo_rt
Tainted: G           O    4.9.51-xenomai-3.0.6-ipipe #1
Dec 18 14:58:13 bmm3 kernel: [  118.557688] Hardware name: Gigabyte Technology
Co., Ltd. To be filled by O.E.M./Q170M-D3H, BIOS F2 01/11/2016
Dec 18 14:58:13 bmm3 kernel: [  118.558628] I-pipe domain: Linux
Dec 18 14:58:13 bmm3 kernel: [  118.559567] task: ffff8d711868b140 task.stack:
ffffa6a8409d4000
Dec 18 14:58:13 bmm3 kernel: [  118.560518] RIP: 0010:[<ffffffffc0743981>]
[<ffffffffc0743981>] rt_packet_ioctl+0x1a1/0x380 [rtpacket]
Dec 18 14:58:13 bmm3 kernel: [  118.561505] RSP: 0018:ffffa6a8409d7df8  EFLAGS:
00010202
Dec 18 14:58:13 bmm3 kernel: [  118.562483] RAX: ffffa6a8409d7df8 RBX:
ffff8d7118f10800 RCX: 0000000000000000
Dec 18 14:58:13 bmm3 kernel: [  118.563471] RDX: 0000000000000000 RSI:
00007ffcc7389410 RDI: ffffa6a8409d7e08
Dec 18 14:58:13 bmm3 kernel: [  118.564472] RBP: ffffa6a8409d7ec0 R08:
26009bc300000014 R09: 000000000000005d
Dec 18 14:58:13 bmm3 kernel: [  118.565473] R10: 00000000000000e4 R11:
00000000ffff4ebc R12: 0000000000000003
Dec 18 14:58:13 bmm3 kernel: [  118.566477] R13: ffff8d7118f10940 R14:
ffffa6a8402de040 R15: 00007ffcc7389470
Dec 18 14:58:13 bmm3 kernel: [  118.567485] FS:  00007f4db6a00b80(0000)
GS:ffff8d7120300000(0000) knlGS:0000000000000000
Dec 18 14:58:13 bmm3 kernel: [  118.568516] CS:  0010 DS: 0000 ES: 0000 CR0:
000000008005003b
Dec 18 14:58:13 bmm3 kernel: [  118.569560] CR2: 00007ffcc7389470 CR3:
000000045c362000 CR4: 00000000003406e0
Dec 18 14:58:13 bmm3 kernel: [  118.570617] DR0: 0000000000000000 DR1:
0000000000000000 DR2: 0000000000000000
Dec 18 14:58:13 bmm3 kernel: [  118.571671] DR3: 0000000000000000 DR6:
00000000fffe0ff0 DR7: 0000000000000400
Dec 18 14:58:13 bmm3 kernel: [  118.572733] Stack:
Dec 18 14:58:13 bmm3 kernel: [  118.573799]  00007ffcc7389470 26009bc300000014
ffff8d7118f10800 ffffa6a8409d7ec0
Dec 18 14:58:13 bmm3 kernel: [  118.574892]  0000000000000003 ffff8d711868b140
ffffa6a8402de040 0000000000011ba0
Dec 18 14:58:13 bmm3 kernel: [  118.575987]  ffffffff9476b9a8 00007ffcc7389400
401000221868b738 0000000000000010
Dec 18 14:58:13 bmm3 kernel: [  118.577088] Call Trace:
Dec 18 14:58:13 bmm3 kernel: [  118.578180]  [<ffffffff9476b9a8>] ?
rtdm_fd_ioctl+0xa8/0x1e0
Dec 18 14:58:13 bmm3 kernel: [  118.579278]  [<ffffffff94770b20>] ?
CoBaLt_fcntl+0x10/0x10
Dec 18 14:58:13 bmm3 kernel: [  118.580377]  [<ffffffff9468298d>] ?
__ipipe_migrate_head+0x4d/0xb0
Dec 18 14:58:13 bmm3 kernel: [  118.581452]  [<ffffffff94770b20>] ?
CoBaLt_fcntl+0x10/0x10
Dec 18 14:58:13 bmm3 kernel: [  118.582541]  [<ffffffff94770b2a>] ?
CoBaLt_ioctl+0xa/0x10
Dec 18 14:58:13 bmm3 kernel: [  118.583625]  [<ffffffff947807ac>] ?
ipipe_syscall_hook+0xfc/0x2b0
Dec 18 14:58:13 bmm3 kernel: [  118.584698]  [<ffffffff946fad9a>] ?
__ipipe_notify_syscall+0xba/0x170
Dec 18 14:58:13 bmm3 kernel: [  118.585774]  [<ffffffff94b868af>] ?
pipeline_syscall+0x8/0x1b
Dec 18 14:58:13 bmm3 kernel: [  118.586836] Code: 5f c3 b9 10 00 00 00 48 89 e6
e8 7b 36 14 00 48 3d 00 f0 ff ff 77 d8 83 78 08 13 4c 8b 38 4c 8d ab 40 01 00 00
0f 86 73 01 00 00 <66> 41 83 3f 11 0f 85 68 01 00 00 41 0f b7 6f 02 66 85 ed 0f 84
Dec 18 14:58:13 bmm3 kernel: [  118.589196] RIP  [<ffffffffc0743981>]
rt_packet_ioctl+0x1a1/0x380 [rtpacket]
Dec 18 14:58:13 bmm3 kernel: [  118.590308]  RSP <ffffa6a8409d7df8>
Dec 18 14:58:13 bmm3 kernel: [  118.591414] CR2: 00007ffcc7389470
Dec 18 14:58:13 bmm3 kernel: [  118.592528] ---[ end trace 7e353ae197f2ee95 ]---

#######################################################3

So, I'm sorry, but it still fails.

And about the addr2line for this case, some help for dummies will be helpful.

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

