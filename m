Message-ID: <499BBF88.9000207@domain.hid>
Date: Wed, 18 Feb 2009 08:58:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <499B36C5.3060104@domain.hid> <499B3F35.2080604@domain.hid>
	<499B5136.2030107@domain.hid> <499B55CF.3020005@domain.hid>
In-Reply-To: <499B55CF.3020005@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig321F8D6C7CE8EF657233D050"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] BUG fs/buffer.c with Linux 2.6.26,27
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig321F8D6C7CE8EF657233D050
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Roman Pisl wrote:
>>>> Hello,
>>>> I'm porting our application to Xenomai and I found a bug with Linux
>>>> 2.6.26 and 2.6.27 (and also .19) and Xenomai 2.4.6.1. This happens w=
hen
>>>> the application is running and there is hard disk activity. It happe=
ns
>>>> also when latency test is running for a while. Linux 2.6.16 with Xen=
omai
>>>> 2.4.6.1 works without problem. So this is solution for now.
>>>>
>>>> Tested on x86 - thinkpad laptop and pentium 4 desktop.
>>>>
>>>> I'm not a kernel hacker but surely try to help with fixing. I'd like=
 to
>>>> see this fixed.
>>> /me, too. But could you first of all check if the problem persists ev=
en
>>> with latest adeos-ipipe-2.6.27.13-x86-2.2-05.patch [1]?
>>>
>>> If it does: Go back to 2.6.26 (in order to have the ipipe tracer).
>>> Before the oops can occur, extend /proc/ipipe/trace/back_trace_points=

