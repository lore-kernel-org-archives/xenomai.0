Message-ID: <4829A91C.8010800@domain.hid>
Date: Tue, 13 May 2008 16:43:40 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48299843.7090307@domain.hid>
In-Reply-To: <48299843.7090307@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] v2.4.3 bug with system() call
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?St=E9phane_ANCELOT?= <sancelot@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

St=E9phane ANCELOT wrote:
> Hi,
> Using the v2.4.3 +kernel 2.6.24.7 I used the system("touch /tmp/xxx_ok"=
)=20
> call   in a non realtime init context.
>=20
> The task is only used to allocate some memory heaps.
>=20
> I setted up some memory debugging features in the kernel :
> CONFIG_DEBUG_KERNEL=3Dy
> CONFIG_DEBUG_SLAB=3Dy
> CONFIG_DEBUG_SLAB_LEAK=3Dy
> CONFIG_DEBUG_BUGVERBOSE=3Dy
> CONFIG_DEBUG_VM=3Dy
> CONFIG_FORCED_INLINING=3Dy
> CONFIG_EARLY_PRINTK=3Dy
> CONFIG_DEBUG_PAGEALLOC=3Dy
>=20
>  This was not happening with v2.4.2 although that the kernel debugging=20
> flags were not "on"
>=20
> here is the bug trace :
>=20
> ------------[ cut here ]------------
> kernel BUG at mm/rmap.c:602!
> invalid opcode: 0000 [#1] PREEMPT DEBUG_PAGEALLOC
> Modules linked in: usb_storage e100 mii
>=20
> Pid: 1628, comm: creven Not tainted (2.6.24.7-ipipe #3)
> EIP: 0060:[<c017fb49>] EFLAGS: 00010246 CPU: 0
> EIP is at page_dup_rmap+0x19/0x20
> EAX: c115e760 EBX: c115e760 ECX: 08048000 EDX: cc6b1200
> ESI: 09cbb025 EDI: 00000025 EBP: 08048000 ESP: cc709ec4
>  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
> Process creven (pid: 1628, ti=3Dcc708000 task=3Dcc6f6ac0 task.ti=3Dcc70=
8000)<0>
> I-pipe domain Linux
> Stack: 08003875 c017ae62 cc6b1200 cd5d9e70 cc6b4e70 cc6fa080 cc650080=20
> 08057000
>        08057000 c115e760 cd034120 c9cba120 00000000 00000000 08056fff=20
> 00000000
>        00000000 c9c6ec80 cc6b1200 00000000 cc6a6ac0 c0115b90 00000000=20
> 00000000
> Call Trace:
>  [<c017ae62>] copy_page_range+0x2b2/0x580
>  [<c0115b90>] copy_process+0x7a0/0x1000
>  [<c01165a7>] do_fork+0x47/0x210
>  [<c0100bb6>] sys_clone+0x36/0x40
>  [<c0102b89>] syscall_call+0x7/0xb
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Code: 3b 4b 08 0f 93 c0 85 c0 75 ba 5b 89 c8 c3 8d 74 26 00 53 89 c3 83=
=20
> 78 08 ff 74 10 f6 40 10 01 74 05 e8 3c f4 ff ff ff 43 08 5b c3 <0f> 0b=20
> eb fe 8d 76 00 83 ec 1c 89 5c 24 0c 89 c3 89 74 24 10 89
> EIP: [<c017fb49>] page_dup_rmap+0x19/0x20 SS:ESP 0068:cc709ec4
> ---[ end trace b9f3cc48844f8a3b ]---
> note: creven[1628] exited with preempt_count 2
> BUG: scheduling while atomic: creven/1628/0x00000003
> Pid: 1628, comm: creven Tainted: G      D 2.6.24.7-ipipe #3
>  [<c036bed3>] schedule+0x283/0x390
>  [<c036d525>] rwsem_down_failed_common+0x75/0x190
>  [<c013cb10>] handle_edge_irq+0xc0/0x150
>  [<c036d68d>] rwsem_down_read_failed+0x1d/0x24
>  [<c036d6cb>] call_rwsem_down_read_failed+0x7/0xc
>  [<c036cb89>] down_read+0x9/0x10
>  [<c0118ed4>] exit_mm+0x24/0xd0
>  [<c011a632>] do_exit+0x112/0x800
>  [<c010410f>] die+0x21f/0x220
>  [<c0104523>] do_invalid_op+0x83/0x90
>  [<c017fb49>] page_dup_rmap+0x19/0x20
>  [<c0111998>] change_page_attr+0x2c8/0x300
>  [<c01119ed>] kernel_map_pages+0x1d/0x60
>  [<c0170472>] get_page_from_freelist+0x2c2/0x520
>  [<c010e78f>] __ipipe_handle_exception+0x7f/0x1c0
>  [<c036db5b>] error_code+0x6f/0x7c
>  [<c0170000>] setup_per_zone_pages_min+0x1b0/0x1f0
>  [<c017fb49>] page_dup_rmap+0x19/0x20
>  [<c017ae62>] copy_page_range+0x2b2/0x580
>  [<c0115b90>] copy_process+0x7a0/0x1000
>  [<c01165a7>] do_fork+0x47/0x210
>  [<c0100bb6>] sys_clone+0x36/0x40
>  [<c0102b89>] syscall_call+0x7/0xb
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This once fixed it for me, but we still need to take a closer look on
this. Gilles, any news regarding this?

Jan

---
 mm/memory.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/mm/memory.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -502,7 +502,7 @@ copy_one_pte(struct mm_struct *dst_mm, s
 				pte =3D pte_mkclean(pte);
 			pte =3D pte_mkold(pte);
=20
-			page_dup_rmap(uncow_page, vma, addr);
+			page_add_new_anon_rmap(uncow_page, vma, addr);
 			rss[!!PageAnon(uncow_page)]++;
 			goto out_set_pte;
 		}

--=20
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

