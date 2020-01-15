From: Lange Norbert <norbert.lange@andritz.com>
Subject: 4.19.94-cip18-xeno10 regression: bugs out when changing drivers
Date: Wed, 15 Jan 2020 16:25:19 +0000
Message-ID: <VI1PR05MB5917A7E625E49CAF9E17444AF6370@VI1PR05MB5917.eurprd05.prod.outlook.com>
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

I had no problem with the previous 4.19.89 (and versions back to 4.14), but=
 this kernel does not like unloading the linux eth driver.
Will try with the plain linux kernel in the coming days, but any help is ap=
preciated.

Norbert

ethpci=3D"0000:01:00.0"
echo "$ethpci" > /sys/bus/pci/devices/$ethpci/driver/unbind.

[  199.590152] BUG: unable to handle kernel NULL pointer dereference at 000=
0000000000000
[  199.597995] PGD 179717067 P4D 179717067 PUD 17896b067 PMD 0
[  199.603670] Oops: 0000 [#1] SMP NOPTI
[  199.607344] CPU: 2 PID: 764 Comm: zsh Not tainted 4.19.94-cip18-xeno10-s=
tatic #1
[  199.614745] Hardware name: TQ-Group TQMxE39M/Type2 - Board Product Name,=
 BIOS 5.12.30.21.20 08/05/2019
[  199.624059] I-pipe domain: Linux
[  199.627300] RIP: 0010:strlen+0x0/0x20
[  199.630972] Code: f6 82 e0 5e 31 8b 20 74 11 0f b6 50 01 48 83 c0 01 f6 =
82 e0 5e 31 8b 20 75 ef c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 <80=
> 3f 00 74 10 48 89 f8 48 83 c0 01 80 38 00 75 f7 48 29 f8 c3 31
[  199.649742] RSP: 0018:ffffad3ec06ffb20 EFLAGS: 00010246
[  199.654975] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[  199.662118] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000
[  199.669258] RBP: 0000000000000000 R08: 0000000000000000 R09: ffff9756f99=
6f018
[  199.676402] R10: 0000000000000000 R11: ffff9756fb006c00 R12: ffff9756f99=
16788
[  199.683543] R13: 0000000000000000 R14: ffff9756fa81e190 R15: ffff9756f8b=
66f20
[  199.690683] FS:  0000000000535558(0000) GS:ffff9756fbb00000(0000) knlGS:=
0000000000000000
[  199.698780] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  199.704535] CR2: 0000000000000000 CR3: 000000017aaa0000 CR4: 00000000003=
406e0
[  199.711674] Call Trace:
[  199.714136]  kernfs_name_hash+0x12/0x80
[  199.717983]  kernfs_find_ns+0x35/0xd0
[  199.721654]  kernfs_remove_by_name_ns+0x32/0x90
[  199.726194]  remove_files.isra.0+0x30/0x70
[  199.730301]  sysfs_remove_group+0x3d/0x80
[  199.734321]  sysfs_remove_groups+0x29/0x40
[  199.738428]  device_remove_attrs+0x42/0x80
[  199.742534]  device_del+0x14f/0x360
[  199.746036]  cdev_device_del+0x15/0x30
[  199.749797]  posix_clock_unregister+0x21/0x50
[  199.754165]  ptp_clock_unregister+0x6e/0x80
[  199.758359]  igb_ptp_stop+0x1f/0x50
[  199.761861]  igb_remove+0x37/0x110
[  199.765272]  pci_device_remove+0x28/0x60
[  199.769202]  device_release_driver_internal+0x162/0x220
[  199.774437]  unbind_store+0xb1/0x170
[  199.778024]  kernfs_fop_write+0x10b/0x190
[  199.782042]  do_iter_write+0x140/0x180
[  199.785801]  vfs_writev+0xa6/0xf0
[  199.789127]  ? __alloc_fd+0x3d/0x140
[  199.792711]  ? f_dupfd+0x66/0x79
[  199.795949]  do_writev+0x5f/0x100
[  199.799273]  do_syscall_64+0x78/0x3d0
[  199.802944]  ? __do_page_fault+0x206/0x400
[  199.807049]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  199.812106] RIP: 0033:0x4cc34c
[  199.815172] Code: ed 01 48 29 d0 49 83 c5 10 49 8b 55 08 48 63 dd 48 29 =
c2 49 01 45 00 49 89 55 08 49 63 7f 78 4c 89 e0 4c 89 ee 48 89 da 0f 05 <48=
> 89 c7 e8 cc 4e ff ff 49 39 c6 75 b7 49 8b 47 58 49 8b 57 60 48
[  199.833943] RSP: 002b:00007ffe32e417a0 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000014
[  199.841521] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00000000004=
cc34c
[  199.848663] RDX: 0000000000000002 RSI: 00007ffe32e417b0 RDI: 00000000000=
00001
[  199.855805] RBP: 0000000000000002 R08: 0000000000523040 R09: 00000000000=
00000
[  199.862949] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000=
00014
[  199.870091] R13: 00007ffe32e417b0 R14: 000000000000000d R15: 00000000005=
23040
[  199.877237] Modules linked in: plusb usbnet mii
[  199.881783] CR2: 0000000000000000
[  199.885115] ---[ end trace 218fd81d1aa77ca4 ]---
[  199.889741] RIP: 0010:strlen+0x0/0x20
[  199.893413] Code: f6 82 e0 5e 31 8b 20 74 11 0f b6 50 01 48 83 c0 01 f6 =
82 e0 5e 31 8b 20 75 ef c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 <80=
> 3f 00 74 10 48 89 f8 48 83 c0 01 80 38 00 75 f7 48 29 f8 c3 31
[  199.912189] RSP: 0018:ffffad3ec06ffb20 EFLAGS: 00010246
[  199.917424] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[  199.924568] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000
[  199.931711] RBP: 0000000000000000 R08: 0000000000000000 R09: ffff9756f99=
6f018
[  199.938855] R10: 0000000000000000 R11: ffff9756fb006c00 R12: ffff9756f99=
16788
[  199.946000] R13: 0000000000000000 R14: ffff9756fa81e190 R15: ffff9756f8b=
66f20
[  199.953142] FS:  0000000000535558(0000) GS:ffff9756fbb00000(0000) knlGS:=
0000000000000000
[  199.961237] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  199.966990] CR2: 0000000000000000 CR3: 000000017aaa0000 CR4: 00000000003=
406e0
0

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
