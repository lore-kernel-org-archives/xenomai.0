From: Lange Norbert <norbert.lange@andritz.com>
Subject: kernel bug if rtnet device is accesses during unbind
Date: Tue, 3 Aug 2021 11:18:20 +0000
Message-ID: <AS8PR05MB7720FBD018EBB5DED2B01962F6F09@AS8PR05MB7720.eurprd05.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Hello,

There is some bigger kernel oops when an rtnet device is unbound from
linux but still accessible via ioctl.
Effect and backtrace depends on timing, usually the rt_igb module will not
decrease its reference count, and a following soft reboot might hang.

To repoduce, for example with rt_igb (doubt its driver specific):

echo "0000:01:00.0" > /sys/bus/pci/drivers/rt_igb/bind
# rtifconfig has to run in background
echo "0000:01:00.0" > /sys/bus/pci/drivers/rt_igb/unbind & rtifconfig rteth=
0 up

* kernel oops attached at the end of mail.

Background: I wanted to use udev to set  the device up ASAP (and I missed t=
he ACTION filter)
ACTION=3D=3D"add", SUBSYSTEM=3D=3D"rtnet", KERNEL=3D=3D"rteth0", RUN+=3D"/s=
bin/rtifconfig %k up"

This rule does not work for the reason that the udev rule fires
before the device is hooked in the rtnet subsystem.
I believe that this ordering might be the cause of the kernel bug aswell
(reachable via rtnet, while already unbound in linux/sysfs)

* udev log is added at the end

  kernel oops

[  350.463476] RTnet: unregistered rteth0
[  350.467328] invalid opcode: 0000 [#1] SMP
[  350.471350] CPU: 0 PID: 564 Comm: zsh Not tainted 5.4.133-xeno6-static #=
3
[  350.478146] Hardware name: TQ-Group TQMxE39M/Type2 - Board Product Name,=
 BIOS 5.12.30.28.22 09/30/2019
[  350.487458] I-pipe domain: Linux
[  350.490705] RIP: 0010:free_msi_irqs+0x170/0x1a0
[  350.495247] Code: 0f 84 e4 fe ff ff 31 ed eb 0f 83 c5 01 39 6b 14 0f 86 =
d4 fe ff ff 8b 7b 10 01 ef e8 fa fa c8 ff 48 83 b8 80 00 00 00 00 74 e0 <0f=
> 0b 49 8d b5 b0 00 00 00 e8 f2 93 c9 ff e9 d3 fe ff ff 48 8b 7d
[  350.514018] RSP: 0018:ffffa6ad40077d30 EFLAGS: 00010286
[  350.519252] RAX: ffffa32ab799d400 RBX: ffffa32ab9b4b3c0 RCX: 00000000000=
00000
[  350.526392] RDX: ffffa32aba52b478 RSI: ffffa32aba52b680 RDI: 00000000000=
0007c
[  350.533532] RBP: 0000000000000000 R08: ffffffffac026f80 R09: 00000000000=
00000
[  350.540676] R10: 0000000000000000 R11: ffffffffac026f88 R12: ffffa32abb3=
a11c0
[  350.547817] R13: ffffa32abb3a1000 R14: ffffa6ad40077eb0 R15: ffffa32ab6a=
26860
[  350.554960] FS:  00007fa8dc65e640(0000) GS:ffffa32abba00000(0000) knlGS:=
0000000000000000
[  350.563058] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  350.568815] CR2: 000000000068a7e0 CR3: 0000000177135000 CR4: 00000000003=
406f0
[  350.575957] Call Trace:
[  350.578421]  igb_reset_interrupt_capability+0x8a/0x90 [rt_igb]
[  350.584268]  igb_remove+0xbf/0x170 [rt_igb]
[  350.588458]  pci_device_remove+0x28/0x60
[  350.592391]  __device_release_driver+0x134/0x1e0
[  350.597016]  device_driver_detach+0x3c/0xa0
[  350.601205]  unbind_store+0x113/0x130
[  350.604877]  kernfs_fop_write+0xcb/0x1b0
[  350.608810]  vfs_write+0xa5/0x1d0
[  350.612134]  ksys_write+0x5f/0xe0
[  350.615461]  do_syscall_64+0x7a/0x3d0
[  350.619132]  ? ipipe_restore_root+0x47/0x70
[  350.623325]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  350.628386] RIP: 0033:0x7fa8dc7639c4
[  350.631970] Code: 15 d1 d4 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb =
b7 0f 1f 00 48 8d 05 f1 13 0d 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 48 89 54 24 18 48
[  350.650742] RSP: 002b:00007ffd1feafee8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000001
[  350.658322] RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007fa8dc7=
639c4
[  350.665466] RDX: 000000000000000d RSI: 0000000000581ce0 RDI: 00000000000=
00001
[  350.672611] RBP: 00007fa8dc832760 R08: 00007fa8dc65e640 R09: 00000000000=
0000a
[  350.679754] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
0000d
[  350.686897] R13: 0000000000581ce0 R14: 000000000000000d R15: 00007fa8dc8=
2d740
[  350.694042] Modules linked in: rt_igb rtpacket rtnet
[  350.699024] ---[ end trace 582d575b2ac29cad ]---
[  350.703651] RIP: 0010:free_msi_irqs+0x170/0x1a0
[  350.708188] Code: 0f 84 e4 fe ff ff 31 ed eb 0f 83 c5 01 39 6b 14 0f 86 =
d4 fe ff ff 8b 7b 10 01 ef e8 fa fa c8 ff 48 83 b8 80 00 00 00 00 74 e0 <0f=
> 0b 49 8d b5 b0 00 00 00 e8 f2 93 c9 ff e9 d3 fe ff ff 48 8b 7d
[  350.726964] RSP: 0018:ffffa6ad40077d30 EFLAGS: 00010286
[  350.732195] RAX: ffffa32ab799d400 RBX: ffffa32ab9b4b3c0 RCX: 00000000000=
00000
[  350.739335] RDX: ffffa32aba52b478 RSI: ffffa32aba52b680 RDI: 00000000000=
0007c
[  350.746478] RBP: 0000000000000000 R08: ffffffffac026f80 R09: 00000000000=
00000
[  350.753620] R10: 0000000000000000 R11: ffffffffac026f88 R12: ffffa32abb3=
a11c0
[  350.760760] R13: ffffa32abb3a1000 R14: ffffa6ad40077eb0 R15: ffffa32ab6a=
26860
[  350.767902] FS:  00007fa8dc65e640(0000) GS:ffffa32abba00000(0000) knlGS:=
0000000000000000
[  350.776000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  350.781755] CR2: 000000000068a7e0 CR3: 0000000177135000 CR4: 00000000003=
406f0
[  350.788907] ------------[ cut here ]------------
[  350.793534] kernel BUG at drivers/pci/msi.c:375!


  udev log after binding

