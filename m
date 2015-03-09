Message-ID: <54FDB495.3060303@triphase.com>
Date: Mon, 09 Mar 2015 15:56:21 +0100
From: Niels Wellens <niels.wellens@triphase.com>
MIME-Version: 1.0
References: <54EEF08B.6040905@triphase.com>	<20150226102010.GA24003@hermes.click-hack.org>	<54EF0790.3040607@triphase.com>	<54F07AC2.6000902@triphase.com>	<54F0D46F.1070006@siemens.com>	<54F56C9C.6080507@siemens.com>
 <CAPRPZsC9mPitPUmXXR6QQfAGN3UMa2u6hkVwjtO4Eoh-NzC7wA@mail.gmail.com>
In-Reply-To: <CAPRPZsC9mPitPUmXXR6QQfAGN3UMa2u6hkVwjtO4Eoh-NzC7wA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xeno3_rc3 - Watchdog detected hard LOCKUP
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>

Hi,

We have a few updates on the lockup's that we observed.

Jeroen did a dohell test on his unpatched 3.14.28 kernel and he didn't 
experienced any problems, the system was still working as expected after 
more than 100 hours of operation.

In the meanwhile, I did some further tests on my 3.16.0 ipipe kernel. I 
disabled some services (gdm3, rtkit-daemon, smbd and nmbd) and after 90 
hours of operation (latency + dohell) everything was still working 
flawlessly.  Afterwards I enabled gdm3 and rtkit-daemon services again 
and the lockup didn't occur for another 25hours (test stopped due to 
kernel panic while porting one of my RTDM drivers to xeno 3 ;-) ).
Then I continued my test where it stopped (only smbd and nmbd services 
disabled, latency + dohell running) and it was running perfectly for 114 
hours, then I enabled smbd and nmbd again and after 3 hours the hard 
lockup occurred again:

Mar  4 16:35:47 dev-x10sae kernel: [    0.000000] Initializing cgroup 
subsys cpuset
Mar  4 16:35:47 dev-x10sae kernel: [    0.000000] Initializing cgroup 
subsys cpu
Mar  4 16:35:47 dev-x10sae kernel: [    0.000000] Initializing cgroup 
subsys cpuacct
Mar  4 16:35:47 dev-x10sae kernel: [    0.000000] Linux version 
3.16.0-ipipe-v0+ (triphase@dev-x10sae) (gcc version 4.9.1 (Debian 
4.9.1-19) ) #1 SMP Thu Feb 26 12:15:32 CET 2015
Mar  4 16:35:47 dev-x10sae kernel: [    0.000000] Command line: 
BOOT_IMAGE=/boot/vmlinuz-3.16.0-ipipe-v0+ 
root=UUID=fc8ecefa-fc73-487f-a045-cffa99c38a11 ro quiet
...
Mar  9 07:35:02 dev-x10sae anacron[26338]: Job `cron.daily' terminated
Mar  9 07:35:02 dev-x10sae anacron[26338]: Normal exit (1 job run)
Mar  9 08:17:01 dev-x10sae CRON[25670]: (root) CMD (   cd / && run-parts 
--report /etc/cron.hourly)
Mar  9 08:30:17 dev-x10sae gnome-session[2611]: 
(gnome-settings-daemon:2675): GLib-CRITICAL **: Source ID 4961 was not 
found when attempting to remove it
Mar  9 09:17:01 dev-x10sae CRON[20303]: (root) CMD (   cd / && run-parts 
--report /etc/cron.hourly)
Mar  9 09:30:17 dev-x10sae gnome-session[2611]: 
(gnome-settings-daemon:2675): GLib-CRITICAL **: Source ID 4987 was not 
found when attempting to remove it
Mar  9 10:17:01 dev-x10sae CRON[14576]: (root) CMD (   cd / && run-parts 
--report /etc/cron.hourly)
Mar  9 10:30:17 dev-x10sae gnome-session[2611]: 
(gnome-settings-daemon:2675): GLib-CRITICAL **: Source ID 5017 was not 
found when attempting to remove it
Mar  9 11:17:01 dev-x10sae CRON[30596]: (root) CMD (   cd / && run-parts 
--report /etc/cron.hourly)
Mar  9 11:20:51 dev-x10sae smbd[11478]: Starting SMB/CIFS daemon: smbd.
Mar  9 11:20:56 dev-x10sae nmbd[24483]: Starting NetBIOS name server: nmbd.
Mar  9 11:30:17 dev-x10sae gnome-session[2611]: 
(gnome-settings-daemon:2675): GLib-CRITICAL **: Source ID 5043 was not 
found when attempting to remove it
Mar  9 12:17:01 dev-x10sae CRON[6674]: (root) CMD (   cd / && run-parts 
--report /etc/cron.hourly)
Mar  9 12:30:17 dev-x10sae gnome-session[2611]: 
(gnome-settings-daemon:2675): GLib-CRITICAL **: Source ID 5075 was not 
found when attempting to remove it
Mar  9 13:17:01 dev-x10sae CRON[6801]: (root) CMD (   cd / && run-parts 
--report /etc/cron.hourly)
Mar  9 13:30:17 dev-x10sae gnome-session[2611]: 
(gnome-settings-daemon:2675): GLib-CRITICAL **: Source ID 5464 was not 
found when attempting to remove it
Mar  9 14:02:54 dev-x10sae kernel: [422579.748685] Watchdog detected 
hard LOCKUP on cpu 5
Mar  9 14:02:54 dev-x10sae kernel: [422583.196923] INFO: rcu_sched 
self-detected stall on CPUINFO: rcu_sched self-detected stall on 
CPUINFO: rcu_sched self-detected stall on CPU {
Mar  9 14:02:54 dev-x10sae kernel: [422583.196927]  {
Mar  9 14:02:54 dev-x10sae kernel: [422583.196928]  2
Mar  9 14:02:54 dev-x10sae kernel: [422583.196928]  1
Mar  9 14:02:54 dev-x10sae kernel: [422583.196929] }
Mar  9 14:02:54 dev-x10sae kernel: [422583.196930] }
Mar  9 14:02:54 dev-x10sae kernel: [422583.196930]  (t=5250 jiffies 
g=21756356 c=21756355 q=15258)
Mar  9 14:02:54 dev-x10sae kernel: [422583.196931]  (t=5250 jiffies 
g=21756356 c=21756355 q=15258)
Mar  9 14:02:54 dev-x10sae kernel: [422583.196932] sending NMI to all CPUs:
Mar  9 14:02:54 dev-x10sae kernel: [422583.197098]  { 6}  (t=5250 
jiffies g=21756356 c=21756355 q=15258)

Is it possible that the kernel part of Samba (CIFS?) is holding the page 
allocation spinlock that Jan has mentioned?

For now I will enable CONFIG_FRAME_POINTER  and connect a serial header 
(just arrived) in order to have a serial terminal, hopefully this gives 
some more debugging information.

Thanks in advance,
Best regards,
Niels

Jeroen Van den Keybus schreef op 04/03/2015 om 21:35:
> Hello,
>
>
> We have an additional machine running 3.14.28 with the patch present
> in 3.0-rc3. On this machine, identical save for the CPU which is a
> Core i5 and a Mint 17.1 distro (instead of Core i7 and Debian), I got
> the following issue while running dohell for 20 hours (Linux Mint 17.1
> Rebecca (GNU/Linux 3.14.28-cobalt x86_64):
>
> Mar  4 15:40:30 x10sae kernel: [71029.417655] ------------[ cut here
> ]------------
> Mar  4 15:40:30 x10sae kernel: [71029.417661] WARNING: CPU: 2 PID:
> 2313 at fs/dcache.c:361 d_shrink_del+0x71/0x80()
> Mar  4 15:40:30 x10sae kernel: [71029.417662] Modules linked in:
> rfcomm bnep bluetooth 6lowpan_iphc snd_hda_codec_realtek
> snd_hda_codec_hdmi binfmt_misc snd_hda_codec_generic snd_hda_intel
> snd_hda_codec x86_pkg_temp_thermal intel_powerclamp kvm_intel
> snd_hwdep snd_pcm kvm snd_seq_midi hid_generic snd_seq_midi_event
> snd_rawmidi snd_seq dm_multipath scsi_dh snd_seq_device usbhid
> crct10dif_pclmul snd_timer crc32_pclmul ghash_clmulni_intel
> aesni_intel hid snd mei_me aes_x86_64 parport_pc lrw mei gf128mul
> ppdev glue_helper nct6775 ablk_helper cryptd hwmon_vid soundcore
> coretemp serio_raw lpc_ich lp mac_hid parport dm_mirror dm_region_hash
> dm_log i915 drm_kms_helper drm firewire_ohci igb e1000e ahci libahci
> firewire_core dca ptp i2c_algo_bit crc_itu_t pps_core video
> Mar  4 15:40:30 x10sae kernel: [71029.417697] CPU: 2 PID: 2313 Comm:
> dohell Not tainted 3.14.28-cobalt #4
> Mar  4 15:40:30 x10sae kernel: [71029.417699] Hardware name:
> Supermicro X10SAE/X10SAE, BIOS 2.0a 05/09/2014
> Mar  4 15:40:30 x10sae kernel: [71029.417700]  0000000000000009
> ffff880202a1bc98 ffffffff81729ffa 0000000000000000
> Mar  4 15:40:30 x10sae kernel: [71029.417702]  ffff880202a1bcd0
> ffffffff81054c8d ffff8801fc8fad80 ffff880202a1bd48
> Mar  4 15:40:30 x10sae kernel: [71029.417704]  ffff8801fc8fad80
> ffff8801fc8fad80 0000000000002944 ffff880202a1bce0
> Mar  4 15:40:30 x10sae kernel: [71029.417706] Call Trace:
> Mar  4 15:40:30 x10sae kernel: [71029.417711]  [<ffffffff81729ffa>]
> dump_stack+0x45/0x56
> Mar  4 15:40:30 x10sae kernel: [71029.417714]  [<ffffffff81054c8d>]
> warn_slowpath_common+0x7d/0xa0
> Mar  4 15:40:30 x10sae kernel: [71029.417715]  [<ffffffff81054d6a>]
> warn_slowpath_null+0x1a/0x20
> Mar  4 15:40:30 x10sae kernel: [71029.417717]  [<ffffffff812038b1>]
> d_shrink_del+0x71/0x80
> Mar  4 15:40:30 x10sae kernel: [71029.417719]  [<ffffffff81204d48>]
> shrink_dentry_list+0x68/0xd0
> Mar  4 15:40:30 x10sae kernel: [71029.417721]  [<ffffffff81205af8>]
> shrink_dcache_parent+0x28/0x70
> Mar  4 15:40:30 x10sae kernel: [71029.417724]  [<ffffffff81259f96>]
> proc_flush_task+0xb6/0x1b0
> Mar  4 15:40:30 x10sae kernel: [71029.417726]  [<ffffffff81055a80>]
> release_task+0x30/0x460
> Mar  4 15:40:30 x10sae kernel: [71029.417728]  [<ffffffff8105676a>]
> wait_consider_task+0x8ba/0xac0
> Mar  4 15:40:30 x10sae kernel: [71029.417729]  [<ffffffff81056a70>]
> do_wait+0x100/0x240
> Mar  4 15:40:30 x10sae kernel: [71029.417731]  [<ffffffff81057bc4>]
> SyS_wait4+0x64/0xe0
> Mar  4 15:40:30 x10sae kernel: [71029.417733]  [<ffffffff81055950>] ?
> task_stopped_code+0x60/0x60
> Mar  4 15:40:30 x10sae kernel: [71029.417736]  [<ffffffff8173a38c>]
> system_call_fastpath+0x1a/0x1f
> Mar  4 15:40:30 x10sae kernel: [71029.417737] ---[ end trace
> 3f4325c9f8f4ccbe ]---
>
> followed 25s later by a lockup detection:
>
> Mar  4 15:40:55 x10sae kernel: [71054.723575] BUG: soft lockup - CPU#2
> stuck for 22s! [dohell:2313]
> Mar  4 15:40:55 x10sae kernel: [71054.723594] Modules linked in:
> rfcomm bnep bluetooth 6lowpan_iphc snd_hda_codec_realtek
> snd_hda_codec_hdmi binfmt_misc snd_hda_codec_generic snd_hda_intel
> snd_hda_codec x86_pkg_temp_thermal intel_powerclamp kvm_intel
> snd_hwdep snd_pcm kvm snd_seq_midi hid_generic snd_seq_midi_event
> snd_rawmidi snd_seq dm_multipath scsi_dh snd_seq_device usbhid
> crct10dif_pclmul snd_timer crc32_pclmul ghash_clmulni_intel
> aesni_intel hid snd mei_me aes_x86_64 parport_pc lrw mei gf128mul
> ppdev glue_helper nct6775 ablk_helper cryptd hwmon_vid soundcore
> coretemp serio_raw lpc_ich lp mac_hid parport dm_mirror dm_region_hash
> dm_log i915 drm_kms_helper drm firewire_ohci igb e1000e ahci libahci
> firewire_core dca ptp i2c_algo_bit crc_itu_t pps_core video
> Mar  4 15:40:55 x10sae kernel: [71054.723627] CPU: 2 PID: 2313 Comm:
> dohell Tainted: G        W    3.14.28-cobalt #4
> Mar  4 15:40:55 x10sae kernel: [71054.723628] Hardware name:
> Supermicro X10SAE/X10SAE, BIOS 2.0a 05/09/2014
> Mar  4 15:40:55 x10sae kernel: [71054.723629] task: ffff88002b19bb40
> ti: ffff880202a18000 task.ti: ffff880202a18000
> Mar  4 15:40:55 x10sae kernel: [71054.723631] RIP:
> 0010:[<ffffffff8120389e>]  [<ffffffff8120389e>] d_shrink_del+0x5e/0x80
> Mar  4 15:40:55 x10sae kernel: [71054.723635] RSP:
> 0000:ffff880202a1bcf0  EFLAGS: 00000202
> Mar  4 15:40:55 x10sae kernel: [71054.723636] RAX: 0000000000000000
> RBX: 0000000000000000 RCX: 0000000000000000
> Mar  4 15:40:55 x10sae kernel: [71054.723636] RDX: 0000000000000000
> RSI: 0000000000000000 RDI: 0000000000000000
> Mar  4 15:40:55 x10sae kernel: [71054.723637] RBP: ffff880202a1bcf8
> R08: 0000000000000000 R09: 0000000000000000
> Mar  4 15:40:55 x10sae kernel: [71054.723638] R10: 0000000000000000
> R11: 0000000000000000 R12: 0000000000000000
> Mar  4 15:40:55 x10sae kernel: [71054.723639] R13: 0000000000000000
> R14: 0000000000000000 R15: 0000000000000000
> Mar  4 15:40:55 x10sae kernel: [71054.723640] FS:
> 00007f8f128e0740(0000) GS:ffff88021fb00000(0000)
> knlGS:0000000000000000
> Mar  4 15:40:55 x10sae kernel: [71054.723641] CS:  0010 DS: 0000 ES:
> 0000 CR0: 000000008005003b
> Mar  4 15:40:55 x10sae kernel: [71054.723642] CR2: 00007f8f12495308
> CR3: 00000001ebb72000 CR4: 00000000001407e0
> Mar  4 15:40:55 x10sae kernel: [71054.723643] DR0: 0000000000000000
> DR1: 0000000000000000 DR2: 0000000000000000
> Mar  4 15:40:55 x10sae kernel: [71054.723643] DR3: 0000000000000000
> DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Mar  4 15:40:55 x10sae kernel: [71054.723644] I-pipe domain Linux
> Mar  4 15:40:55 x10sae kernel: [71054.723645] Stack:
> Mar  4 15:40:55 x10sae kernel: [71054.723646]  ffff8801fc8fae00
> ffff880202a1bd30 ffffffff81204d48 ffff8801fc8fae00
> Mar  4 15:40:55 x10sae kernel: [71054.723648]  ffff880202a1bd48
> ffff8800d492d900 ffff8802140d22a0 ffff8800d492d900
> Mar  4 15:40:55 x10sae kernel: [71054.723650]  ffff880202a1bd70
> ffffffff81205af8 ffff8800d492d900 ffff88001f936ec0
> Mar  4 15:40:55 x10sae kernel: [71054.723652] Call Trace:
> Mar  4 15:40:55 x10sae kernel: [71054.723655]  [<ffffffff81204d48>]
> shrink_dentry_list+0x68/0xd0
> Mar  4 15:40:55 x10sae kernel: [71054.723657]  [<ffffffff81205af8>]
> shrink_dcache_parent+0x28/0x70
> Mar  4 15:40:55 x10sae kernel: [71054.723661]  [<ffffffff81259f96>]
> proc_flush_task+0xb6/0x1b0
> Mar  4 15:40:55 x10sae kernel: [71054.723664]  [<ffffffff81055a80>]
> release_task+0x30/0x460
> Mar  4 15:40:55 x10sae kernel: [71054.723666]  [<ffffffff8105676a>]
> wait_consider_task+0x8ba/0xac0
> Mar  4 15:40:55 x10sae kernel: [71054.723667]  [<ffffffff81056a70>]
> do_wait+0x100/0x240
> Mar  4 15:40:55 x10sae kernel: [71054.723670]  [<ffffffff81057bc4>]
> SyS_wait4+0x64/0xe0
> Mar  4 15:40:55 x10sae kernel: [71054.723672]  [<ffffffff81055950>] ?
> task_stopped_code+0x60/0x60
> Mar  4 15:40:55 x10sae kernel: [71054.723675]  [<ffffffff8173a38c>]
> system_call_fastpath+0x1a/0x1f
> Mar  4 15:40:55 x10sae kernel: [71054.723676] Code: 08 48 89 0a 48 89
> 83 80 00 00 00 81 23 ff fb f7 ff 48 89 83 88 00 00 00 5b 65 48 ff 0c
> 25 40 30 05 00 5d c3 80 3d 29 fd ad 00 00 <75> bb be 69 01 00 00 48 c7
> c7 20 4c a9 81 e8 9f 14 e5 ff c6 05
>
> I've attached the entire syslog to this message. Linux eventually
> starts killing off processes until it reaches a state of
> unconsciousness, gasping for RAM I guess.
>
> The machine does respond to pings, even thousands per second, but is
> otherwise dead. Also initiates TCP for ssh, but session is not
> established. No response to Alt-SysRq's. Impossible to determine if
> realtime tasks are still running. NumLock ok, but CapsLock and
> ScrollLock not. Cannot be reset using Ctrl-Alt-Del.
>
>
> I would like to know if there is additional logging that I could
> include that would be helpful ?
>
>
> I was also thinking of running dohell on the unpatched kernel.
>
>
> Jeroen.
>
> 2015-03-03 9:11 GMT+01:00 Jan Kiszka <jan.kiszka@siemens.com>:
>> On 2015-02-27 21:32, Jan Kiszka wrote:
>>> On 2015-02-27 15:10, Niels Wellens wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> Yesterday I installed a Core-i7 based pc (4770 CPU - C226 chipset) with
>>>>>>> software configuration:
>>>>>>> - Debian Jessie RC1
>>>>>>> - kernel 3.16.0-rc7 (.config in attachment)
>>>>>> Well, please try again with a kernel which is a real release and not
>>>>>> a release candidate, to rule out any mainline kernel issue.
>>>>>> --
>>>>>>                          Gilles.
>>>>> Thanks Gilles, sorry I overlooked the fact that I was using an rc. The
>>>>> system is now up and running with an ipipe patched 3.16.0 kernel, I
>>>>> will let you know if I experience the same issues with this kernel.
>>>>> --
>>>>> Niels
>>>> Hi,
>>>>
>>>> I experience the same kind of lockup with the ipipe patched 3.16.0
>>>> kernel (used repo:
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git).
>>>> I first thought the problem was solved but after more than 20 hours of
>>>> operation (latency test + dohell load) it occurred again. This afternoon
>>>> it occurred again after 1 hour of operation (syslog + config file used
>>>> during kernel build in attachement).
>>>>
>>>> Any advice on what to test/change next?
>>> Your machine gets stuck on a spinlock involved in page allocations, it
>>> seems. We need to find out who's holding it and why he's not releasing
>>> it anymore. I'll try to reproduce the issue with your config next week.
>>>
>>> If you want to collect further data: CONFIG_FRAME_POINTER may give
>>> better backtraces. You could also try to send a <break>l
>>> (show-backtrace-all-active-cpus) via the serial console to the system.
>>> Maybe we can get a better pictures that way.
>> Another thing to try out: Is the bug reproducible for you with otherwise
>> identical setup when using a recent 3.14 ipipe patch?
>>
>> Jan
>>
>> --
>> Siemens AG, Corporate Technology, CT RTC ITP SES-DE
>> Corporate Competence Center Embedded Linux
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> http://www.xenomai.org/mailman/listinfo/xenomai


