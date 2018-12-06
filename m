Subject: Re: [I-PIPE] ipipe-core-4.9.135-x86-7 released
References: <E1gHtmu-0002xR-FI@xenomai.org>
 <653100543.20966555.1541129646273@mail.yahoo.com>
 <009db19b-cb18-095c-2fda-eb9beaa7767c@siemens.com>
 <1378793b-2c18-1e51-937c-3ce14a7bb9e9@xenomai.org>
 <af13cc5e-a076-5618-e8f2-a62284a8493c@xenomai.org>
 <1782609254.2693150.1544069354612@mail.yahoo.com>
From: limingyu <myli@linx-info.com>
Message-ID: <648d4857-fd53-7cbf-974f-e18ce5759f71@linx-info.com>
Date: Thu, 6 Dec 2018 13:45:44 +0800
MIME-Version: 1.0
In-Reply-To: <1782609254.2693150.1544069354612@mail.yahoo.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Alec Ari <neotheuser@ymail.com>
Cc: xenomai@xenomai.org, duanwujie <wjduan@linx-info.com>, =?UTF-8?B?5b+X6IiqIOW9rQ==?= <zhpeng@linx-info.com>, =?UTF-8?B?5YiY5bKz5a6B?= <ynliu@linx-info.com>

I have used this patch(ipipe-core-4.9.135-x86-7.patch) for a test usage 
and I got a machine halt after I run the latency test program of 
Xenomai.The problem seems caused by  the fpu_restore function. Could you 
please fix it in the next patch release?

And here is the result of the panic message:

root@linx:/usr/xenomai/bin# ./latency
[   31.196143] Kernel panic - not syncing: Machine halted.
[   31.196143] CPU: 0 PID: 308 Comm: latency Tainted: G W       4.9.135 1
[   31.196143] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.114
[   31.196143] I-pipe domain: Linux
[   31.196143]  0000000000000000 ffffffff813c2f7f ffff88003fc07f00 
ffff88003fc08
[   31.196143]  ffffffff81a18aa6 ffffffff811a69a6 ffffffff00000008 
ffff88003fc08
[   31.196143]  ffff88003fc07ea0 b2644bdcd9892477 ffff88003fc07d72 
0000000080006
[   31.196143] Call Trace:
[   31.196143]  <#DF> [   31.196143] [<ffffffff813c2f7f>] ? 
dump_stack+0xb5/0x6
[   31.196143]  [<ffffffff811a69a6>] ? panic+0xf4/0x24d
[   31.196143]  [<ffffffff81048959>] ? df_debug+0x29/0x30
[   31.196143]  [<ffffffff810180cc>] ? do_double_fault+0xfc/0x1c0
[   31.196143]  [<ffffffff816cd492>] ? double_fault+0x22/0x30
[   31.196143]  [<ffffffff816cd429>] ? device_not_available+0x9/0x50
[   31.196143]  <EOE> [   31.196143] [<ffffffff810220af>] ? 
fpu__restore+0x7f/0
[   31.196143]  [<ffffffff81022059>] ? fpu__restore+0x29/0x2a0
[   31.196143]  [<ffffffff81017610>] ? do_device_not_available+0x70/0xb0
[   31.196143]  [<ffffffff816cd438>] ? device_not_available+0x18/0x50
[   31.196143]  [<ffffffff810220af>] ? fpu__restore+0x7f/0x2a0
[   31.196143]  [<ffffffff81022059>] ? fpu__restore+0x29/0x2a0
[   31.196143]  [<ffffffff81017610>] ? do_device_not_available+0x70/0xb0
[   31.196143]  [<ffffffff816cd438>] ? device_not_available+0x18/0x50
[   31.196143]  [<ffffffff810220af>] ? fpu__restore+0x7f/0x2a0
[   31.196143]  [<ffffffff81022059>] ? fpu__restore+0x29/0x2a0
[   31.196143]  [<ffffffff81017610>] ? do_device_not_available+0x70/0xb0
[   31.196143]  [<ffffffff816cd438>] ? device_not_available+0x18/0x50
[   31.196143]  [<ffffffff810220af>] ? fpu__restore+0x7f/0x2a0
[   31.196143]  [<ffffffff81022059>] ? fpu__restore+0x29/0x2a0

... a bunch of the same repeated fpu_restore call trace message

and the panic message just repeated again:

