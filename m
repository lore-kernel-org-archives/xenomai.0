From: Josh Karch <JKarch@domain.hid>
Date: Wed, 9 Dec 2009 08:56:19 -0800
Message-ID: <843773D242212C4882D4EDFFBF665F7F0155A93A9D@FW-SBS.fw.local>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai-help] Xenomai scheduling while atomic bug--debugging
	parameters
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

I have been working on a complex Xenomai based control system for Wind Turb=
ine research and I recently encountered a bug, which after much testing I a=
m unable to isolate, only delay the onset of the bug, which comes more quic=
kly when "top" is run.

My system is a PIII 1GHz, 1GB RAM, uniprocessor PC-104 stack with two PEAK =
PCI PCAN cards (4 channels) and an Exar 16L788 Quad 16550A compatible UART =
which is an ISA board (the PCI boards conflicted with the USB IRQs so I ins=
talled this board instead).  Our software is a daemon that uses three CAN c=
hannels controlled from a master RT-Task using message queues and RT-Alarms=
; our data logging system logs all data using a Pthread reading from an RT-=
Pipe, and communication/control of the control system is established throug=
h a daemon command line interface that uses a send and receive RT-Pipe to e=
nsure that all RT-Tasks stay in primary mode, while all linux control funct=
ions happen in the forked process and one logging pthread.   RT-Mutexes are=
 used throughout.

Depending on how many parts of my program are enabled: (logging code, seria=
l communications) it is only a matter of time before I get "scheduling whil=
e atomic" errors. I am running Linux 2.6.30.8 and Xenomai 2.4.10.  With log=
ging (heavy rt-pipe stream) disabled it took 14 hours for the bug to appear=
, with logging enabled it took 1,5 hours.  During that time I was trying to=
 break the code;  starting and stopping "top" in another window seemed to b=
reak it.  In addition, I may have also encountered this bug in another form=
 while improperly using the xeno_16550A driver.  Instead of using setserial=
 to set the quad uarts to none, I now just run as a kernel parameter 8250.n=
r_uarts=3D0.

Then I saw this section online:
http://www.mail-archive.com/xenomai@xenomai.org

Seems like a very similar problem. I will try to disable all of these param=
eters and see if that resolves the problem:  Any ideas on whether that issu=
e was addressed in 2.4.10?

Thank you for your help with this,

Sincerely,

Joshua Karch

Here is the most recent trace:

Dec  9 00:39:35 debian kernel: [56261.755997] BUG: scheduling while atomic:=
 sshd/1294/0x00000003
