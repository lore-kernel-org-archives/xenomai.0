Message-ID: <507F2D28.4090600@nta-inc.net>
Date: Wed, 17 Oct 2012 17:11:52 -0500
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
References: <507C93B6.30304@nta-inc.net> <507D0712.9070305@xenomai.org>
In-Reply-To: <507D0712.9070305@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Still having problems running Xenomai on an Intel
 X5650 x86_64 machine
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 10/16/2012 02:04 AM, Gilles Chanteperdrix wrote:
> On 10/16/2012 12:52 AM, Jeff Webb wrote:
>
>> I'm back to trying to get Xenomai running on a dual 6-core Intel
>> X5650 desktop machine.  I reported my previous attempts a few months
>> ago:
>>
>> On ubuntu 10.04 with 2.6.38.8:
>> http://www.xenomai.org/pipermail/xenomai/2012-July/000546.html
>>
>> On ubuntu 10.04 with 3.2.21:
>> http://www.xenomai.org/pipermail/xenomai/2012-July/000577.html
>>
>> I am now using ubuntu 12.04 instead of 10.04, and I'm using the
>> xenomai-2.6.git branch.  I am still not having any success.  The
>> kernel boots, but hangs as the GUI login box is coming up.  This is
>> similar to what happened under ubuntu 10.04/3.2.21, but the call
>> trace seems a little different.  I have attached my kernel config and
>> the console output, which was captured via a serial connection.  This
>> exact kernel package seems to run fine (with very limited testing) on
>> a 4-core Intel X9650 desktop machine running the same OS, for what
>> it's worth.  Any help in debugging this would be appreciated.  What's
>> my next step?
>
>
> I am afraid that is another known issue fixed in the 3.4 branch. Please
> try the I-pipe git; git://git.denx.de, branch core-3.4.
>

Thanks again, Gilles.

I just rebuilt the kernel using the core-3.4 branch of ipipe.git with xenomai-2.6.git.  I started with the same kernel config as before and then disabled a few drivers to get everything to compile without errors.  The system still crashes, but now it seems to happen several seconds after the login box has appeared.  The console output is shown below.

Thanks,

-Jeff

[   37.359024] BUG: unable to handle kernel NULL pointer dereference at 0000000000000080
[   37.366845] IP: [<ffffffff810ac055>] __ipipe_dispatch_irq+0x35/0x280
[   37.373178] PGD 33febb067 PUD 3403bb067 PMD 0
[   37.377627] Oops: 0000 [#1] SMP
[   37.380854] CPU 0
[   37.382680] Modules linked in: bnep rfcomm bluetooth dm_crypt snd_hda_codec_analog snd_hda_intel snd_hda_codec snd_hwdep snd_pcm snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timer snd_seq_device coretemp dell_wmi snd soundi
[   37.430766]
[   37.432248] Pid: 0, comm: swapper/0 Not tainted 3.4.6-ipipe-core-3.4.git.2012.10.09-xenomai-2.6.git.2012.10.10 #1 Dell Inc. Precision WorkStation T7500  /06FW8P
[   37.446540] RIP: 0010:[<ffffffff810ac055>]  [<ffffffff810ac055>] __ipipe_dispatch_irq+0x35/0x280
[   37.455286] RSP: 0018:ffffffff81a03de0  EFLAGS: 00010246
[   37.460567] RAX: 0000000000000000 RBX: 0000000000000020 RCX: 0000000000000000
[   37.467660] RDX: 0000000000000000 RSI: 0000000000000020 RDI: 0000000000000001
[   37.474752] RBP: ffffffff81a03e20 R08: 0000000000000000 R09: ffff880349c00118
[   37.481847] R10: 00000000fffefe81 R11: 0140000000000000 R12: 0000000000000000
[   37.488941] R13: ffffffff81a03e48 R14: 0000000000000000 R15: 0000000000000000
[   37.496036] FS:  0000000000000000(0000) GS:ffff88034a600000(0000) knlGS:0000000000000000
[   37.504079] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[   37.509790] CR2: 0000000000000080 CR3: 000000032e606000 CR4: 00000000000007f0
[   37.516885] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   37.523980] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[   37.531072] Process swapper/0 (pid: 0, threadinfo ffffffff81a00000, task ffffffff81a15020)
[   37.539289] Stack:
[   37.541286]  ffffffff815f29da ffffffff81d97f80 ffffffff8105734c 0000000000051590
[   37.548682]  000000000000dc40 ffffffff81a03e48 ffff880357fb14c0 0000000000000000
[   37.556074]  ffffffff81a03e50 ffffffff8101ed86 ffffffff81056fbb ffffffff81a03fd8
[   37.563469] Call Trace:
[   37.565902]  [<ffffffff815f29da>] ? _raw_spin_unlock_irqrestore+0x2a/0x30
[   37.572656]  [<ffffffff8105734c>] ? __hrtimer_start_range_ns+0x18c/0x410
[   37.579320]  [<ffffffff8101ed86>] __ipipe_handle_irq+0x66/0x190
[   37.585206]  [<ffffffff81056fbb>] ? lock_hrtimer_base.isra.32+0x2b/0x60
[   37.591785]  [<ffffffff815f3e9a>] irq_move_cleanup_interrupt+0x5a/0x90
[   37.598279]  [<ffffffff8101e5b5>] ? __ipipe_halt_root+0x25/0x40
[   37.604167]  [<ffffffff810a826a>] ? rcu_idle_enter+0xaa/0xf0
[   37.609794]  [<ffffffff8100adc7>] default_idle+0x27/0x40
[   37.615075]  [<ffffffff8100b830>] cpu_idle+0xc0/0x120
[   37.620100]  [<ffffffff815c74c9>] rest_init+0x6d/0x74
[   37.625124]  [<ffffffff81aecc4b>] start_kernel+0x3f4/0x401
[   37.630578]  [<ffffffff81aec657>] ? repair_env_string+0x5a/0x5a
[   37.636464]  [<ffffffff81aec321>] x86_64_start_reservations+0x131/0x135
[   37.643041]  [<ffffffff81aec45a>] x86_64_start_kernel+0x135/0x13c
[   37.649097] Code: ff 40 00 00 48 89 5d d8 4c 89 65 e0 89 fb 4c 89 6d e8 4c 89 75 f0 41 89 f4 4c 89 7d f8 0f 87 25 02 00 00 45 31 f6 e8 cb 4b ff ff <48> 81 b8 80 00 00 00 c0 3c 0a 81 41 0f 94 c6 41 f6 c4 01 41 89
[   37.668550] RIP  [<ffffffff810ac055>] __ipipe_dispatch_irq+0x35/0x280
[   37.674963]  RSP <ffffffff81a03de0>
[   37.678430] CR2: 0000000000000080
[   37.711851] ---[ end trace 806a5eca9b4b2cb5 ]---
[   37.716438] Kernel panic - not syncing: Attempted to kill the idle task!
[   37.724693] panic occurred, switching back to text console


