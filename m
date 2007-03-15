Message-ID: <45F8B5BF.6070403@domain.hid>
Date: Thu, 15 Mar 2007 04:55:59 +0200
From: Maksym Veremeyenko <verem@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] mem usage and other application
References: <45F86426.9000309@domain.hid>	<17912.26777.313494.393466@domain.hid>	<45F87970.5060506@domain.hid>	<17912.31765.786905.929691@domain.hid>	<45F87F03.9090202@domain.hid>	<17912.32723.685853.878873@domain.hid>	<45F884EC.3060006@domain.hid>	<17912.34386.408353.651285@domain.hid>	<45F88C71.2070804@domain.hid>
	<17912.37052.725635.483595@domain.hid>
In-Reply-To: <17912.37052.725635.483595@domain.hid>
Content-Type: text/plain; charset=KOI8-U; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Xenomai-help@domain.hid

Gilles Chanteperdrix =D0=C9=DB=C5=D4:

> Well, it really looks like an FPU bug. Could you try to:
> - upgrade your trunk to latest revision, then test
> - then apply the attached patch to your up-to-date trunk, then test
>   again ?
>=20

I used configuration 2.6.17.14, xenomai-r2299

Before patching xenomai result was the same and more faulty after=20
decreasing RAM size down to 256M.

After applying patch situation become worth, i got "Bad pte" messages,=20
sometimes "Soft lockup detected", and kernel dump:

Mar 15 04:08:21 dev-3 kernel: Bad pte =3D 42a5fef8, process =3D ???,=20
vm_flags =3D 100073, vaddr =3D 42f60000
Mar 15 04:08:21 dev-3 kernel:  <c0102f70> show_trace+0x12/0x14=20
<c0103474> dump_stack+0x1c/0x1e
Mar 15 04:08:21 dev-3 kernel:  <c015c460> print_bad_pte+0x4f/0x5a=20
<c015c4b1> vm_normal_page+0x46/0x5c
Mar 15 04:08:21 dev-3 kernel:  <c015c9d4> unmap_vmas+0x162/0x3e4=20
<c015f059> exit_mmap+0x55/0xc1
Mar 15 04:08:21 dev-3 kernel:  <c010feb8> mmput+0x5a/0xb0  <c0113161>=20
exit_mm+0xe8/0xee
Mar 15 04:08:21 dev-3 kernel:  <c011459f> do_exit+0x1a2/0x719=20
<c010d21f> do_page_fault+0x4bf/0x542
Mar 15 04:08:21 dev-3 kernel:  <c010b1da>=20
__ipipe_handle_exception+0x89/0xbf  <c0102988> error_code+0x54/0x64

Mar 15 04:08:21 dev-3 kernel: Bad pte =3D 42a5fef8, process =3D ???,=20
vm_flags =3D 75, vaddr =3D 42f62000
Mar 15 04:08:21 dev-3 kernel:  <c0102f70> show_trace+0x12/0x14=20
<c0103474> dump_stack+0x1c/0x1e
Mar 15 04:08:21 dev-3 kernel:  <c015c460> print_bad_pte+0x4f/0x5a=20
<c015c4b1> vm_normal_page+0x46/0x5c
Mar 15 04:08:21 dev-3 kernel:  <c015c9d4> unmap_vmas+0x162/0x3e4=20
<c015f059> exit_mmap+0x55/0xc1
Mar 15 04:08:21 dev-3 kernel:  <c010feb8> mmput+0x5a/0xb0  <c0113161>=20
exit_mm+0xe8/0xee
Mar 15 04:08:21 dev-3 kernel:  <c011459f> do_exit+0x1a2/0x719=20
<c010d21f> do_page_fault+0x4bf/0x542
Mar 15 04:08:21 dev-3 kernel:  <c010b1da>=20
__ipipe_handle_exception+0x89/0xbf  <c0102988> error_code+0x54/0x64

