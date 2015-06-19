Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
From: Michael Haberler <haberlerm@gmail.com>
In-Reply-To: <5584079E.2090000@siemens.com>
Date: Fri, 19 Jun 2015 15:27:01 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <316F216B-1C02-4EE7-92B8-10FC6DCF6761@gmail.com>
References: <7B9254AC-C035-4D61-884E-8C9B3706A22B@gmail.com>
 <5581BE6F.4030607@siemens.com>
 <624126A3-294C-48BF-A099-2AA8E000FE11@gmail.com>
 <5584079E.2090000@siemens.com>
Subject: Re: [Xenomai] RTDM-native brushup
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiska <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>


> Am 19.06.2015 um 14:14 schrieb Jan Kiszka <jan.kiszka@siemens.com>:
>=20
..

> Serial logs preferred (the top of the error message is missing)...

(wild guess: spinlocks around here: =
https://github.com/mhaberler/rtdm-native/blob/6e13d330b69608cc6480a21cf0a2=
458aeeae86b9/ksrc/skins/rtdm/native/drvlib.c#L215-L260)

a systemd configuration safari later - serial console output:

root@j1900:/home/mah/rtdm-native/examples/rtdm-native# ./rtdmtest -s -c =
10

console:

> j1900 login: [  595.174003] starting RTDM services.
> [  600.472950] __rtdmtest_init: registering device rttest0, err=3D250
> [  678.281348] rtdmtest_close state=3D0x4
> [  697.224846] ------------[ cut here ]------------
> [  697.224850] kernel BUG at kernel/locking/rtmutex.c:996!
> [  697.224855] invalid opcode: 0000 [#1] PREEMPT SMP
> [  697.224919] Modules linked in: rtdmtest(O) rtdm(O) rpcsec_gss_krb5 =
nfsv4 binfmt_misc cfg80211 rfkill hid_generic nfsd iTCO_wdt =
iTCO_vendor_support auth_rpcgss oid_registry nfs_acl evdev nfs ppdev =
lockd grace fscache sunrpc usbhid hid coretemp kvm_intel kvm =
snd_hda_codec_hdmi snd_hda_codec_realtek psmouse serio_raw =
snd_hda_codec_generic pcspkr snd_hda_intel snd_hda_controller =
snd_hda_codec lpc_ich i2c_i801 snd_hwdep mfd_core snd_pcm snd_timer snd =
shpchp soundcore battery parport_pc parport i915 video drm_kms_helper =
acpi_cpufreq drm i2c_algo_bit button i2c_core processor loop fuse =
autofs4 ext4 crc16 jbd2 mbcache microcode sg sd_mod xhci_pci xhci_hcd =
crc32c_intel ahci libahci libata r8169 usbcore fan thermal mii =
usb_common scsi_mod thermal_sys
> [  697.224925] CPU: 2 PID: 1495 Comm: rtdmtest Tainted: G           O  =
 3.18.13-rt10mah+ #1
> [  697.224927] Hardware name: Gigabyte Technology Co., Ltd. To be =
filled by O.E.M./J1900N-D3V, BIOS F3 04/29/2014
> [  697.224931] task: f18a8660 ti: f18f2000 task.ti: f18f2000
> [  697.224934] EIP: 0060:[<c13270c3>] EFLAGS: 00010246 CPU: 2
> [  697.224942] EIP is at rt_spin_lock_slowlock+0x54/0x190
> [  697.224944] EAX: f18a8660 EBX: f353fec0 ECX: 00000000 EDX: f18a8660
> [  697.224947] ESI: f18a8660 EDI: 00000001 EBP: f18f3e28 ESP: f18f3e1c
> [  697.224949]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
> [  697.224952] CR0: 8005003b CR2: 08156be0 CR3: 3089d000 CR4: 001007d0
> [  697.224953] Stack:
> [  697.224960]  c1049433 f4cbb960 00000002 f18f3e28 00000046 c153ece4 =
f18f3e34 00000691
> [  697.224966]  f18a8660 00000000 c153e8e0 00000001 c1030d9b f353fec0 =
f18f3e78 f353feb8
> [  697.224972]  f18a8660 c1055bb3 f353feb4 f353fec0 f86b9834 00000691 =
00000000 00000001
> [  697.224973] Call Trace:
> [  697.224980]  [<c1049433>] ? ttwu_do_wakeup+0x36/0xf7
> [  697.224986]  [<c1030d9b>] ? pin_current_cpu+0x1c/0x12b
> [  697.224992]  [<c1055bb3>] ? add_wait_queue_exclusive+0x15/0x37
> [  697.225000]  [<f86b9834>] ? _rtdm_sem_down+0x57/0x122 [rtdm]
> [  697.225005]  [<c104bd2f>] ? wake_up_state+0x7/0x7
> [  697.225011]  [<f86fb5ec>] ? rtdmtest_ioctl+0x318/0x4fd [rtdmtest]
> [  697.225018]  [<c1022ab0>] ? smp_apic_timer_interrupt+0x22/0x2b
> [  697.225023]  [<c1328979>] ? apic_timer_interrupt+0x2d/0x34
> [  697.225030]  [<f86b9c48>] ? _rtdm_chrdev_ioctl+0x23/0x3e [rtdm]
> [  697.225035]  [<f86b9c25>] ? rtdm_context_get+0x3/0x3 [rtdm]
> [  697.225041]  [<c10fde26>] ? do_vfs_ioctl+0x384/0x440
> [  697.225045]  [<c104af4a>] ? _sched_setscheduler+0x6a/0x71
> [  697.225050]  [<c1104a52>] ? __fget+0x4c/0x52
> [  697.225054]  [<c10fdf26>] ? SyS_ioctl+0x44/0x66
> [  697.225059]  [<c13280f0>] ? sysenter_do_call+0x12/0x12
> [  697.225100] Code: 8b 35 74 d6 53 c1 e8 2d 0a 00 00 31 c9 89 f2 6a =
01 89 d8 e8 60 24 d3 ff 5f 85 c0 0f 85 37 01 00 00 8b 43 0c 83 e0 fe 39 =
c6 75 02 <0f> 0b 8d be dc 04 00 00 89 f8 e8 13 0a 00 00 8b 06 89 46 04 =
64
> [  697.225106] EIP: [<c13270c3>] rt_spin_lock_slowlock+0x54/0x190 =
SS:ESP 0068:f18f3e1c