Dec  9 00:39:35 debian kernel: [56261.756750] Modules linked in: ipv6 nfsd =
exportfs nfs lockd nfs_acl auth_rpcgss sunrpc loop e100 mii pcan ehci_hcd u=
hci_hcd shpchp i2c_i801 iTCO_wdt i2c_core serio_raw pci_hotplug intel_agp r=
ng_core piix usbcore agpgart
Dec  9 00:39:35 debian kernel: [56261.768704] Pid: 1294, comm: sshd Not tai=
nted 2.6.30.8 #1
Dec  9 00:39:35 debian kernel: [56261.772700] Call Trace:
Dec  9 00:39:35 debian kernel: [56261.776709]  [<c0318291>] ? __schedule+0x=
8d/0x505
Dec  9 00:39:35 debian kernel: [56261.780706]  [<c0163c6a>] ? xnpod_schedul=
e+0x6b9/0x987
Dec  9 00:39:35 debian kernel: [56261.784706]  [<c0318718>] ? schedule+0xf/=
0x28
Dec  9 00:39:35 debian kernel: [56261.788706]  [<c031936d>] ? schedule_hrti=
meout_range+0x30/0x121
Dec  9 00:39:35 debian kernel: [56261.792707]  [<c011a56d>] ? __wake_up+0x4=
1/0x7c
Dec  9 00:39:35 debian kernel: [56261.796704]  [<c011a58b>] ? __wake_up+0x5=
f/0x7c
Dec  9 00:39:35 debian kernel: [56261.800706]  [<c027503d>] ? tty_ldisc_der=
ef+0x5f/0x97
Dec  9 00:39:35 debian kernel: [56261.804705]  [<c027505e>] ? tty_ldisc_der=
ef+0x80/0x97
Dec  9 00:39:35 debian kernel: [56261.808705]  [<c01b0013>] ? poll_schedule=
_timeout+0x25/0x3e
Dec  9 00:39:35 debian kernel: [56261.812705]  [<c01b095e>] ? do_select+0x3=
e5/0x41d
Dec  9 00:39:35 debian kernel: [56261.816707]  [<c01b0dff>] ? __pollwait+0x=
0/0x9c
Dec  9 00:39:35 debian kernel: [56261.820710]  [<c01b0e9b>] ? pollwake+0x0/=
0x55
Dec  9 00:39:35 debian kernel: [56261.824705]  [<c01b0e9b>] ? pollwake+0x0/=
0x55
Dec  9 00:39:35 debian kernel: [56261.828706]  [<c01b0e9b>] ? pollwake+0x0/=
0x55
Dec  9 00:39:35 debian kernel: [56261.832704]  [<c01b0e9b>] ? pollwake+0x0/=
0x55
Dec  9 00:39:35 debian kernel: [56261.836707]  [<c02c55f7>] ? __qdisc_run+0=
x10b/0x1b1
Dec  9 00:39:35 debian kernel: [56261.840712]  [<c01228b1>] ? local_bh_enab=
le+0x7c/0x8f
Dec  9 00:39:35 debian kernel: [56261.844706]  [<c02b687d>] ? dev_queue_xmi=
t+0x33e/0x36e
Dec  9 00:39:35 debian kernel: [56261.848706]  [<c02d76d8>] ? ip_finish_out=
put+0x1f2/0x22a
Dec  9 00:39:35 debian kernel: [56261.852705]  [<c02d6988>] ? ip_local_out+=
0x15/0x17
Dec  9 00:39:35 debian kernel: [56261.856705]  [<c02d7179>] ? ip_queue_xmit=
+0x2f4/0x355
Dec  9 00:39:35 debian kernel: [56261.860704]  [<c02d7179>] ? ip_queue_xmit=
+0x2f4/0x355
Dec  9 00:39:35 debian kernel: [56261.864705]  [<c0185c2a>] ? get_page_from=
_freelist+0x2e4/0x439
Dec  9 00:39:35 debian kernel: [56261.868713]  [<c0163c6a>] ? xnpod_schedul=
e+0x6b9/0x987
Dec  9 00:39:35 debian kernel: [56261.872704]  [<c02e9f2a>] ? tcp_v4_send_c=
heck+0x7a/0xb0
Dec  9 00:39:35 debian kernel: [56261.876705]  [<c02e68fa>] ? tcp_transmit_=
skb+0x5ab/0x5e2
Dec  9 00:39:35 debian kernel: [56261.880706]  [<c0125e5a>] ? lock_timer_ba=
se+0x32/0x73
Dec  9 00:39:35 debian kernel: [56261.884705]  [<c02e8a10>] ? tcp_write_xmi=
t+0x7a4/0x864
Dec  9 00:39:35 debian kernel: [56261.888703]  [<c02e8a10>] ? tcp_write_xmi=
t+0x7a4/0x864
Dec  9 00:39:35 debian kernel: [56261.892706]  [<c01536c4>] ? __ipipe_dispa=
tch_wired_nocheck+0x36/0x6d
Dec  9 00:39:35 debian kernel: [56261.896707]  [<c02b07aa>] ? __alloc_skb+0=
x46/0x10b
Dec  9 00:39:35 debian kernel: [56261.900704]  [<c012242a>] ? local_bh_disa=
ble+0xa/0xb
Dec  9 00:39:35 debian kernel: [56261.904722]  [<c02ac1d9>] ? release_sock+=
0xa0/0xa8
Dec  9 00:39:35 debian kernel: [56261.908705]  [<c01228b1>] ? local_bh_enab=
le+0x7c/0x8f
Dec  9 00:39:35 debian kernel: [56261.912705]  [<c02de7f8>] ? tcp_sendmsg+0=
x7b0/0x88a
Dec  9 00:39:35 debian kernel: [56261.916706]  [<c01b0b86>] ? core_sys_sele=
ct+0x1f0/0x287
Dec  9 00:39:35 debian kernel: [56261.920715]  [<c01a3c3a>] ? do_sync_write=
+0xbf/0x106
Dec  9 00:39:35 debian kernel: [56261.924705]  [<c012f172>] ? remove_wait_q=
ueue+0x58/0x6f
Dec  9 00:39:35 debian kernel: [56261.928706]  [<c012ee74>] ? autoremove_wa=
ke_function+0x0/0x2d
Dec  9 00:39:35 debian kernel: [56261.932707]  [<c01b0dde>] ? sys_select+0x=
6e/0x8f
Dec  9 00:39:35 debian kernel: [56261.936704]  [<c01a4722>] ? sys_write+0x3=
c/0x63
Dec  9 00:39:35 debian kernel: [56261.940706]  [<c01027f5>] ? sysenter_do_c=
all+0x12/0x16
Dec  9 00:39:35 debian kernel: [56261.949288] BUG: scheduling while atomic:=
 top/1503/0x00000003