13:51:27 systemd-udevd[424]: rteth0: Device is queued (SEQNUM=3D1575, ACTIO=
N=3Dadd)
13:51:27 systemd-udevd[424]: Validate module index
13:51:27 systemd-udevd[424]: Check if link configuration needs reloading.
13:51:27 systemd-udevd[424]: rteth0: Device ready for processing (SEQNUM=3D=
1575, ACTION=3Dadd)
13:51:27 systemd-udevd[424]: Successfully forked off 'n/a' as PID 602.
13:51:27 systemd-udevd[424]: rteth0: Worker [602] is forked for processing =
SEQNUM=3D1575.
13:51:27 systemd-udevd[602]: rteth0: Processing device (SEQNUM=3D1575, ACTI=
ON=3Dadd)
13:51:27 systemd-udevd[602]: rteth0: /run/udev/rules.d/98-rtnet.rules:4 RUN=
 '/sbin/rtifconfig %k up'
13:51:27 systemd-udevd[602]: rteth0: Running command "/sbin/rtifconfig rtet=
h0 up"
13:51:27 systemd-udevd[602]: rteth0: Starting '/sbin/rtifconfig rteth0 up'
13:51:27 systemd-udevd[602]: Successfully forked off '(spawn)' as PID 603.
13:51:27 systemd-udevd[602]: rteth0: '/sbin/rtifconfig rteth0 up'(err) 'ioc=
tl: No such device'
13:51:27 systemd-udevd[602]: rteth0: Process '/sbin/rtifconfig rteth0 up' f=
ailed with exit code 1.
13:51:27 systemd-udevd[602]: rteth0: Command "/sbin/rtifconfig rteth0 up" r=
eturned 1 (error), ignoring.
13:51:27 systemd-udevd[602]: rteth0: Device processed (SEQNUM=3D1575, ACTIO=
N=3Dadd)
13:51:27 systemd-udevd[602]: rteth0: sd-device-monitor: Passed 144 byte to =
netlink monitor
13:51:27 kernel: RTnet: registered rteth0
13:51:27 kernel: rt_igb 0000:01:00.0: Intel(R) Gigabit Ethernet Network Con=
nection
13:51:27 kernel: rt_igb 0000:01:00.0: rteth0: (PCIe:2.5Gb/s:Width x1) 22:91=
:9c:59:fc:75
13:51:27 kernel: rt_igb 0000:01:00.0: rteth0: PBA No: FFFFFF-0FF
13:51:27 kernel: rt_igb 0000:01:00.0: Using MSI-X interrupts. 1 rx queue(s)=
, 1 tx queue(s)

Kind regards,
Norbert Lange

________________________________

This message and any attachments are solely for the use of the intended rec=
ipients. They may contain privileged and/or confidential information or oth=
er information protected from disclosure. If you are not an intended recipi=
ent, you are hereby notified that you received this email in error and that=
 any review, dissemination, distribution or copying of this email and any a=
ttachment is strictly prohibited. If you have received this email in error,=
 please contact the sender and delete the message and any attachment from y=
our system.

ANDRITZ HYDRO GmbH


Rechtsform/ Legal form: Gesellschaft mit beschr?nkter Haftung / Corporation

Firmensitz/ Registered seat: Wien

Firmenbuchgericht/ Court of registry: Handelsgericht Wien

Firmenbuchnummer/ Company registration: FN 61833 g

DVR: 0605077

UID-Nr.: ATU14756806


Thank You
________________________________