>>> to, say, one thousand ("echo 1000 > /proc/..."). Then post the result=
ing
>>> trace. It may include some hints about when Linux IRQs were last enab=
led
>>> and when they became stuck at disabled. Also, please attach your .con=
fig.
>> Other traces show that it happens in __ipipe_unstall_iret_root.
>=20
> Here is the other trace.
>=20
>=20
> / # /etc/ini/ # /etc/init./ # /etc/init.d/rc/ # /etc/init.d/rcS=20
> model		: 9
> Geode GX1 Found
> EXT3-fs warning: maximal mount count reached, running e2fsck is recomme=
nded
> EXT3 FS on hdc1, internal journal
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs warning: maximal mount count reached, running e2fsck is recomme=
nded
> EXT3 FS on hda1, internal journal
> EXT3-fs: recovery complete.
> EXT3-fs: mounted filesystem with ordered data mode.
> modprobe: module ohci-hcd not found
> modprobe: failed to load module ohci-hcd
> modprobe: module sg not found
> modprobe: failed to load module sg
> modprobe: module usb-storage not found
> modprobe: failed to load module usb-storage
> I-pipe: Domain Xenomai registered.
> Xenomai: hal/i386 started.
> Xenomai: real-time nucleus v2.4.6 (Bamboo) loaded.
> Xenomai: starting native API services.
> Generic RTC Driver v1.07
> eepro100.c:v1.09j-t 9/29/99 Donald Becker
> eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochki=
n <saw@domain.hid> and others
> eepro100 0000:00:0b.0: found PCI INT A -> IRQ 11
> eepro100 0000:00:0b.0: IRQ routing conflict: have IRQ 10, want IRQ 11
> eth0: OEM i82557/i82558 10/100 Ethernet, 00:0b:ab:12:0d:69, IRQ 10.
>   Board assembly 727095-004, Physical connectors present: RJ45
>   Primary interface chip i82555 PHY #1.
>   General self-test: passed.
>   Serial sub-system self-test: passed.
>   Internal registers self-test: passed.
>   ROM checksum self-test: passed (0xd0a6c714).
> st_dacsnd: module license 'Proprietary' taints kernel.
> ticks are 125000
> st audio device registered v3
> / # NET: Registered protocol family 1
> NET: Registered protocol family 10
> ADDRCONF(NETDEV_UP): eth0: link is not ready
>=20
> / # ./  sh ./xe/ # sh ./xenomai_trace.sh=20
> / # cd xo/ # cd xoft/
> /xoft # ./xe/xoft # ./xenoxoft
> stAudio
> initializing xenoxoft instance
> Xenomai 1.40c Jan 30 2009 12:27:55
> xenoxoft initialized!
> maxTreatmentFractions =3D 10
> maxTreatmentMinutes =3D 170
> maxCalibrationMinutes =3D 170
> maxDays =3D 35
> xoft input running
> ------------[ cut here ]------------
> kernel BUG at fs/buffer.c:1289!
> invalid opcode: 0000 [#1] PREEMPT=20
> Modules linked in: ipv6 unix st_dacsnd(P) soundcore eepro100 mii genrtc=
 xeno_native xeno_nucleus vfat fat
>=20
> Pid: 913, comm: rtlogd Tainted: P          (2.6.27.11-no3dnow-serial-xe=
nomai #19)
> EIP: 0060:[<c017a252>] EFLAGS: 00010046 CPU: 0
> EIP is at __find_get_block+0x2d/0x198
> EAX: 00000000 EBX: 00017e83 ECX: 00000400 EDX: 00060003
> ESI: 00000400 EDI: 00060003 EBP: cfb79d38 ESP: cfb79d04
>  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
> Process rtlogd (pid: 913, ti=3Dcfb78000 task=3Dcf998700 task.ti=3Dcfb78=
000)<0>
> I-pipe domain Linux
> Stack: cf4101a0 00000000 00003ce8 00000082 c04ec200 00017e83 cf953600 c=
feffe00=20
>        cfb79d5c c010b4eb 00017e83 cf953600 00000400 cfb79d5c c017a3d8 0=
0060003=20
>        cf4101a0 00000000 cf951200 00017e83 cf953600 cfeffe00 cfb79d98 c=
0197094=20
> Call Trace:
>  [<c010b4eb>] ? mcount+0x1f/0x23
>  [<c017a3d8>] ? __getblk+0x1b/0x1d8
>  [<c0197094>] ? __ext3_get_inode_loc+0xce/0x282
>  [<c0197250>] ? ext3_get_inode_loc+0x8/0x1b
>  [<c0197261>] ? ext3_get_inode_loc+0x19/0x1b
>  [<c0197288>] ? ext3_reserve_inode_write+0x25/0x6d
>  [<c01972fa>] ? ext3_mark_inode_dirty+0x2a/0x41
>  [<c0199780>] ? ext3_dirty_inode+0x57/0x6b
>  [<c0176fab>] ? __mark_inode_dirty+0x2b/0x14d
>  [<c016dffb>] ? file_update_time+0x9e/0xc6
>  [<c013ed75>] ? __generic_file_aio_write_nolock+0x2f9/0x42c
>  [<c0139700>] ? ipipe_check_context+0x9/0x94
>  [<c013ef04>] ? generic_file_aio_write+0x5c/0xb7
>  [<c0195bcb>] ? ext3_file_write+0x1f/0x8e
>  [<c015c110>] ? do_sync_write+0xbf/0xfd
>  [<d093a640>] ? losyscall_event+0xe/0x158 [xeno_nucleus]
>  [<c0127833>] ? autoremove_wake_function+0x0/0x35
>  [<c010b4eb>] ? mcount+0x1f/0x23
>  [<c015c051>] ? do_sync_write+0x0/0xfd
>  [<c015c825>] ? vfs_write+0x91/0x113
>  [<c015ccb8>] ? sys_write+0x40/0x65
>  [<c0102e51>] ? syscall_call+0x7/0xb
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Code: e5 57 56 53 83 ec 28 e8 99 12 f9 ff 89 45 cc 89 d7 89 ce 0f ba 25=
 0c e6 31 c0 00 19 c0 83 f8 01 19 c0 25 00 02 00 00 85 c0 75 04 <0f> 0b e=
b fe b8 01 00 00 00 e8 e8 5d f9 ff 31 c9 8b 1c 8d f4 4b=20
> EIP: [<c017a252>] __find_get_block+0x2d/0x198 SS:ESP 0068:cfb79d04
> I-pipe tracer log (10000 points):
>  |   #func                    0 ipipe_trace_panic_freeze+0x9 (oops_ente=
r+0xd)
>  |   #func                   -1 oops_enter+0x8 (oops_begin+0xe)
>  |   #func                   -3 oops_begin+0x9 (die+0x19)
>  |   #func                   -5 die+0xe (do_trap+0x8e)
>  |   #func                   -8 ipipe_check_context+0x9 (sub_preempt_co=
unt+0x15)
>  |   #func                  -10 sub_preempt_count+0x9 (search_module_ex=
tables+0x64)
>  |   #func                  -13 search_extable+0x9 (search_module_extab=
les+0x3f)
>  |   #func                  -16 search_extable+0x9 (search_module_extab=
les+0x3f)
>  |   #func                  -23 add_preempt_count+0x8 (search_module_ex=
tables+0x17)
>  |   #func                  -24 search_module_extables+0xb (search_exce=
ption_tables+0x27)
>  |   #func                  -28 search_extable+0x9 (search_exception_ta=
bles+0x1c)
>  |   #func                  -30 search_exception_tables+0x9 (fixup_exce=
ption+0x13)
>  |   #func                  -32 fixup_exception+0x9 (do_trap+0x6f)
>  |   #func                  -34 do_trap+0xe (do_invalid_op+0x71)
>  |   #func                  -37 ipipe_check_context+0x9 (sub_preempt_co=
unt+0x15)
>  |   #func                  -38 sub_preempt_count+0x9 (__atomic_notifie=
r_call_chain+0x38)
>  |   #func                  -40 notifier_call_chain+0xe (__atomic_notif=
ier_call_chain+0x2c)
>  |   #func                  -43 add_preempt_count+0x8 (__atomic_notifie=
r_call_chain+0x1b)
>  |   #func                  -44 __atomic_notifier_call_chain+0xb (atomi=
c_notifier_call_chain+0x11)
>  |   #func                  -46 atomic_notifier_call_chain+0x8 (notify_=
die+0x32)
>  |   #func                  -48 notify_die+0xb (do_invalid_op+0x48)
>  |   #func                  -51 do_invalid_op+0xd (__ipipe_handle_excep=
tion+0x128)
>  |   #func                  -57 __ipipe_handle_exception+0xe (error_cod=
e+0x6f)
>  |   #func                  -62 __find_get_block+0xe (__getblk+0x1b)
>  |   #func                  -64 __getblk+0xe (__ext3_get_inode_loc+0xce=
)
>  |   #func                  -71 ext3_get_group_desc+0xe (__ext3_get_ino=
de_loc+0x67)
>  |   #func                  -76 __ext3_get_inode_loc+0xe (ext3_get_inod=
e_loc+0x19)
>  |   #func                  -78 ext3_get_inode_loc+0x8 (ext3_reserve_in=
ode_write+0x25)
>  |   #func                  -79 ext3_reserve_inode_write+0xe (ext3_mark=
_inode_dirty+0x2a)
>  |   #func                  -81 ipipe_check_context+0x9 (ext3_mark_inod=
e_dirty+0x1c)
>  |   #func                  -82 ext3_mark_inode_dirty+0xe (ext3_dirty_i=
node+0x57)
>  |   #func                  -85 ipipe_check_context+0x9 (sub_preempt_co=
unt+0x15)
>  |   #func                  -86 sub_preempt_count+0x9 (start_this_handl=
e+0x33c)
>  |   #func                  -88 ipipe_check_context+0x9 (sub_preempt_co=
unt+0x15)
>  |   #func                  -90 sub_preempt_count+0x9 (start_this_handl=
e+0x320)
>  |   #func                  -92 __log_space_left+0x8 (start_this_handle=
+0x2cd)
>  |   #func                  -95 add_preempt_count+0x8 (start_this_handl=
e+0x230)
>  |   #func                  -98 add_preempt_count+0x8 (start_this_handl=
e+0x93)
>  |   #func                 -101 start_this_handle+0xe (journal_start+0x=
86)
>  |   #func                 -104 __ipipe_restore_root+0x8 (kmem_cache_al=
loc+0x91)
>  |   #func                 -110 ipipe_check_context+0x9 (kmem_cache_all=
oc+0x23)
>  |   #func                 -111 kmem_cache_alloc+0xe (journal_start+0x5=
3)
>  |   #func                 -115 journal_start+0xe (ext3_journal_start_s=
b+0x45)
>  |   #func                 -118 ext3_journal_start_sb+0x8 (ext3_dirty_i=
node+0x28)
>  |   #func                 -120 ext3_dirty_inode+0xb (__mark_inode_dirt=
y+0x2b)
>  |   #func                 -124 __mark_inode_dirty+0xe (file_update_tim=
e+0x9e)
>  |   #func                 -128 timespec_trunc+0xe (current_fs_time+0x1=
b)
>  |   #func                 -131 current_kernel_time+0xa (current_fs_tim=
e+0x10)
>  |   #func                 -133 current_fs_time+0x9 (file_update_time+0=
x3a)
>  |   #func                 -135 ipipe_check_context+0x9 (sub_preempt_co=
unt+0x15)
>  |   #func                 -137 sub_preempt_count+0x9 (mnt_want_write+0=
x88)
>  |   #func                 -138 ipipe_check_context+0x9 (sub_preempt_co=
unt+0x15)
>  |   #func                 -140 sub_preempt_count+0x9 (mnt_want_write+0=
x6c)
>  |   #func                 -143 __mnt_is_readonly+0x8 (mnt_want_write+0=
x2c)
>  |   #func                 -145 add_preempt_count+0x8 (mnt_want_write+0=
x20)
>  |   #func                 -146 add_preempt_count+0x8 (mnt_want_write+0=
x16)
>  |   #func                 -148 mnt_want_write+0xa (file_update_time+0x=
27)
>  |   #func                 -150 file_update_time+0xa (__generic_file_ai=
o_write_nolock+0x2f9)
>  |   #func                 -153 cap_inode_need_killpriv+0x8 (file_remov=
e_suid+0x20)
>  |   #func                 -156 should_remove_suid+0x9 (file_remove_sui=
d+0x17)
>  |   #func                 -158 file_remove_suid+0xd (__generic_file_ai=
o_write_nolock+0x2e6)
>  |   #func                 -161 ipipe_check_context+0x9 (sub_preempt_co=
unt+0x15)
>  |   #func                 -163 sub_preempt_count+0x9 (__generic_file_a=
io_write_nolock+0x141)
>  |   #func                 -164 add_preempt_count+0x8 (__generic_file_a=
io_write_nolock+0x12b)
>  |   #func                 -172 generic_segment_checks+0xe (__generic_f=
ile_aio_write_nolock+0x3c)
>  |   #func                 -175 __generic_file_aio_write_nolock+0xe (ge=
neric_file_aio_write+0x5c)
>  |   #func                 -179 ipipe_check_context+0x9 (mutex_lock+0x1=
8)
>  |   #func                 -180 mutex_lock+0xc (generic_file_aio_write+=
0x4b)
>  |   #func                 -184 generic_file_aio_write+0xe (ext3_file_w=
rite+0x1f)
>  |   #func                 -187 ext3_file_write+0xb (do_sync_write+0xbf=
)
>  |   #func                 -193 do_sync_write+0x11 (vfs_write+0x91)
>  |   #func                 -200 rw_verify_area+0xe (vfs_write+0x6f)
>  |   #func                 -205 vfs_write+0xe (sys_write+0x40)
>  |   #func                 -208 ipipe_check_context+0x9 (sub_preempt_co=
unt+0x15)
>  |   #func                 -209 sub_preempt_count+0x9 (fget_light+0x8f)=

