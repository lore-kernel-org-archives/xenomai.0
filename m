From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17871.39246.260267.579855@domain.hid>
Date: Sun, 11 Feb 2007 23:31:42 +0100
Subject: Re: [Xenomai-core] [BUG] trunk: screwed Linux irq state
In-Reply-To: <45CF951B.8080404@domain.hid>
References: <45CF951B.8080404@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > Hi,
 > 
 > while testing 2.6.20 with RTnet, I got this kernel BUG during the slave
 > startup procedure:
 > 
 > <4>[  137.799234] TDMA: calibrated master-to-slave packet delay: 34 us (min/max: 33/38 us)
 > <4>[  142.291455] BUG: at kernel/fork.c:993 copy_process()
 > <4>[  142.291585]  [<c0103a8f>] show_trace_log_lvl+0x1f/0x40
 > <4>[  142.291767]  [<c0104237>] show_trace+0x17/0x20
 > <4>[  142.291896]  [<c010432b>] dump_stack+0x1b/0x20
 > <4>[  142.292026]  [<c0111e94>] copy_process+0x914/0x13d0
 > <4>[  142.292190]  [<c0112b80>] do_fork+0x70/0x1b0
 > <4>[  142.292323]  [<c0101078>] sys_clone+0x38/0x40
 > <4>[  142.292620]  [<c010320f>] syscall_call+0x7/0xb
 > <4>[  142.292747]  =======================
 > <3>[  142.292860] BUG: sleeping function called from invalid context at mm/slab.c:3034
 > <4>[  142.293052] in_atomic():0, irqs_disabled():1
 > <4>[  142.293152] no locks held by init/1.
 > <4>[  142.293244] irq event stamp: 500992
 > <4>[  142.293335] hardirqs last  enabled at (500991): [<c010b77c>] __ipipe_handle_exception+0xdc/0x188
 > <4>[  142.293737] hardirqs last disabled at (500992): [<c010306e>] ret_from_exception+0xe/0x20
 > <4>[  142.293967] softirqs last  enabled at (500868): [<c01189ab>] __do_softirq+0xab/0xc0
 > <4>[  142.294189] softirqs last disabled at (500861): [<c0118a55>] do_softirq+0x95/0xa0
 > <4>[  142.294562]  [<c0103a8f>] show_trace_log_lvl+0x1f/0x40
 > <4>[  142.294743]  [<c0104237>] show_trace+0x17/0x20
 > <4>[  142.294897]  [<c010432b>] dump_stack+0x1b/0x20
 > <4>[  142.295050]  [<c010f35d>] __might_sleep+0xcd/0x100
 > <4>[  142.295220]  [<c017d771>] kmem_cache_alloc+0xa1/0xc0
 > <4>[  142.295527]  [<c0110f89>] dup_fd+0x29/0x2d0
 > <4>[  142.295689]  [<c0111279>] copy_files+0x49/0x70
 > <4>[  142.295851]  [<c0111c2f>] copy_process+0x6af/0x13d0
 > <4>[  142.296019]  [<c0112b80>] do_fork+0x70/0x1b0
 > <4>[  142.296178]  [<c0101078>] sys_clone+0x38/0x40
 > <4>[  142.296326]  [<c010320f>] syscall_call+0x7/0xb
 > <4>[  142.296641]  =======================
 > 
 > I'm seeing this with Xenomai trunk + the xnpod_suspend_thread patch. I
 > attached my .config. The interesting thing is that this doesn't show up
 > with v2.3.x head (kernel & config identical). Switching back to 2.6.19
 > doesn't change the picture.
 > 
 > Anyone any idea? No-COW is now both in trunk and 2.3.x, right?

alloc_page_vma in copy_one_pte uses the GFP_HIGHUSER flag, whereas the
bug suggests we are in an atomic section, so maybe we should use 
GFP_ATOMIC | __GFP_HIGHMEM

-- 


					    Gilles Chanteperdrix.

