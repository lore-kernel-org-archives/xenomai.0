Message-ID: <7803102.1167838186182.JavaMail.ngmail@domain.hid>
Date: Wed, 3 Jan 2007 16:29:46 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Kernel Oops with latest SVN Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi all,

using the latest SVN version of Xenomai and the integrated patches on a 2.6=
.19 kernel
I get a kernel Oops with my application and the system freezes.
Here is the oops:
------------[ cut here ]------------
kernel BUG at fs/buffer.c:1233!
invalid opcode: 0000 [#1]
CPU:    0
EIP:    0060:[__find_get_block+36/350]    Not tainted VLI
EFLAGS: 00013046   (2.6.19.1 #3)
EIP is at __find_get_block+0x24/0x15e
eax: 00000000   ebx: dae1fcf4   ecx: 00000000   edx: 0007035e
esi: 0007035e   edi: 00000000   ebp: c146fac0   esp: dae1fb5c
ds: 007b   es: 007b   ss: 0068
Process model (pid: 1674, ti=3Ddae1e000 task=3Ddf81f560 task.ti=3Ddae1e000)
Stack: dae1fb68 c0124a84 dae1fbe8 00000000 c015b39a dae1fbe8 c015b3bb 00000=
000
       dae434c0 dae1fcf4 0007035e 00000000 00000000 c016be11 c146fac0 00070=
35e
       00000000 00001000 dae1fe50 dae1fe54 dae1fe58 00000200 00000000 00000=
000
Call Trace:
 [remove_wait_queue+21/93] remove_wait_queue+0x15/0x5d
 [free_poll_entry+14/22] free_poll_entry+0xe/0x16
 [poll_freewait+25/78] poll_freewait+0x19/0x4e
 [__getblk+43/628] __getblk+0x2b/0x274
 [search_by_key+130/3465] search_by_key+0x82/0xd89
 [default_wake_function+0/21] default_wake_function+0x0/0x15
 [__getblk+43/628] __getblk+0x2b/0x274
 [ll_rw_block+130/147] ll_rw_block+0x82/0x93
 [search_by_key+420/3465] search_by_key+0x1a4/0xd89
 [reiserfs_update_sd_size+160/722] reiserfs_update_sd_size+0xa0/0x2d2
 [journal_begin+185/250] journal_begin+0xb9/0xfa
 [__d_lookup+157/209] __d_lookup+0x9d/0xd1
 [reiserfs_dirty_inode+100/132] reiserfs_dirty_inode+0x64/0x84
 [__mark_inode_dirty+48/338] __mark_inode_dirty+0x30/0x152
 [touch_atime+115/173] touch_atime+0x73/0xad
 [__link_path_walk+1892/2828] __link_path_walk+0x764/0xb0c
 [mntput_no_expire+28/92] mntput_no_expire+0x1c/0x5c
 [link_path_walk+198/208] link_path_walk+0xc6/0xd0
 [link_path_walk+83/208] link_path_walk+0x53/0xd0
 [__handle_mm_fault+1686/1810] __handle_mm_fault+0x696/0x712
 [<e0a03096>] schedule_event+0x0/0x13c [xeno_nucleus]
 [do_path_lookup+354/444] do_path_lookup+0x162/0x1bc
 [getname+105/201] getname+0x69/0xc9
 [__user_walk_fd+48/66] __user_walk_fd+0x30/0x42
 [vfs_stat_fd+30/82] vfs_stat_fd+0x1e/0x52
 [__handle_mm_fault+1686/1810] __handle_mm_fault+0x696/0x712
 [<e0a03096>] schedule_event+0x0/0x13c [xeno_nucleus]
 [vfs_stat+31/35] vfs_stat+0x1f/0x23
 [sys_stat64+24/44] sys_stat64+0x18/0x2c
 [do_gettimeofday+40/192] do_gettimeofday+0x28/0xc0
 [sys_time+37/53] sys_time+0x25/0x35
 [syscall_call+7/11] syscall_call+0x7/0xb
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Code: 0c 83 c4 0c 5b 5e c3 55 57 56 53 83 ec 24 8b 6c 24 38 8b 74 24 3c 8b =
7c 24 40 e8 6d a8 fc ff 83 f8 01 19 c0 31 c9 f6 c4 02 75 08 <0f> 0b d1 04 6=
a 6a 36 c0 8b 1c 8d 60 aa 46 c0 85 db 74 47 39 6b
EIP: [__find_get_block+36/350] __find_get_block+0x24/0x15e SS:ESP 0068:dae1=
fb5c
------------[ cut here ]------------


Unfortunately I have no idea, what causes this oops.
Is there anybody that has some hints on this oops?

Thanks in advance.

Regards

Mathias

--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

