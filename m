From: =?UTF-8?Q?St=C3=A9phane_Reichert?= <sreichert@sepro-group.com>
References: <008d01d40ef4$aa152ab0$fe3f8010$@sepro-group.com>
 <f91caf3e-5b65-298a-1ac6-91697eed90c3@xenomai.org>
In-Reply-To: <f91caf3e-5b65-298a-1ac6-91697eed90c3@xenomai.org>
Date: Fri, 29 Jun 2018 08:57:38 +0200 (CEST)
Message-ID: <00a901d40f76$771290d0$6537b270$@sepro-group.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Assertion current-magic 0 failed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

Sorry about that.

Here is a better trace:
Mode switch (reason: triggered fault), aborting. Backtrace:
[Xenomai] switching Reception task shmem to secondary mode after exceptio=
n=20
#0 in kernel-space at 0x800aced8 (pid 327)
Unable to handle kernel paging request at virtual address ffeccffe
pgd =3D a96dc000
[ffeccffe] *pgd=3D3bf5e821, *pte=3D00000000, *ppte=3D00000000
Internal error: Oops: 17 [#2] PREEMPT SMP ARM
Modules linked in: ctr ccm usb_f_acm u_serial usb_f_ecm g_cdc u_ether=20
libcomposite configfs wl12xx wlcore mac80211 cfg80211 rfkill flexcan=20
wlcore_sdio ci_h                             drc_imx usbmisc_imx ci_hdrc=20
udc_core can_dev
CPU: 2 PID: 327 Comm: Reception task  Tainted: G      D         4.1.46-ip=
ipe=20
#6
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
task: a8bfb740 ti: a9e0c000 task.ti: a9e0c000
/lib/libc.so.6(+0x25150) [0x7P6Cdis at cobalt_signal_send+0xf8/0x1f8
07150]
/lib/libcopperplate.so.0(syncobj_lock+0x84) [0x76e7e7e8]
/lib/libcopperplate.so.0(syncluster_findobj+0x34) [0x76e7ceec]
/lib/libalchemy.so.0(alchemy_bind_object+0x98) [0x76ea21c0]
/lib/libalchemy.so.0(rt_heap_bind+0x30) [0x76ea51c4]
/root/libs/lib_ipc.so(init_local_data+0x60) [0x76f7485c]
/root/libs/lib_ipc.so(rt_shm_open+0x70) [0x76f74bfc]
./tests_integration_lib_ipc() [0x12de0]
/lib/libalchemy.so.0(+0xa448) [0x76ea7448]
/lib/libcopperplate.so.0(+0x8314) [0x76e7e314]
/lib/libcobalt.so.2(+0x1058c) [0x76e5958c]
LR is at 0x18
pc : [<800acedc>]    lr : [<00000018>]    psr: 80070093
sp : a9e0df00  ip : a94fd948  fp : 8095f680
r10: ab71c6e0  r9 : 00000142  r8 : 8088c880
r7 : 00000001  r6 : 00000000  r5 : 00800000  r4 : a94fd4d8
r3 : 00000017  r2 : ffeccffa  r1 : c08f9088  r0 : c09e5800
Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c53c7d  Table: 396dc04a  DAC: 00000015
Process Reception task  (pid: 327, stack limit =3D 0xa9e0c220)
Stack: (0xa9e0df00 to 0xa9e0e000)
df00: 00000018 c08f9088 c09e5800 800ad534 c09e5800 00000018 00000001=20
00000000
df20: 8088c880 808945fc 00000018 800ad788 c09e9008 00000022 a9e0dfb0=20
800ad71c
df40: 808945fc 00000001 ab71c6e0 800ae248 76320e38 a9e0dfb0 808945fc=20
20070013
df60: 00000001 ab71b6e0 8095f680 8088b6e0 ab71c6e0 8008a14c 8095f680=20
a9e0dfb0
df80: 8088b6e0 8088da20 00000007 76320e14 76320e38 00000000 000f0042=20
8000f028
dfa0: a9e0c000 00000002 761cc8cc 8000ef84 10000040 00000142 00000018=20
00000142
dfc0: 76320e14 76320e38 00000000 000f0042 76f87594 0001e030 761ccc74=20
761cc8cc
dfe0: 00000018 761cc868 00012318 76e59148 20070010 10000040 00000000=20
00000000
[<800acedc>] (cobalt_signal_send) from [<800ad534>]=20
(__cobalt_kill+0x190/0x1b0)
[<800ad534>] (__cobalt_kill) from [<800ad788>] (CoBaLt_kill+0x6c/0xcc)
[<800ad788>] (CoBaLt_kill) from [<800ae248>] (ipipe_syscall_hook+0xfc/0x2=
70)
[<800ae248>] (ipipe_syscall_hook) from [<8008a14c>]=20
(__ipipe_notify_syscall+0xa8/0x1a4)
[<8008a14c>] (__ipipe_notify_syscall) from [<8000ef84>]=20
(pipeline_syscall+0x8/0x24)
Code: e5813084 e583c000 e8bd8070 e59421b0 (e592c004)
---[ end trace fcd211fc12a8e501 ]---
tests_integration_lib_ipc: threadobj.c:1344: threadobj_prologue: Assertio=
n=20
`current->magic =3D=3D 0' failed.

St=C3=A9phane

-----Message d'origine-----
De : Philippe Gerum [mailto:rpm@xenomai.org]
Envoy=C3=A9 : jeudi 28 juin 2018 17:38
=C3=80 : St=C3=A9phane Reichert; xenomai@xenomai.org
Objet : Re: [Xenomai] Assertion current-magic 0 failed

On 06/28/2018 05:28 PM, St=C3=A9phane Reichert wrote:
> Hi,
>
> I am testing the new version 3.0.7 on our system (iMX 6 on 4.1.46
> kernel), and I would like to know if anybody else encountered this
> error :
>
> threadobj.c:1344: threadobj_prologue: Assertion `current->magic =3D=3D =
0'
> failed.
>
> I compile the kernel with --enable-pshared --enable registry
> --enable-debug=3Dfull.
>
> Here is a backtrace I get on the debug signal callback:
>
> # Mode switch (reason: triggered fault), aborting. Backtrace:
> Retrieve backtrace...
> ./tests_integration_lib_ipc(Unable to handle kernel NULL pointer
> dereference at virtual address 00000004
> 4x180)[0[x01020206000]08l0e0r0+ ]]/ l*ipbd=3D39180831/libc.so.,6
> (*+p0txe2=3D50105000)0[00,
> *ppte=3D000000000x76ca3150
>
> /lib/libcopperplate.so.0(syncobj_lIonctke+r0nxa8l4 error: Oops: 17
> [#1] PREEMPT SMP ARM l0x76Meo1dau7lee8s]  i/nlkiebd/in:libcopper
> pcltarte.so.0(syncluster_fin
> dcocbmj+0x34)[0x76e18eec]
> /lib/li buaslbc_hfe_mayc.mso.0(al u_serialchemy_bind
> _uosbbj_efc_te+c0mx98)[0x76e 3ge_1ccd0c] nlib/libalchemy.so.
> 0u(_rett_hheerap_bind+0x30 libcomposite)[0x76e411c 4c]o
> f/irgofost/libs/lib_ iwplc1.2sxox(init_local_data+0x6
> 0w)l[c0oxr7e6f1085c] /roo mac80211t/libs/li
> bc_figp8c0.2s1o1(rt_shm_open+ 0rxf7k0i)l[l0x76f10bfc]  /tests
> _filnetxecgarnation_lib_ip wlcore_sdioc[0x12d68]
> dc/il_ihbd/rlci_biamlchemy. suos.b0m(i+s0cx_ai4m4x8)[0x76e43 4c4i8_]h
> ]r/clib/libcoppe udc_corerplate.so. 0c(a+n0_xd8e3v14)[0x76e1a314
>

It looks like there are two backtraces, one generated from the app in=20
userland, a second one by the kernel, none of them is readable as they=20
intermingle.

--
Philippe.

