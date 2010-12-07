Message-ID: <4CFE1E35.3020603@domain.hid>
Date: Tue, 07 Dec 2010 12:44:53 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060802090006030201000808"
Subject: [Xenomai-core] Problem with gcc-4.5.1
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------060802090006030201000808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

When compiling Xenomai on Fedora-14 with gcc-4.5.1 [version 4.5.1 
20100924 (Red Hat 4.5.1-4)], the loading of xeno_nucleus fails with the 
attached kernel OOPS, a notable difference between the 4.5.1 compiled 
version and a working one built with gcc-4.4.4 on the same system with 
the same configuration, sis tthat __rthal_x86_nodiv_ullimd is not 
inlined, is this anybody has seen before?


Regards

Anders Blomdell

-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden


--------------060802090006030201000808
Content-Type: text/plain;
 name="oops"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="oops"

BUG: unable to handle kernel NULL pointer dereference at 00000008
IP: [<fbf25804>] __rthal_x86_nodiv_ullimd+0x5c/0x74 [xeno_nucleus]
*pdpt = 0000000001d91001 *pde = 0000000000000000 
Oops: 0000 [#1] SMP 
last sysfs file: /sys/module/microcode/initstate
Modules linked in: xeno_nucleus(+) e1000 snd_timer snd e1000e soundcore iTCO_wdt i2c_i801 serio_raw iTCO_vendor_support snd_page_alloc microcode(+) pcspkr pata_acpi firewire_ohci ata_generic firewire_core crc_itu_t pata_marvell nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core

Pid: 519, comm: modprobe Not tainted 2.6.35.7_xenomai-2.5.5.2_rtnet-39f7fcf #1 DP35DP/

EIP: 0060:[<fbf25804>] EFLAGS: 00010246 CPU: 0
EIP is at __rthal_x86_nodiv_ullimd+0x5c/0x74 [xeno_nucleus]
EAX: 00000000 EBX: b36c048c ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: 00000000 EBP: c1ef1f34 ESP: c1ef1f18
DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
Process modprobe (pid: 519, ti=c1ef0000 task=c1e04080 task.ti=c1ef0000)
I-pipe domain Linux
Stack:
00000000 00000000 665d7cba b36c048c 00000000 b36c048c 665d7cba c1ef1f54
<0> fbf25887 b36c048c 665d7cba 00000002 00000001 00000004 665d7cba c1ef1f60
<0> fbf25a3f 00000000 c1ef1f84 fbcaf215 00000000 1194d800 00000001 3b9aca00
Call Trace:
[<fbf25887>] ? xnarch_ns_to_tsc+0x34/0x4a [xeno_nucleus]
[<fbf25a3f>] ? xnarch_calibrate_sched+0x1a/0xf2 [xeno_nucleus]
[<fbcaf215>] ? __xeno_sys_init+0x189/0x2fd [xeno_nucleus]
[<fbcaf08c>] ? __xeno_sys_init+0x0/0x2fd [xeno_nucleus]
[<c0401263>] ? do_one_initcall+0x62/0x16f
[<c046843c>] ? sys_init_module+0x7f/0x19d
[<c040299d>] ? sysenter_do_call+0x12/0x16
Code: f0 89 d1 d1 e0 83 d1 00 83 d6 00 83 d7 00 8b 45 e4 f7 65 f0 01 c1 11 d6 83 d7 00 8b 45 e8 f7 65 ec 01 c1 11 d6 83 d7 00 8b 45 e8 <f7> 67 08 01 f0 11 d7 8b 55 e4 0f af 57 08 01 fa 83 c4 10 5b 5e 
EIP: [<fbf25804>] __rthal_x86_nodiv_ullimd+0x5c/0x74 [xeno_nucleus] SS:ESP 0068:c1ef1f18
CR2: 0000000000000008

--------------060802090006030201000808--

