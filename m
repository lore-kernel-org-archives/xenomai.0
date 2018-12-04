Subject: Re: RTnet splash with current next and stable
References: <473fdfe5-e761-e51c-a54c-90a520ca7816@siemens.com>
 <a8292038-34ff-fcb5-0def-c764fd4e0b94@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <086d41ad-b4a7-b3f2-945b-96c9f6eeecfb@siemens.com>
Date: Tue, 4 Dec 2018 18:00:03 +0100
MIME-Version: 1.0
In-Reply-To: <a8292038-34ff-fcb5-0def-c764fd4e0b94@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>, Sebastian Smolorz <Sebastian.Smolorz@gmx.de>

On 31.10.18 18:10, Philippe Gerum wrote:
> On 10/30/18 11:28 AM, Jan Kiszka wrote:
>> Hi all,
>>
>> just testing new kernels with smokey, and one of them had RTnet on. This
>> triggered a bug with the net_packat_dgram test:
>>
>> [   50.610997] initializing loopback...
>> [   50.613799] RTnet: registered rtlo
>> [   50.692154] ------------[ cut here ]------------
>> [   50.693577] WARNING: CPU: 1 PID: 1119 at ../lib/list_debug.c:29 __list_add+0x62/0xb0
>> [   50.696832] list_add corruption. next->prev should be prev (ffffffffa0007d20), but was           (null). (next=ffff88003a8bb700).
>> [   50.700751] Modules linked in: rtpacket rtipv4 rt_loopback rt_e1000e rtnet
>> [   50.702518] CPU: 1 PID: 1119 Comm: smokey Not tainted 4.9.135+ #26
>> [   50.704188] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
>> [   50.707861] I-pipe domain: Linux
>> [   50.709295]  ffffc90002943c10 ffffffff8146a31a ffffc90002943c60 0000000000000000
>> [   50.710335]  ffffc90002943c50 ffffffff810e9441 0000001da0007ca8 ffff88003a8bb700
>> [   50.710335]  ffffffffa0007d20 ffff88003a8bb700 000000000001d230 ffff88003a8bb640
>> [   50.710335] Call Trace:
>> [   50.710335]  [<ffffffff8146a31a>] dump_stack+0xa2/0xc8
>> [   50.710335]  [<ffffffff810e9441>] __warn+0xe1/0x100
>> [   50.710335]  [<ffffffff810e94af>] warn_slowpath_fmt+0x4f/0x60
>> [   50.710335]  [<ffffffff812b0b61>] ? __slab_alloc.isra.88+0xa1/0xd0
>> [   50.710335]  [<ffffffffa0003edb>] ? rtskb_pool_extend+0xbb/0x220 [rtnet]
>> [   50.710335]  [<ffffffff81498862>] __list_add+0x62/0xb0
>> [   50.710335]  [<ffffffffa000160a>] rtdev_map_rtskb+0x7a/0xa0 [rtnet]
>> [   50.710335]  [<ffffffffa0003f12>] rtskb_pool_extend+0xf2/0x220 [rtnet]
>> [   50.710335]  [<ffffffffa0004072>] rtskb_pool_init+0x32/0x70 [rtnet]
>> [   50.710335]  [<ffffffffa00043d2>] __rt_bare_socket_init+0x42/0x90 [rtnet]
>> [   50.710335]  [<ffffffffa0004501>] __rt_socket_init+0x81/0xd0 [rtnet]
>> [   50.710335]  [<ffffffffa0054477>] rt_packet_socket+0x27/0xb0 [rtpacket]
>> [   50.710335]  [<ffffffff81219dd7>] ? create_instance+0x67/0x80
>> [   50.710335]  [<ffffffff8121a772>] __rtdm_dev_socket+0x112/0x440
>> [   50.710335]  [<ffffffff8113bb09>] ? lock_release+0x2c9/0x440
>> [   50.710335]  [<ffffffff8122b200>] ? CoBaLt_open+0x40/0x40
>> [   50.710335]  [<ffffffff8122b20e>] CoBaLt_socket+0xe/0x20
>> [   50.710335]  [<ffffffff812412ca>] ipipe_syscall_hook+0x19a/0x460
>> [   50.710335]  [<ffffffff811ad8e9>] __ipipe_notify_syscall+0x79/0x400
>> [   50.710335]  [<ffffffff811adc9a>] ipipe_handle_syscall+0x2a/0xd0
>> [   50.710335]  [<ffffffff81002d6c>] do_syscall_64+0x3c/0x1c0
>> [   50.710335]  [<ffffffff8184f2c3>] entry_SYSCALL_64_after_swapgs+0x5d/0xdb
>> [   50.761499] ---[ end trace 633f1ec8aecb0735 ]---
>> [   50.762893] ------------[ cut here ]------------
>>
>> Anyone who hacked on this recently have a feeling?
>>
> 
> No idea. I'll have a look.
> 
> 

I think this one is still open. At least I do not remember having merged 
anything related to that since then.

As everyone is busy right now, I only wonder if we have a regression here, or if 
it's just a preexisting issue that we can safely ignore for some v3.0.8.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

