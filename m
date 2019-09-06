Subject: Re: kernel Oops when rmmod rtpacket
References: <d345250b-185f-2d76-c830-4233fb14f1ad@iit.it>
 <2fc01f0d-b17d-65d0-abf6-91f9e4429f7b@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <790ed632-fda9-b878-b68e-0344538d30db@siemens.com>
Date: Fri, 6 Sep 2019 19:38:21 +0200
MIME-Version: 1.0
In-Reply-To: <2fc01f0d-b17d-65d0-abf6-91f9e4429f7b@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>, alessio margan <alessio.margan@iit.it>, xenomai@xenomai.org

On 06.09.19 19:07, Quirin Gylstorff via Xenomai wrote:
> 
> 
> On 9/6/19 4:36 PM, alessio margan via Xenomai wrote:
>> Hi all,
>>
>> I got this when running the script ec_xeno.sh restart a couple of times
>>
>> I am using branch next and the prper ipipe patch
>>
>> Linux advantech 4.19.60-xeno-ipipe-next #2 SMP Thu Sep 5 17:06:12 CEST 2019 
>> x86_64 GNU/Linux
>>
>> this is dmesg output
>>
>>
>> [  649.204243] igb 0000:01:00.0: removed PHC on enp1s0
>> [  649.316995] RTnet: registered rteth0
>> [  649.316998] rt_igb 0000:01:00.0: Intel(R) Gigabit Ethernet Network Connection
>> [  649.317000] rt_igb 0000:01:00.0: rteth0: (PCIe:2.5Gb/s:Width x1) 
>> c4:00:ad:2a:45:be
>> [  649.317041] rt_igb 0000:01:00.0: rteth0: PBA No: 000200-000
>> [  649.317043] rt_igb 0000:01:00.0: Using MSI-X interrupts. 1 rx queue(s), 1 
>> tx queue(s)
>> [  650.154440] BUG: unable to handle kernel paging request at ffffffffc0715780
>> [  650.154443] PGD 1a020c067 P4D 1a020c067 PUD 1a020e067 PMD 8440b3067 PTE 
>> 848724061
>> [  650.154448] Oops: 0003 [#1] SMP PTI
>> [  650.154450] CPU: 3 PID: 1117 Comm: rmmod Not tainted 
>> 4.19.60-xeno-ipipe-next #2
>> [  650.154451] Hardware name:  /, BIOS 5.12 11/27/2018
>> [  650.154452] I-pipe domain: Linux
>> [  650.154456] RIP: 0010:rt_packet_close+0xe0/0x180 [rtpacket]
>> [  650.154457] Code: 0f 92 c5 31 c0 f0 41 0f b1 34 24 85 c0 75 70 e8 26 dc 01 
>> df 4c 8b bb b0 00 00 00 4d 85 ff 74 11 49 8b 07 48 89 83 b0 00 00 00 <49> c7 
>> 07 00 00 00 00 c6 83 c0 00 00 00 00 e8 ed f4 01 df 4c 89 f0
>> [  650.154459] RSP: 0018:ffffa3db45057e10 EFLAGS: 00010282
>> [  650.154460] RAX: 56415741e5894855 RBX: ffffffffc0718568 RCX: ffffffffa0017fa0
>> [  650.154462] RDX: 0000000000000002 RSI: 0000000000000001 RDI: 0000000000000000
>> [  650.154463] RBP: ffffa3db45057e38 R08: ffffffffc0718568 R09: ffff9f9b8d7a2440
>> [  650.154464] R10: 000000000000022d R11: 8080808080808080 R12: ffffffffc0718628
>> [  650.154465] R13: dead000000000200 R14: 000000000005ef88 R15: ffffffffc0715780
>> [  650.154466] FS:  00007fa8e7770200(0000) GS:ffff9f9b8d700000(0000) 
>> knlGS:0000000000000000
>> [  650.154468] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  650.154469] CR2: ffffffffc0715780 CR3: 0000000829b90006 CR4: 00000000003606e0
>> [  650.154470] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [  650.154472] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [  650.154473] Call Trace:
>> [  650.154478]  rtdm_dev_unregister+0x261/0x450
>> [  650.154480]  ? call_rcu_sched+0x12/0x20
>> [  650.154483]  ? __fput+0x10f/0x1f0
>> [  650.154485]  ? find_module_all+0x64/0x90
>> [  650.154487]  rt_packet_proto_release+0x10/0xfc0 [rtpacket]
>> [  650.154489]  __x64_sys_delete_module+0x1a7/0x280
>> [  650.154491]  do_syscall_64+0x6d/0x250
>> [  650.154494]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [  650.154495] RIP: 0033:0x7fa8e7890dd7
>> [  650.154497] Code: 73 01 c3 48 8b 0d b9 10 0c 00 f7 d8 64 89 01 48 83 c8 ff 
>> c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 
>> 01 f0 ff ff 73 01 c3 48 8b 0d 89 10 0c 00 f7 d8 64 89 01 48
>> [  650.154498] RSP: 002b:00007ffda1517428 EFLAGS: 00000206 ORIG_RAX: 
>> 00000000000000b0
>> [  650.154500] RAX: ffffffffffffffda RBX: 0000563ebe5b87b0 RCX: 00007fa8e7890dd7
>> [  650.154501] RDX: 000000000000000a RSI: 0000000000000800 RDI: 0000563ebe5b8818
>> [  650.154502] RBP: 0000000000000000 R08: 00007ffda15163a1 R09: 0000000000000000
>> [  650.154503] R10: 00007fa8e7902ae0 R11: 0000000000000206 R12: 00007ffda1517650
>> [  650.154504] R13: 00007ffda15197c9 R14: 0000563ebe5b8260 R15: 0000563ebe5b87b0
>> [  650.154506] Modules linked in: rtpacket(-) rfcomm cmac joydev bnep arc4 
>> hid_generic usbhid hid nls_ascii nls_cp437 vfat fat iwlmvm mac80211 iwlwifi 
>> btusb btrtl btbcm btintel bluetooth evdev jitterentropy_rng hmac i915 drbg 
>> drm_kms_helper cfbfillrect rt_igb ecdh_generic cfg80211 syscopyarea cfbimgblt 
>> sysfillrect sysimgblt fb_sys_fops cfbcopyarea rtnet fb font efi_pstore fbdev 
>> drm x86_pkg_temp_thermal mei_me intel_powerclamp drm_panel_orientation_quirks 
>> mei efivars crc32c_intel intel_pch_thermal video button sunrpc efivarfs 
>> autofs4 e1000e xhci_pci ahci igb xhci_hcd libahci i2c_algo_bit dca i2c_i801 
>> ptp pps_core libata usbcore usb_common fan
>> [  650.154549] CR2: ffffffffc0715780
>> [  650.246120] ---[ end trace acf460415c3336e5 ]---
>>
>> Any ideas ?
> 
> Hi Alessio,
> 
> I would guess it is the same error as in [1].
> 
> [1] https://xenomai.org/pipermail/xenomai/2019-September/041459.html
> 

I've just pulled that commit from next. If you retry and it works, then we know 
for sure.

Thanks for reporting,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

