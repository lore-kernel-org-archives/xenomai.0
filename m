Subject: Re: Warning on arm64 boot with debugging on
References: <2349a1e9-d2c6-dc05-eca9-d4015b80746c@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <bb75fe73-b96b-776b-41aa-da152f8f5022@xenomai.org>
Date: Tue, 8 Oct 2019 19:35:00 +0200
MIME-Version: 1.0
In-Reply-To: <2349a1e9-d2c6-dc05-eca9-d4015b80746c@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 10/8/19 5:21 PM, Jan Kiszka wrote:
> Hi Philippe,
> 
> just a note, probably harmless (instrumentation issue), but it may 
> prevent debugging real issues. This is ipipe-core-4.19.55-arm64-2 with 
> lock validation on:
> 
> [    0.542009] CPU1: Booted secondary processor 0x0000000001 [0x411fd070]
> [    0.542338] ------------[ cut here ]------------
> [    0.542900] IRQs not enabled as expected
> [    0.543377] WARNING: CPU: 1 PID: 0 at ../kernel/time/tick-sched.c:982 tick_nohz_idle_enter+0xa0/0xb0
> [    0.543725] Modules linked in:
> [    0.544086] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.55+ #3
> [    0.544325] Hardware name: linux,dummy-virt (DT)
> [    0.544526] I-pipe domain: Linux
> [    0.544799] pstate: 60000005 (nZCv daif -PAN -UAO)
> [    0.545002] pc : tick_nohz_idle_enter+0xa0/0xb0
> [    0.545190] lr : tick_nohz_idle_enter+0xa0/0xb0
> [    0.545373] sp : ffff00000a303f20
> [    0.545526] x29: ffff00000a303f20 x28: 0000000000000000 
> [    0.545807] x27: 0000000000000000 x26: 0000000000000000 
> [    0.546122] x25: 0000000000000000 x24: 0000000000000000 
> [    0.546497] x23: 0000000000000000 x22: ffff0000092df000 
> [    0.546863] x21: 0000000000000001 x20: 0000000000000001 
> [    0.547225] x19: 0000000000000087 x18: ffffffffffffffff 
> [    0.547587] x17: 0000000000001086 x16: 0000000000001086 
> [    0.547948] x15: ffff0000092df808 x14: 0720072007200720 
> [    0.548441] x13: 00000000425b018d x12: 0720072007200720 
> [    0.548826] x11: 0720072007200720 x10: 0000000000000000 
> [    0.549230] x9 : 0000000000000080 x8 : 0000000000000000 
> [    0.549597] x7 : 0000000000000000 x6 : 0000000000000002 
> [    0.549966] x5 : 0000000000000000 x4 : 0000000000000000 
> [    0.550339] x3 : ffff0000092c25e8 x2 : ffff0000092fffc0 
> [    0.550708] x1 : d421eb0c5053da00 x0 : 0000000000000000 
> [    0.551150] Call trace:
> [    0.551348]  tick_nohz_idle_enter+0xa0/0xb0
> [    0.551602]  do_idle+0x38/0x2c8
> [    0.551810]  cpu_startup_entry+0x20/0x28
> [    0.552043]  secondary_start_kernel+0x1bc/0x200
> [    0.552331] irq event stamp: 2
> [    0.552709] hardirqs last  enabled at (1): [<ffff0000080961ac>] secondary_start_kernel+0x1ac/0x200
> [    0.553164] hardirqs last disabled at (2): [<ffff000008c35574>] _raw_spin_lock_irqsave+0x24/0x70
> [    0.553607] softirqs last  enabled at (0): [<ffff0000080e2cb8>] copy_process.isra.6.part.7+0x4c0/0x1ac8
> [    0.554091] softirqs last disabled at (0): [<0000000000000000>]           (null)
> [    0.554533] ---[ end trace 838ab3280ac2c8d6 ]---
> 
> Found while debugging my intret hook. Maybe I can look into that 
> afterwards, but maybe you already have an idea.
> 

I'll have a look.

-- 
Philippe.

