Subject: Re: [PATCH v3 1/7] testsuite/smokey: add virtual CAN testsuite
References: <20211205204518.13259-1-dariobin@libero.it>
 <20211205204518.13259-2-dariobin@libero.it>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0c5dff3d-7bbd-4193-f2d3-bb280ec43252@siemens.com>
Date: Fri, 10 Dec 2021 11:25:22 +0100
MIME-Version: 1.0
In-Reply-To: <20211205204518.13259-2-dariobin@libero.it>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dario Binacchi <dariobin@libero.it>, xenomai@xenomai.org
Cc: "Stephen J . Battazzo" <stephen.j.battazzo@nasa.gov>, Philippe Gerum <rpm@xenomai.org>, Michael Trimarchi <michael@amarulasolutions.com>, Gianluca Falavigna <gianluca.falavigna@inwind.it>, Wolfgang Grandegger <wg@grandegger.com>

On 05.12.21 21:45, Dario Binacchi wrote:
> Add a minimal test for the virtual CAN driver, checking that sent
> messages are received correctly.
> 
> The timeout on read operations has been wired to 1 s in order not to
> fail the test in case the verbose option is enabled.
> 
> Signed-off-by: Dario Binacchi <dariobin@libero.it>
> ---
> 
> (no changes since v1)

Well... you added it after v1 ;)

Thanks for picking up this task! It immediately showed value:

[  277.753790] RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Team
[  284.000869] BUG: spinlock bad magic on CPU#0, smokey/1552
[  284.000870]  lock: rtcan_recv_list_lock+0x0/0xffffffffffffd5c0 [xeno_can], .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
[  284.000871] CPU: 0 PID: 1552 Comm: smokey Not tainted 5.10.76+ #232
[  284.000871] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[  284.000872] IRQ stage: Linux
[  284.000872] Call Trace:
[  284.000872]  dump_stack+0x84/0x9c
[  284.000872]  do_raw_spin_lock+0x71/0xc0
[  284.000873]  rtcan_socket_init+0xa8/0x110 [xeno_can]
[  284.000873]  rtcan_raw_socket+0x14/0x20 [xeno_can]
[  284.000873]  __rtdm_dev_socket+0xbe/0x220
[  284.000874]  ? CoBaLt_open+0x40/0x40
[  284.000874]  CoBaLt_socket+0xa/0x10
[  284.000874]  handle_root_syscall+0xf1/0x400
[  284.000875]  __pipeline_syscall+0xd3/0x2f0
[  284.000875]  pipeline_syscall+0x6f/0x100
[  284.000875]  syscall_enter_from_user_mode+0x30/0x90
[  284.000876]  do_syscall_64+0xf/0x50
[  284.000876]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  284.000876] RIP: 0033:0x7fdc04b2c08d
[  284.000877] Code: 98 48 89 45 f0 8b 45 c8 48 98 48 89 45 e8 8b 45 cc 48 98 48 89 45 e0 48 8b 55 f0 48 8b 75 e8 48 8b 7d e0 b8 4e 00 00 10 0f 05 <48> 89 45 d8 48 8b 45 d8 89 45 fc 83 7d fc 00 79 33 83 7d fc 9f 74
[  284.000877] RSP: 002b:00007ffc40b58400 EFLAGS: 00000206 ORIG_RAX: 000000001000004e
[  284.000878] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fdc04b2c08d
[  284.000879] RDX: 0000000000000001 RSI: 0000000000000003 RDI: 000000000000001d
[  284.000879] RBP: 00007ffc40b58440 R08: 00007ffc40b5846c R09: 00007ffc40b581ab
[  284.000879] R10: 00007fdc04b189f0 R11: 0000000000000206 R12: 0000000000000000
[  284.000880] R13: 00007ffc40b58690 R14: 0000000000000000 R15: 0000000000000000
[  284.048863] IRQ pipeline: out-of-band stage stalled on IRQ entry

That was wit xeno_can loaded, but without xeno_can_virt.

This should be fixed (I'll also have a look), but your test should also
try to load the required modules, see testsuite/smokey/net_common/
setup.c (maybe you can even reuse smokey_net_modprobe).

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