>  |   #func                 -214 add_preempt_count+0x8 (fget_light+0x46)=

>  |   #func                 -217 fget_light+0xb (sys_write+0x1d)
>  |   #func                 -219 sys_write+0xd (syscall_call+0x7)
>  |   #func                 -223 losyscall_event+0xe [xeno_nucleus] (__i=
pipe_dispatch_event+0xbc)
>  |  +*func                 -228 hisyscall_event+0xe [xeno_nucleus] (__i=
pipe_dispatch_event+0xbc)
>  |   #func                 -233 __ipipe_dispatch_event+0xe (__ipipe_sys=
call_root+0x74)
>  |   #func                 -239 __ipipe_syscall_root+0xa (system_call+0=
x29)
>  |   #end     0x8000000d   -503 __ipipe_unstall_iret_root+0x60 (restore=
_nocheck_notrace+0x0)
>  |   #begin   0x80000000   -506 __ipipe_unstall_iret_root+0x1e (restore=
_nocheck_notrace+0x0)
>      #func                 -507 __ipipe_unstall_iret_root+0x9 (restore_=
nocheck_notrace+0x0)

Mmmh, something may have messed up the argument (register file) that
__ipipe_unstall_iret_root sees so that regs.flags & X86_EFLAGS_IF
evaluates to 0. Just a guess. Having the corresponding .config would we
good now. I'm planning to fire up a 32-bit instance again today anyway
and could try to reproduce/debug this under kvm.

Jan


--------------enig321F8D6C7CE8EF657233D050
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkmbv4gACgkQniDOoMHTA+lrTgCeMTcwSZvEgrMWEtKYDF6snEDx
e60Anixb7P35kG+psDuHTbv04kLUh5mB
=QfAs
-----END PGP SIGNATURE-----

--------------enig321F8D6C7CE8EF657233D050--