Dec  9 00:39:35 debian kernel: [56261.952701] Modules linked in: ipv6 nfsd =
exportfs nfs lockd nfs_acl auth_rpcgss sunrpc loop e100 mii pcan ehci_hcd u=
hci_hcd shpchp i2c_i801 iTCO_wdt i2c_core serio_raw pci_hotplug intel_agp r=
ng_core piix usbcore agpgart
Dec  9 00:39:35 debian kernel: [56261.960702] Pid: 1503, comm: top Not tain=
ted 2.6.30.8 #1
Dec  9 00:39:35 debian kernel: [56261.964700] Call Trace:
Dec  9 00:39:35 debian kernel: [56261.968715]  [<c0318291>] ? __schedule+0x=
8d/0x505
Dec  9 00:39:35 debian kernel: [56261.972705]  [<c0131daf>] ? __hrtimer_sta=
rt_range_ns+0x246/0x263
Dec  9 00:39:35 debian kernel: [56261.976712]  [<c0131dec>] ? hrtimer_start=
_range_ns+0xf/0x13
Dec  9 00:39:35 debian kernel: [56261.980706]  [<c0318718>] ? schedule+0xf/=
0x28
Dec  9 00:39:35 debian kernel: [56261.984705]  [<c0319436>] ? schedule_hrti=
meout_range+0xf9/0x121
Dec  9 00:39:35 debian kernel: [56261.988705]  [<c0131549>] ? hrtimer_wakeu=
p+0x0/0x18
Dec  9 00:39:35 debian kernel: [56261.992719]  [<c0131dec>] ? hrtimer_start=
_range_ns+0xf/0x13
Dec  9 00:39:35 debian kernel: [56261.996712]  [<c01b0013>] ? poll_schedule=
_timeout+0x25/0x3e
Dec  9 00:39:35 debian kernel: [56262.000705]  [<c01b095e>] ? do_select+0x3=
e5/0x41d
Dec  9 00:39:35 debian kernel: [56262.004708]  [<c01b0dff>] ? __pollwait+0x=
0/0x9c
Dec  9 00:39:35 debian kernel: [56262.008705]  [<c01b0e9b>] ? pollwake+0x0/=
0x55
Dec  9 00:39:35 debian kernel: [56262.012706]  [<c01b0e9b>] ? pollwake+0x0/=
0x55
Dec  9 00:39:35 debian kernel: [56262.016707]  [<c0163c6a>] ? xnpod_schedul=
e+0x6b9/0x987
Dec  9 00:39:35 debian kernel: [56262.020722]  [<f838247e>] ? pcan_chardev_=
rx+0x4a/0x60 [pcan]
Dec  9 00:39:35 debian kernel: [56262.024707]  [<c017f6ae>] ? rtdm_event_si=
gnal+0x20/0x41
Dec  9 00:39:35 debian kernel: [56262.028713]  [<f838444e>] ? sja1000_irqha=
ndler_common+0x4e8/0x54c [pcan]
Dec  9 00:39:35 debian kernel: [56262.032706]  [<c0160705>] ? xnintr_irq_ha=
ndler+0xc5/0x122
Dec  9 00:39:35 debian kernel: [56262.036707]  [<c0106a36>] ? sched_clock+0=
x3d/0x5d
Dec  9 00:39:35 debian kernel: [56262.040705]  [<c01334e8>] ? sched_clock_c=
pu+0x8a/0x247
Dec  9 00:39:35 debian kernel: [56262.044705]  [<c0106a36>] ? sched_clock+0=
x3d/0x5d
Dec  9 00:39:35 debian kernel: [56262.048706]  [<c01334e8>] ? sched_clock_c=
pu+0x8a/0x247
Dec  9 00:39:35 debian kernel: [56262.052705]  [<c0119139>] ? try_to_wake_u=
p+0x178/0x194
Dec  9 00:39:35 debian kernel: [56262.056705]  [<c01b0ee5>] ? pollwake+0x4a=
/0x55
Dec  9 00:39:35 debian kernel: [56262.060705]  [<c0119155>] ? default_wake_=
function+0x0/0x8
Dec  9 00:39:35 debian kernel: [56262.064706]  [<c0116c3e>] ? __wake_up_com=
mon+0x2d/0x52
Dec  9 00:39:35 debian kernel: [56262.068705]  [<c0106a36>] ? sched_clock+0=
x3d/0x5d
Dec  9 00:39:35 debian kernel: [56262.072705]  [<c01334e8>] ? sched_clock_c=
pu+0x8a/0x247
Dec  9 00:39:35 debian kernel: [56262.076705]  [<c011a58b>] ? __wake_up+0x5=
f/0x7c
Dec  9 00:39:35 debian kernel: [56262.080706]  [<c0119139>] ? try_to_wake_u=
p+0x178/0x194
Dec  9 00:39:35 debian kernel: [56262.084705]  [<c01b900e>] ? seq_printf+0x=
25/0x41
Dec  9 00:39:35 debian kernel: [56262.088706]  [<c01b0b86>] ? core_sys_sele=
ct+0x1f0/0x287
Dec  9 00:39:35 debian kernel: [56262.092713]  [<c0116c3e>] ? __wake_up_com=
mon+0x2d/0x52
Dec  9 00:39:35 debian kernel: [56262.096705]  [<c011a56d>] ? __wake_up+0x4=
1/0x7c
Dec  9 00:39:35 debian kernel: [56262.100704]  [<c011a58b>] ? __wake_up+0x5=
f/0x7c
Dec  9 00:39:35 debian kernel: [56262.104706]  [<c011a56d>] ? __wake_up+0x4=
1/0x7c
Dec  9 00:39:35 debian kernel: [56262.108703]  [<c011a58b>] ? __wake_up+0x5=
f/0x7c
Dec  9 00:39:35 debian kernel: [56262.112713]  [<c027503d>] ? tty_ldisc_der=
ef+0x5f/0x97
Dec  9 00:39:35 debian kernel: [56262.116711]  [<c027505e>] ? tty_ldisc_der=
ef+0x80/0x97
Dec  9 00:39:35 debian kernel: [56262.120709]  [<c0271f9e>] ? n_tty_ioctl+0=
x0/0xa5
Dec  9 00:39:35 debian kernel: [56262.124705]  [<c0270b03>] ? tty_ioctl+0x7=
44/0x767
Dec  9 00:39:35 debian kernel: [56262.128704]  [<c02703bf>] ? tty_ioctl+0x0=
/0x767
Dec  9 00:39:35 debian kernel: [56262.132704]  [<c01af0bf>] ? vfs_ioctl+0x1=
c/0x5f
Dec  9 00:39:35 debian kernel: [56262.136706]  [<c01af578>] ? do_vfs_ioctl+=
0x476/0x4b6
Dec  9 00:39:35 debian kernel: [56262.140711]  [<c027503d>] ? tty_ldisc_der=
ef+0x5f/0x97
Dec  9 00:39:35 debian kernel: [56262.144709]  [<c027505e>] ? tty_ldisc_der=
ef+0x80/0x97
Dec  9 00:39:35 debian kernel: [56262.148705]  [<c026eb49>] ? tty_read+0x6b=
/0x99
Dec  9 00:39:35 debian kernel: [56262.152705]  [<c01358c5>] ? getnstimeofda=
y+0x4d/0xca
Dec  9 00:39:35 debian kernel: [56262.156705]  [<c01b0dde>] ? sys_select+0x=
6e/0x8f
Dec  9 00:39:35 debian kernel: [56262.160705]  [<c01027f5>] ? sysenter_do_c=
all+0x12/0x16
Dec  9 00:39:38 debian kernel: [56264.536732] BUG: scheduling while atomic:=
 top/1503/0x00000003
