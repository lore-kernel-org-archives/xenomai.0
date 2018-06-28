From: =?UTF-8?Q?St=C3=A9phane_Reichert?= <sreichert@sepro-group.com>
Date: Thu, 28 Jun 2018 17:28:29 +0200 (CEST)
Message-ID: <008d01d40ef4$aa152ab0$fe3f8010$@sepro-group.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: fr
Subject: [Xenomai] Assertion current-magic 0 failed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I am testing the new version 3.0.7 on our system (iMX 6 on 4.1.46 kernel), 
and I would like to know
if anybody else encountered this error :

threadobj.c:1344: threadobj_prologue: Assertion `current->magic == 0' 
failed.

I compile the kernel with --enable-pshared --enable 
registry --enable-debug=full.

Here is a backtrace I get on the debug signal callback:

# Mode switch (reason: triggered fault), aborting. Backtrace:
Retrieve backtrace...
./tests_integration_lib_ipc(Unable to handle kernel NULL pointer dereference 
at virtual address 00000004
4x180)[0[x01020206000]08l0e0r0+
]]/ l*ipbd=39180831/libc.so.,6 (*+p0txe2=50105000)0[00, 
*ppte=000000000x76ca3150

/lib/libcopperplate.so.0(syncobj_lIonctke+r0nxa8l4 error: Oops: 17 [#1] 
PREEMPT SMP ARM
l0x76Meo1dau7lee8s]
 i/nlkiebd/in:libcopper pcltarte.so.0(syncluster_fin 
dcocbmj+0x34)[0x76e18eec]
/lib/li buaslbc_hfe_mayc.mso.0(al u_serialchemy_bind 
_uosbbj_efc_te+c0mx98)[0x76e 3ge_1ccd0c]
nlib/libalchemy.so. 0u(_rett_hheerap_bind+0x30 libcomposite)[0x76e411c 4c]o
 f/irgofost/libs/lib_ iwplc1.2sxox(init_local_data+0x6 0w)l[c0oxr7e6f1085c]
/roo mac80211t/libs/li bc_figp8c0.2s1o1(rt_shm_open+ 0rxf7k0i)l[l0x76f10bfc]
 /tests _filnetxecgarnation_lib_ip wlcore_sdioc[0x12d68]
dc/il_ihbd/rlci_biamlchemy. suos.b0m(i+s0cx_ai4m4x8)[0x76e43 4c4i8_]h
]r/clib/libcoppe udc_corerplate.so. 0c(a+n0_xd8e3v14)[0x76e1a314

Ulib/libcobalt.so.2(+0x1058c)[0x76df558cC]P
 : 1 PID: 296 Comm: Reception task  Not tainted 4.1.46-ipipe #6
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
task: a885dd80 ti: a97fa000 task.ti: a97fa000
PC is at cobalt_signal_send+0xf8/0x1f8
LR is at 0x18
pc : [<800acedc>]    lr : [<00000018>]    psr: a0080093
sp : a97fbf00  ip : a94ff948  fp : 8095f680
r10: ab70e6e0  r9 : 00000124  r8 : 8088c880
r7 : 00000001  r6 : 00000000  r5 : 00800000  r4 : a94ff4d8
r3 : 00000017  r2 : 00000000  r1 : c08f9000  r0 : c09e5800
Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c53c7d  Table: 38ec804a  DAC: 00000015
Process Reception task  (pid: 296, stack limit = 0xa97fa220)
Stack: (0xa97fbf00 to 0xa97fc000)
bf00: 00000018 c08f9000 c09e5800 800ad534 c09e5800 00000018 00000001 
00000000
bf20: 8088c880 808945fc 00000018 800ad788 c09e9008 00000022 a97fbfb0 
800ad71c
bf40: 808945fc 00000001 ab70e6e0 800ae248 762bce38 a97fbfb0 808945fc 
20080013
bf60: 00000001 ab70d6e0 8095f680 8088b6e0 ab70e6e0 8008a14c 8095f680 
a97fbfb0
bf80: 8088b6e0 8088da20 04000004 762bce14 762bce38 00000000 000f0042 
8000f028
bfa0: a97fa000 00000002 762718cc 8000ef84 10000040 00000124 00000018 
00000124
bfc0: 762bce14 762bce38 00000000 000f0042 76f23594 0001e030 76271c74 
762718cc
bfe0: 00000018 76271870 000122ac 76df5148 20080010 10000040 8473a46f 
c307ae3a
[<800acedc>] (cobalt_signal_send) from [<800ad534>] 
(__cobalt_kill+0x190/0x1b0)
[<800ad534>] (__cobalt_kill) from [<800ad788>] (CoBaLt_kill+0x6c/0xcc)
[<800ad788>] (CoBaLt_kill) from [<800ae248>] (ipipe_syscall_hook+0xfc/0x270)
[<800ae248>] (ipipe_syscall_hook) from [<8008a14c>] 
(__ipipe_notify_syscall+0xa8/0x1a4)
[<8008a14c>] (__ipipe_notify_syscall) from [<8000ef84>] 
(pipeline_syscall+0x8/0x24)
Code: e5813084 e583c000 e8bd8070 e59421b0 (e592c004)
---[ end trace fcd211fc12a8e500 ]---
tests_integration_lib_ipc: threadobj.c:1344: threadobj_prologue: Assertion 
`current->magic == 0' failed.

[2]+  Aborted                    ./tests_integration_lib_ipc --session=rct 
cha
#

Best regards
Stephane


