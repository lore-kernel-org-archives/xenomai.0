Date: Thu, 26 Apr 2018 19:34:17 +0300 (EEST)
From: =?windows-1251?B?2OXi9+Xt6u4g0uDw4PEgw/Do4+7w/OXi6Pc=?=
 <shevchenko.taras@triolcorp.com.ua>
Message-ID: <2086272052.3682610.1524760457344.JavaMail.zimbra@triolcorp.com.ua>
In-Reply-To: <6b8f182d-b243-0d6b-8f2b-5531f3f99608@siemens.com>
References: <588276150.3283019.1524677009807.JavaMail.zimbra@triolcorp.com.ua>
 <6b8f182d-b243-0d6b-8f2b-5531f3f99608@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] rtnet 8168g 8168h master -slave
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>

do you mean NAPI and polling mechanism ?

=D1 =F3=E2=E0=E6=E5=ED=E8=E5=EC =E8 =ED=E0=E4=E5=E6=E4=EE=E9 =ED=E0 =F1=EE=
=F2=F0=F3=E4=ED=E8=F7=E5=F1=F2=E2=EE,
=D8=E5=E2=F7=E5=ED=EA=EE =D2.=C3.

----- Original Message -----
From: "Jan Kiszka" <jan.kiszka@siemens.com>
To: "=D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=E3=EE=F0=FC=E5=E2=
=E8=F7" <shevchenko.taras@triolcorp.com.ua>, "xenomai" <xenomai@xenomai.org=
>
Cc: "Greg Gallagher" <greg@embeddedgreg.com>
Sent: =D7=E5=F2=E2=E5=F0=E3, 26 =C0=EF=F0=E5=EB=FC 2018 =E3 19:26:45
Subject: Re: rtnet 8168g 8168h master -slave