Dec  9 00:39:38 debian kernel: [56264.540697] Modules linked in: ipv6 nfsd =
exportfs nfs lockd nfs_acl auth_rpcgss sunrpc loop e100 mii pcan ehci_hcd u=
hci_hcd shpchp i2c_i801 iTCO_wdt i2c_core serio_raw pci_hotplug intel_agp r=
ng_core piix usbcore agpgart
Dec  9 00:39:38 debian kernel: [56264.540697] Pid: 1503, comm: top Not tain=
ted 2.6.30.8 #1
Dec  9 00:39:38 debian kernel: [56264.540697] Call Trace:
Dec  9 00:39:38 debian kernel: [56264.540697]  [<c0318291>] ? __schedule+0x=
8d/0x505
Dec  9 00:39:38 debian kernel: [56264.540697]  [<c01a47ca>] ? vfs_read+0x81=
/0x11c
Dec  9 00:39:38 debian kernel: [56264.540697]  [<c01af5f9>] ? sys_ioctl+0x4=
1/0x58
Dec  9 00:39:38 debian kernel: [56264.540697]  [<c0318718>] ? schedule+0xf/=
0x28
Dec  9 00:39:38 debian kernel: [56264.540697]  [<c0102963>] ? work_resched+=
0x6/0x20
Dec  9 00:39:38 debian kernel: [56264.540710] BUG: scheduling while atomic:=
 sshd/1294/0x00000003
