Subject: Re: Bad ioctl in rtnet
References: <1442415265.1178196.1591714159280.JavaMail.zimbra@wolfram.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <a1e62b28-3090-26cd-aa99-5b04e0dace4f@xenomai.org>
Date: Tue, 9 Jun 2020 18:16:36 +0200
MIME-Version: 1.0
In-Reply-To: <1442415265.1178196.1591714159280.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset=utf-8
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
To: Per Oberg <pero@wolfram.com>, xenomai <xenomai@xenomai.org>

On 6/9/20 4:49 PM, Per Oberg via Xenomai wrote:
> Hello list!
> 
> I get this error when running a posix-wrapper-compiled software pacakge on rtnet. Could someone please help me pinpoint which ioctl is causing this? (Does it say in the text below or do I need to start spreading breadcrumbs ? )
> 
> [ 85.577201] I-pipe domain: Linux 
> [ 85.577624] task: ffff880262df6c00 task.stack: ffffc9000138c000 
> [ 85.578058] RIP: 0010:[<ffffffffa02b4787>] [<ffffffffa02b4787>] rt_ip_ioctl+0x27/0x120 [rtipv4] 
> [ 85.578512] RSP: 0018:ffffc9000138fda8 EFLAGS: 00010246 
> [ 85.578958] RAX: 000000000007ffff RBX: 0000000040180021 RCX: ffff88026dd00000 
> [ 85.579409] RDX: 00007ffcb6bd3470 RSI: 0000000040180021 RDI: ffff880262b33a00 
> [ 85.579858] RBP: ffffc9000138fdd0 R08: 0000000000000052 R09: ffff880262df6c00 
> [ 85.580310] R10: 00000000000000e6 R11: 0000000000000000 R12: ffff880262b33a00 
> [ 85.580763] R13: 0000000040180021 R14: 00007ffcb6bd3470 R15: 0000000062b33a00 
> [ 85.581217] FS: 00007fd21c07c480(0000) GS:ffff88026dd00000(0000) knlGS:0000000000000000 
> [ 85.581674] CS: 0010 DS: 0000 ES: 0000 CR0: 000000008005003b 
> [ 85.582133] CR2: 00007ffcb6bd3470 CR3: 0000000261a90000 CR4: 0000000000360630 
> [ 85.582602] Stack: 
> [ 85.583067] ffffffffa02bf6f7 0000000000000001 ffffffff81178cd0 ffff880262b33a00 
> [ 85.583554] 0000000000000004 ffffc9000138fe60 ffffffff811725be 0000000000000202 
> [ 85.584040] ffff880262df6c00 ffff880200000010 ffffc9000138fe70 ffffc9000138fe08 
> [ 85.584531] Call Trace: 
> [ 85.585015] [<ffffffffa02bf6f7>] ? rt_udp_ioctl+0x67/0x8c [rtudp] 
> [ 85.585511] [<ffffffff81178cd0>] ? CoBaLt_fcntl+0x20/0x20 
> [ 85.586002] [<ffffffff811725be>] rtdm_fd_ioctl+0xee/0x280 
> [ 85.586488] [<ffffffff81178cd0>] ? CoBaLt_fcntl+0x20/0x20 
> [ 85.586975] [<ffffffff810a0933>] ? __ipipe_migrate_head+0x73/0xf0 
> [ 85.587466] [<ffffffff81178cd0>] ? CoBaLt_fcntl+0x20/0x20 
> [ 85.587957] [<ffffffff81178cde>] CoBaLt_ioctl+0xe/0x20 
> [ 85.588445] [<ffffffff81188472>] ipipe_syscall_hook+0x112/0x350 
> [ 85.588932] [<ffffffff8110acb8>] __ipipe_notify_syscall+0xc8/0x190 
> [ 85.589421] [<ffffffff8110adaa>] ipipe_handle_syscall+0x2a/0xb0 
> [ 85.589912] [<ffffffff81001c3d>] do_syscall_64+0x2d/0xf0 
> [ 85.590404] [<ffffffff818dffbe>] entry_SYSCALL_64_after_swapgs+0x58/0xc6 
> [ 85.590897] Code: 68 b8 eb b0 e8 ab d4 62 e1 81 fe 27 00 10 40 0f 84 c1 00 00 00 7e 73 81 fe 20 00 18 40 74 3c 81 fe 21 00 18 40 0f 85 a0 00 00 00 <8b> 02 8b 4a 10 4c 8b 
> 42 08 8b 72 04 85 c0 0f 85 d6 00 00 00 83 
> [ 85.592061] RIP [<ffffffffa02b4787>] rt_ip_ioctl+0x27/0x120 [rtipv4] 
> [ 85.592592] RSP <ffffc9000138fda8> 
> [ 85.593120] CR2: 00007ffcb6bd3470