[   31.196143] Kernel Offset: disabled
[   31.196143] ------------[ cut here ]------------
[   31.196143] WARNING: CPU: 0 PID: 308 at 
./arch/x86/include/asm/fpu/internal.0
[   31.196143] Modules linked in: bochs_drm ttm drm_kms_helper kvm_amd 
kvm drm 4
[   31.196143] CPU: 0 PID: 308 Comm: latency Not tainted 4.9.135 #1
[   31.196143] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.114
[   31.196143] I-pipe domain: Linux
[   31.196143]  0000000000000000 ffffffff813c2f7f 0000000000000000 
0000000000000
[   31.196143]  ffffffff81a08640 ffffffff8106a01e ffff88003b782b40 
0000000000002
[   31.196143]  0000000000000046 00007ffd089a3730 00007fcadaf0bcc0 
00007fcadaf00
[   31.196143] Call Trace:
[   31.196143]  [<ffffffff813c2f7f>] ? dump_stack+0xb5/0xd6
[   31.196143]  [<ffffffff8106a01e>] ? __warn+0xbe/0xe0
[   31.196143]  [<ffffffff810221f7>] ? fpu__restore+0x1c7/0x2a0
[   31.196143]  [<ffffffff81017610>] ? do_device_not_available+0x70/0xb0
[   31.196143]  [<ffffffff816cd438>] ? device_not_available+0x18/0x50
[   31.196143] ---[ end trace d4d67159519af321 ]---
[   31.196143] ------------[ cut here ]------------
[   31.196143] WARNING: CPU: 0 PID: 308 at 
./arch/x86/include/asm/fpu/internal.0
[   31.196143] Modules linked in: bochs_drm ttm drm_kms_helper kvm_amd 
kvm drm 4
[   31.196143] CPU: 0 PID: 308 Comm: latency Tainted: G W       4.9.135 1
[   31.196143] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.114
[   31.196143] I-pipe domain: Linux
[   31.196143]  0000000000000000 ffffffff813c2f7f 0000000000000000 
0000000000000
[   31.196143]  ffffffff81a08640 ffffffff8106a01e ffff88003b782b40 
0000000000006
[   31.196143]  0000000000000046 00007ffd089a3730 00007fcadaf0bcc0 
00007fcadaf00
[   31.196143] Call Trace:
[   31.196143]  [<ffffffff813c2f7f>] ? dump_stack+0xb5/0xd6
[   31.196143]  [<ffffffff8106a01e>] ? __warn+0xbe/0xe0
[   31.196143]  [<ffffffff81022266>] ? fpu__restore+0x236/0x2a0
[   31.196143]  [<ffffffff81017610>] ? do_device_not_available+0x70/0xb0
[   31.196143]  [<ffffffff816cd438>] ? device_not_available+0x18/0x50
[   31.196143]  [<ffffffff810220af>] ? fpu__restore+0x7f/0x2a0
[   31.196143]  [<ffffffff810221f7>] ? fpu__restore+0x1c7/0x2a0
[   31.196143]  [<ffffffff81017610>] ? do_device_not_available+0x70/0xb0
[   31.196143]  [<ffffffff816cd438>] ? device_not_available+0x18/0x50
[   31.196143] ---[ end trace d4d67159519af322 ]---
[   31.196143] PANIC: double fault, error_code: 0x0
[   31.196143] CPU: 0 PID: 308 Comm: latency Tainted: G W       4.9.135 1
[   31.196143] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.114
[   31.196143] I-pipe domain: Linux
[   31.196143] task: ffff88003b782000 task.stack: ffffc90000914000
[   31.196143] RIP: 0010:[<ffffffff816cd429>] [<ffffffff816cd429>] 
device_not_0
[   31.196143] RSP: 0000:ffffc90000913f98  EFLAGS: 00000083
[   31.196143] RAX: 0000000000000000 RBX: ffff88003b782b40 RCX: 
0000000000000046
[   31.196143] RDX: 00000000ffffffff RSI: 0000000000000000 RDI: 
ffff88003b782b80
[   31.196143] RBP: 0000000000000046 R08: 0000000000000046 R09: 
000000000000000f
[   31.196143] R10: 00007ffd089a36fc R11: ffffffff81f4689f R12: 
0000000000000046
[   31.196143] R13: 00007ffd089a3730 R14: 00007fcadaf0bcc0 R15: 
00007fcadaf0bcc0
[   31.196143] FS:  00007fcadb123740(0000) GS:ffff88003fc00000(0000) 
knlGS:00000
[   31.196143] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[   31.196143] CR2: 00007fcada0dbc70 CR3: 000000003cef3000 CR4: 
00000000000006f0
[   31.196143] Stack:
[   31.196143] Call Trace:
[   31.196143]  [<ffffffff810220af>] ? fpu__restore+0x7f/0x2a0
[   31.196143]  [<ffffffff81022059>] ? fpu__restore+0x29/0x2a0
[   31.196143]  [<ffffffff81017610>] ? do_device_not_available+0x70/0xb0
[   31.196143]  [<ffffffff816cd438>] ? device_not_available+0x18/0x50
[   31.196143]  [<ffffffff810220af>] ? fpu__restore+0x7f/0x2a0
[   31.196143]  [<ffffffff81022059>] ? fpu__restore+0x29/0x2a0
[   31.196143]  [<ffffffff81017610>] ? do_device_not_available+0x70/0xb0
[   31.196143]  [<ffffffff816cd438>] ? device_not_available+0x18/0x50
[   31.196143]  [<ffffffff810220af>] ? fpu__restore+0x7f/0x2a0
[   31.196143]  [<ffffffff81022059>] ? fpu__restore+0x29/0x2a0

... a other bunch of the same repeated fpu_restore call trace message

and last ended with those lines:

[   31.196143]  [<ffffffff81017610>] ? do_device_not_available+0x70/0xb0
[   31.196143]  [<ffffffff816cd438>] ? device_not_available+0x18/0x50
[   31.196143] Code: 64 24 18 48 8b 6c 24 20 48 8b 5c 24 28 fa 85 c0 0f 
85 08 f
[   31.196143] ---[ end Kernel panic - not syncing: Machine halted.

On 12/6/18 12:09 PM, Alec Ari via Xenomai wrote:
> Hey Philippe, thank you!
>
> Alec
>
-- 
Linx Software Co. Ltd. Sichuan Branch
E-mail: myli@linx-info.com