Dec  9 00:39:38 debian kernel: [56264.544710] Modules linked in: ipv6 nfsd =
exportfs nfs lockd nfs_acl auth_rpcgss sunrpc loop e100 mii pcan ehci_hcd u=
hci_hcd shpchp i2c_i801 iTCO_wdt i2c_core serio_raw pci_hotplug intel_agp r=
ng_core piix usbcore agpgart
Dec  9 00:39:38 debian kernel: [56264.552708] Pid: 1294, comm: sshd Not tai=
nted 2.6.30.8 #1
Dec  9 00:39:38 debian kernel: [56264.556700] Call Trace:
Dec  9 00:39:38 debian kernel: [56264.560705]  [<c0318291>] ? __schedule+0x=
8d/0x505
Dec  9 00:39:38 debian kernel: [56264.564706]  [<c0163c6a>] ? xnpod_schedul=
e+0x6b9/0x987
Dec  9 00:39:38 debian kernel: [56264.568706]  [<c0318718>] ? schedule+0xf/=
0x28
Dec  9 00:39:38 debian kernel: [56264.572705]  [<c031936d>] ? schedule_hrti=
meout_range+0x30/0x121
Dec  9 00:39:38 debian kernel: [56264.576706]  [<c011a56d>] ? __wake_up+0x4=
1/0x7c
Dec  9 00:39:38 debian kernel: [56264.580705]  [<c011a58b>] ? __wake_up+0x5=
f/0x7c
Dec  9 00:39:38 debian kernel: [56264.584707]  [<c027503d>] ? tty_ldisc_der=
ef+0x5f/0x97
Dec  9 00:39:38 debian kernel: [56264.588705]  [<c027505e>] ? tty_ldisc_der=
ef+0x80/0x97
Dec  9 00:39:38 debian kernel: [56264.592705]  [<c01b0013>] ? poll_schedule=
_timeout+0x25/0x3e
Dec  9 00:39:38 debian kernel: [56264.596705]  [<c01b095e>] ? do_select+0x3=
e5/0x41d
Dec  9 00:39:38 debian kernel: [56264.600707]  [<c01b0dff>] ? __pollwait+0x=
0/0x9c
Dec  9 00:39:38 debian kernel: [56264.604704]  [<c01b0e9b>] ? pollwake+0x0/=
0x55
Dec  9 00:39:38 debian kernel: [56264.608705]  [<c01b0e9b>] ? pollwake+0x0/=
0x55
Dec  9 00:39:38 debian kernel: [56264.612705]  [<c01b0e9b>] ? pollwake+0x0/=
0x55
Dec  9 00:39:38 debian kernel: [56264.616704]  [<c01b0e9b>] ? pollwake+0x0/=
0x55
Dec  9 00:39:38 debian kernel: [56264.620708]  [<c02c55f7>] ? __qdisc_run+0=
x10b/0x1b1
Dec  9 00:39:38 debian kernel: [56264.624705]  [<c01228b1>] ? local_bh_enab=
le+0x7c/0x8f
Dec  9 00:39:38 debian kernel: [56264.628705]  [<c02b687d>] ? dev_queue_xmi=
t+0x33e/0x36e
Dec  9 00:39:38 debian kernel: [56264.632706]  [<c02d76d8>] ? ip_finish_out=
put+0x1f2/0x22a
Dec  9 00:39:38 debian kernel: [56264.636706]  [<c02d6988>] ? ip_local_out+=
0x15/0x17
Dec  9 00:39:38 debian kernel: [56264.640704]  [<c02d7179>] ? ip_queue_xmit=
+0x2f4/0x355
Dec  9 00:39:38 debian kernel: [56264.644705]  [<c02d7179>] ? ip_queue_xmit=
+0x2f4/0x355
Dec  9 00:39:38 debian kernel: [56264.648705]  [<c0185c2a>] ? get_page_from=
_freelist+0x2e4/0x439
Dec  9 00:39:38 debian kernel: [56264.652706]  [<c0163c6a>] ? xnpod_schedul=
e+0x6b9/0x987
Dec  9 00:39:38 debian kernel: [56264.656706]  [<c02e9f2a>] ? tcp_v4_send_c=
heck+0x7a/0xb0
Dec  9 00:39:38 debian kernel: [56264.660710]  [<c02e68fa>] ? tcp_transmit_=
skb+0x5ab/0x5e2
Dec  9 00:39:38 debian kernel: [56264.664705]  [<c0125e5a>] ? lock_timer_ba=
se+0x32/0x73
Dec  9 00:39:38 debian kernel: [56264.668706]  [<c02e8a10>] ? tcp_write_xmi=
t+0x7a4/0x864
Dec  9 00:39:38 debian kernel: [56264.672703]  [<c02e8a10>] ? tcp_write_xmi=
t+0x7a4/0x864
Dec  9 00:39:38 debian kernel: [56264.676706]  [<c01536c4>] ? __ipipe_dispa=
tch_wired_nocheck+0x36/0x6d
Dec  9 00:39:38 debian kernel: [56264.680712]  [<c02b07aa>] ? __alloc_skb+0=
x46/0x10b
Dec  9 00:39:38 debian kernel: [56264.684704]  [<c012242a>] ? local_bh_disa=
ble+0xa/0xb
Dec  9 00:39:38 debian kernel: [56264.688707]  [<c02ac1d9>] ? release_sock+=
0xa0/0xa8
Dec  9 00:39:38 debian kernel: [56264.692704]  [<c01228b1>] ? local_bh_enab=
le+0x7c/0x8f
Dec  9 00:39:38 debian kernel: [56264.696706]  [<c02de7f8>] ? tcp_sendmsg+0=
x7b0/0x88a
Dec  9 00:39:38 debian kernel: [56264.700707]  [<c01b0b86>] ? core_sys_sele=
ct+0x1f0/0x287
Dec  9 00:39:38 debian kernel: [56264.704707]  [<c01a3c3a>] ? do_sync_write=
+0xbf/0x106
Dec  9 00:39:38 debian kernel: [56264.708706]  [<c012f172>] ? remove_wait_q=
ueue+0x58/0x6f
Dec  9 00:39:38 debian kernel: [56264.712713]  [<c012ee74>] ? autoremove_wa=
ke_function+0x0/0x2d
Dec  9 00:39:38 debian kernel: [56264.716706]  [<c01b0dde>] ? sys_select+0x=
6e/0x8f
Dec  9 00:39:38 debian kernel: [56264.720722]  [<c01a4722>] ? sys_write+0x3=
c/0x63
Dec  9 00:39:38 debian kernel: [56264.724706]  [<c01027f5>] ? sysenter_do_c=
all+0x12/0x16
Dec  9 00:39:38 debian kernel: [56264.735792] BUG: scheduling while atomic:=
 top/1503/0x00000003
Dec  9 00:39:38 debian kernel: [56264.736697] Modules linked in: ipv6 nfsd =
exportfs nfs lockd nfs_acl auth_rpcgss sunrpc loop e100 mii pcan ehci_hcd u=
hci_hcd shpchp i2c_i801 iTCO_wdt i2c_core serio_raw pci_hotplug intel_agp r=
ng_core piix usbcore agpgart