Mar 15 04:08:23 dev-3 kernel: ------------[ cut here ]------------
Mar 15 04:08:23 dev-3 kernel: kernel BUG at mm/rmap.c:560!
Mar 15 04:08:23 dev-3 kernel: invalid opcode: 0000 [#1]
Mar 15 04:08:23 dev-3 kernel: Modules linked in: xeno_16550A
Mar 15 04:08:23 dev-3 kernel: CPU:    0
Mar 15 04:08:23 dev-3 kernel: EIP:    0060:[<c01619f0>]    Not tainted VL=
I
Mar 15 04:08:23 dev-3 kernel: EFLAGS: 00010286=20
(2.6.17.14-xenomai-r2299-min-debug #3)
Mar 15 04:08:23 dev-3 kernel: EIP is at page_remove_rmap+0x1b/0x32
Mar 15 04:08:23 dev-3 kernel: eax: ffffffff   ebx: c1000000   ecx:=20
c04d2aec   edx: c1000000
Mar 15 04:08:23 dev-3 kernel: esi: b7f79000   edi: d36f1de4   ebp:=20
d351dce4   esp: d351dce4
Mar 15 04:08:23 dev-3 kernel: ds: 007b   es: 007b   ss: 0068
Mar 15 04:08:23 dev-3 kernel: Process bash (pid: 2698,=20
threadinfo=3Dd351c000 task=3Dd500c030)
Mar 15 04:08:23 dev-3 kernel: Stack: d351dd3c c015caa6 00000000 d341f6fc=20
d351dd54 00000000 00000001 b7fb3000
Mar 15 04:08:23 dev-3 kernel:        d3a5eb7c d55faa1c c04d2aec 00000000=20
ffffffff d55faa6c d3a5eb7c 00000019
Mar 15 04:08:23 dev-3 kernel:        003a4c2b b7fb3000 00000000 d351dd54=20
d3a08e04 d55faa1c d351dd64 c015f059
Mar 15 04:08:23 dev-3 kernel: Call Trace:
Mar 15 04:08:23 dev-3 kernel:  <c0102f26> show_stack_log_lvl+0x8a/0x94=20
<c01030ba> show_registers+0x148/0x1b4
Mar 15 04:08:23 dev-3 kernel:  <c010328a> die+0x164/0x262  <c0103409>=20
do_trap+0x81/0x9b
Mar 15 04:08:23 dev-3 kernel:  <c0103b5e> do_invalid_op+0x8e/0x98=20
<c010b1da> __ipipe_handle_exception+0x89/0xbf
Mar 15 04:08:23 dev-3 kernel:  <c0102988> error_code+0x54/0x64=20
<c015caa6> unmap_vmas+0x234/0x3e4
Mar 15 04:08:23 dev-3 kernel:  <c015f059> exit_mmap+0x55/0xc1=20
<c010feb8> mmput+0x5a/0xb0
Mar 15 04:08:23 dev-3 kernel:  <c0175321> flush_old_exec+0x599/0x7c6=20
<c01904ad> load_elf_binary+0x4bf/0x1478
Mar 15 04:08:23 dev-3 kernel:  <c0174718>=20
search_binary_handler+0x76/0x181  <c018f8e7> load_script+0x1b7/0x1cc
Mar 15 04:08:23 dev-3 kernel:  <c0174718>=20
search_binary_handler+0x76/0x181  <c01760f5> do_execve+0x13f/0x1ac
Mar 15 04:08:23 dev-3 kernel:  <c010142b> sys_execve+0x2f/0x76=20
<c010269e> sysenter_past_esp+0x63/0x67
Mar 15 04:08:23 dev-3 kernel: Code: e8 7a 4b 13 00 8b 45 d0 83 c4 24 5b=20
5e 5f c9 c3 55 89 e5 e8 33 98 fa ff 89 c2 83 40 08 f
Mar 15 04:08:23 dev-3 kernel: EIP: [<c01619f0>]=20
page_remove_rmap+0x1b/0x32 SS:ESP 0068:d351dce4

With latest trunk and 256MB i get stable errors even with "perl=20
Makefile.PL" for  XML-DOM-1.44 then any RT application used Native skin=20
running.


--=20
________________________________________
Maksym Veremeyenko