On 2018-04-25 19:23, =D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=E3=
=EE=F0=FC=E5=E2=E8=F7 wrote:
> Hi!
> I change driver=A0 and try to make=A0 master - slave configuration
> its connected
> Below logs from slave (with i pipe debug turns on) =A0=A0=A0 TDMA master
> parametrs are cycle 500=A0 offset 50
> Question is I get ping master -slave about 400 mks=A0 but some times
> 800-900=A0 it is not convenient for me
> How I can check driver is robust ?
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *** RTnet for Xenomai v3.0.6 *=
**
>=20
> [ 7204.543497] RTnet: initialising real-time networking
> [ 7204.570113] call rtl8169_init_one
> [ 7204.570115] rt_r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
> [ 7204.570361] rt_r8169 0000:01:00.0: can't disable ASPM; OS doesn't
> have ASPM control
> [ 7204.570511] call rtl_init_jumbo_ops EDIT
> [ 7204.571066] RTnet: registered rteth0
> [ 7204.571075] RTL8168h/8111h at 0xffffa420c068f000, 30:9c:23:20:50:2b,
> XID 14100880 IRQ 16
> [ 7204.571077] jumbo features [frames: 9200 bytes, tx checksumming: ko]
> [ 7204.571768] call rtl8169_remove_one
> [ 7204.571777] RTnet: unregistered rteth0
> [ 7204.572820] call rtl8169_init_one
> [ 7204.572823] rt_r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
> [ 7204.573003] rt_r8169 0000:01:00.0: can't disable ASPM; OS doesn't
> have ASPM control
> [ 7204.573142] call rtl_init_jumbo_ops EDIT
> [ 7204.573262] RTnet: registered rteth0
> [ 7204.573270] RTL8168h/8111h at 0xffffa420c0699000, 30:9c:23:20:50:2b,
> XID 14100880 IRQ 16
> [ 7204.573271] jumbo features [frames: 9200 bytes, tx checksumming: ko]
> [ 7204.592432] initializing loopback...
> [ 7204.592443] RTnet: registered rtlo
> [ 7204.608976] RTcfg: init real-time configuration distribution protocol
> [ 7204.621592] RTmac: init realtime media access control
> [ 7204.633927] RTmac/TDMA: init time division multiple access control
> mechanism
> [ 7204.644493] call rtl8169_alloc_rx_data
> ...
> [ 7204.644860] call rtl8169_alloc_rx_data
> [ 7204.644861] call rtl_lookup_firmware_name
> [ 7204.644887] call rtl_check_firmware
> [ 7204.658395] call rtl8169_set_speed
> [ 7204.658831] call rtl8169_set_features
> [ 7204.658849] call rtl8169_change_mtu
> [ 7204.658982] call rtl_hw_start
> [ 7204.658984] call rtl_hw_start_8168
> [ 7204.659106] call add rtl_hw_start_8168h_1
> [ 7204.674722] ModemManager[29297]: segfault at 0 ip 0000000000431ab3 sp
> 00007ffdbb0f18e0 error 4 in ModemManager[400000+103000]
> [ 7204.842539] link rteth down
> [ 7204.842541] ------------[ cut here ]------------
> [ 7204.842549] WARNING: CPU: 1 PID: 31117 at ./include/linux/ipipe.h:232
> __rtl8169_check_link_status+0x2f3/0x340 [rt_r8169]
> [ 7204.842551] Modules linked in: tdma rtmac rtcfg rt_loopback rtpacket
> rtudp rt_r8169(OE) rtipv4 rtnet uas usb_storage xt_CHECKSUM
> iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat
> nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack
> nf_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp bridge stp llc
> ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter
> ip_tables x_tables pci_stub vboxpci(OE) vboxnetadp(OE) vboxnetflt(OE)
> vboxdrv(OE) dm_crypt snd_hda_codec_hdmi snd_hda_codec_realtek uvcvideo
> snd_hda_codec_generic snd_hda_intel snd_hda_codec intel_rapl
> videobuf2_vmalloc videobuf2_memops x86_pkg_temp_thermal videobuf2_v4l2
> intel_powerclamp videobuf2_core snd_usb_audio coretemp videodev
> snd_hda_core kvm_intel snd_usbmidi_lib snd_hwdep kvm snd_pcm
> snd_seq_midi media snd_seq_midi_event
> [ 7204.842632]=A0 snd_rawmidi snd_seq joydev input_leds snd_seq_device
> snd_timer snd mei_me irqbypass soundcore mei shpchp serio_raw
> binfmt_misc mac_hid ib_iser rdma_cm iw_cm ib_cm ib_core configfs
> iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi parport_pc ppdev lp
> parport autofs4 btrfs raid10 raid456 async_raid6_recov async_memcpy
> async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath
> linear hid_generic usbhid hid i915 mxm_wmi crct10dif_pclmul crc32_pclmul
> ghash_clmulni_intel i2c_algo_bit drm_kms_helper aesni_intel aes_x86_64
> syscopyarea lrw sysfillrect glue_helper sysimgblt ablk_helper
> fb_sys_fops cryptd drm psmouse mii ahci libahci video wmi fjes [last
> unloaded: r8169]
> [ 7204.842726] CPU: 1 PID: 31117 Comm: rtifconfig Tainted: G=A0=A0=A0=A0=
=A0=A0=A0 W=A0
> OE=A0=A0 4.9.90-xenomai-pc #1
> [ 7204.842728] Hardware name: MSI MS-7996/H110M PRO-VD (MS-7996), BIOS
> 2.C0 04/20/2017
> [ 7204.842729] I-pipe domain: Linux
> [ 7204.842731]=A0 ffffa420c1503c08 ffffffff98420276 0000000000000000
> 0000000000000000
> [ 7204.842736]=A0 ffffa420c1503c48 ffffffff980750fb 000000e800000001
> 00000000000570c8
> [ 7204.842740]=A0 0000000000057000 ffff8fd969065000 ffff8fd969065220
> ffffa420c0699000
> [ 7204.842746] Call Trace:
> [ 7204.842770]=A0 [<ffffffff98420276>] dump_stack+0xa9/0xd3
> [ 7204.842779]=A0 [<ffffffff980750fb>] __warn+0xcb/0xf0
> [ 7204.842782]=A0 [<ffffffff9807522d>] warn_slowpath_null+0x1d/0x20
> [ 7204.842786]=A0 [<ffffffffc0aca913>]
> __rtl8169_check_link_status+0x2f3/0x340 [rt_r8169]
> [ 7204.842789]=A0 [<ffffffffc0acc4f0>] rtl8169_open+0x5c0/0xc80 [rt_r8169=
]
> [ 7204.842796]=A0 [<ffffffffc0180517>] rtdev_open+0x37/0x80 [rtnet]
> [ 7204.842799]=A0 [<ffffffff98859167>] ? mutex_lock_interruptible+0x17/0x=
50
> [ 7204.842803]=A0 [<ffffffffc0180acc>] rtnet_core_ioctl+0x1fc/0x5b0 [rtne=
t]
> [ 7204.842806]=A0 [<ffffffffc0180879>] rtnet_ioctl+0x109/0x160 [rtnet]
> [ 7204.842809]=A0 [<ffffffff98230887>] ? kmem_cache_alloc+0xd7/0x1b0
> [ 7204.842812]=A0 [<ffffffff9825b9d4>] do_vfs_ioctl+0xa4/0x5e0
> [ 7204.842815]=A0 [<ffffffff9805b1ee>] ? __do_page_fault+0x28e/0x510
> [ 7204.842817]=A0 [<ffffffff982575a3>] ? putname+0x53/0x60
> [ 7204.842820]=A0 [<ffffffff9825bf89>] SyS_ioctl+0x79/0x90
> [ 7204.842822]=A0 [<ffffffff98002c2f>] do_syscall_64+0x8f/0x100
> [ 7204.842825]=A0 [<ffffffff9885c43e>] entry_SYSCALL_64_after_swapgs+0x58=
/0xc6
> [ 7204.842827] ---[ end trace 74813528aa09d5ed ]---
> [ 7207.812156] link rteth up
> [ 7209.551272] TDMA: calibrated master-to-slave packet delay: 25 us
> (min/max: 22/28 us)
> root@prog-pc12:/media/taras/B02E1E8AD6E10B9D/LX/driver#
>=20

Something is still broken in your driver port, leaving hard IRQs on in
the end. That is typically related to calling of illegal Linux services
from RT context (which is the IRQ or the xmit handler in this case).

Make sure you have all I-pipe and Xenomai debug features enabled. They
may provide an earlier clue of where things go wrong.

Jan