The header of this kernel splat - which should normally give you some hint
about the code which triggers it - seems to be missing from the pasted text
above. Anyway, quick and dirty trick to locate it:

$ $CROSS_COMPILE-objdump -dl
$linux-build-tree/drivers/xenomai/net/stack/ipv4/rtipv4.o | grep -A 30
'<rt_ip_ioctl>:'

00000000000029f0 <rt_ip_ioctl>:
rt_ip_ioctl():
linux/drivers/xenomai/net/stack/ipv4/ip_sock.c:209
    29f0:	41 54                	push   %r12
    29f2:	4c 8d 27             	lea    (%rdi),%r12
    29f5:	55                   	push   %rbp
rtdm_fd_to_private():
linux/include/xenomai/rtdm/driver.h:163
    29f6:	48 8d 2f             	lea    (%rdi),%rbp
rt_ip_ioctl():
linux/drivers/xenomai/net/stack/ipv4/ip_sock.c:209
    29f9:	48 8d 64 24 e0       	lea    -0x20(%rsp),%rsp
rtdm_fd_to_private():
linux/include/xenomai/rtdm/driver.h:163
    29fe:	48 83 c5 58          	add    $0x58,%rbp
rt_ip_ioctl():
linux/drivers/xenomai/net/stack/ipv4/ip_sock.c:209
    2a02:	65 48 8b 04 25 28 00 	mov    %gs:0x28,%rax
    2a09:	00 00
    2a0b:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    2a10:	31 c0                	xor    %eax,%eax
linux/drivers/xenomai/net/stack/ipv4/ip_sock.c:215
    2a12:	81 fe 20 00 18 40    	cmp    $0x40180020,%esi
    2a18:	0f 84 d5 00 00 00    	je     2af3 <rt_ip_ioctl+0x103>
    2a1e:	7f 5f                	jg     2a7f <rt_ip_ioctl+0x8f>
    2a20:	81 fe 26 00 10 40    	cmp    $0x40100026,%esi
    2a26:	0f 84 98 00 00 00    	je     2ac4 <rt_ip_ioctl+0xd4>
    2a2c:	81 fe 27 00 10 40    	cmp    $0x40100027,%esi
    2a32:	0f 85 81 00 00 00    	jne    2ab9 <rt_ip_ioctl+0xc9>
linux/drivers/xenomai/net/stack/ipv4/ip_sock.c:243
    2a38:	b9 10 00 00 00       	mov    $0x10,%ecx

rt_ip_ioctl+0x27 would then be 000029f0 + 0x27, i.e. 00002a17 which would be
somewhere after xenomai/net/stack/ipv4/ip_sock.c:215. This IP does not seem to
match anything sensible in my dump (v3.1), but you may be using a different
Xenomai code base, so this may explain. At any rate, this seems to be one of
the generic sockopt handlers (setopt, getopt, getname, setname). Anyway, you
get the point.

PS: with the static portion of the kernel, you would have used addr2line
directly on the vmlinux image, using the %RIP value as a hint to the command.

-- 
Philippe.

