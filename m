MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17871.45750.434103.944040@domain.hid>
Date: Mon, 12 Feb 2007 01:20:06 +0100
Subject: Re: [Xenomai-core] [BUG] trunk: screwed Linux irq state
In-Reply-To: <1171237780.5035.30.camel@domain.hid>
References: <45CF951B.8080404@domain.hid> <1171233732.5035.24.camel@domain.hid>
	<17871.41373.425284.839228@domain.hid>
	<1171237780.5035.30.camel@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
 > On Mon, 2007-02-12 at 00:07 +0100, Gilles Chanteperdrix wrote:
 > > Philippe Gerum wrote:
 > >  > On Sun, 2007-02-11 at 23:13 +0100, Jan Kiszka wrote:
 > >  > > Hi,
 > >  > > 
 > >  > > while testing 2.6.20 with RTnet, I got this kernel BUG during the slave
 > >  > > startup procedure:
 > >  > > 
 > >  > > <4>[  137.799234] TDMA: calibrated master-to-slave packet delay: 34 us (min/max: 33/38 us)
 > >  > > <4>[  142.291455] BUG: at kernel/fork.c:993 copy_process()
 > >  > > <4>[  142.291585]  [<c0103a8f>] show_trace_log_lvl+0x1f/0x40
 > >  > > <4>[  142.291767]  [<c0104237>] show_trace+0x17/0x20
 > >  > > <4>[  142.291896]  [<c010432b>] dump_stack+0x1b/0x20
 > >  > > <4>[  142.292026]  [<c0111e94>] copy_process+0x914/0x13d0
 > >  > > <4>[  142.292190]  [<c0112b80>] do_fork+0x70/0x1b0
 > >  > > <4>[  142.292323]  [<c0101078>] sys_clone+0x38/0x40
 > >  > > <4>[  142.292620]  [<c010320f>] syscall_call+0x7/0xb
 > >  > > <4>[  142.292747]  =======================
 > >  > > <3>[  142.292860] BUG: sleeping function called from invalid context at mm/slab.c:3034
 > >  > > <4>[  142.293052] in_atomic():0, irqs_disabled():1
 > >  >                                                  ^^^^
 > >  > 
 > >  > Typical of something going wrong in entry.S.
 > > 
 > > You mean, interrupts are not really disabled when forking ? :-)
 > > 
 > 
 > Eh, mmmh, no. Hopefully.
 > 
 > > So, I am afraid the new fpu_counter optimization is buggy: if a task
 > > forks with fpu_counter greater than 5 and is preempted right after
 > > prepare_to_copy in dup_task_struct, when the system switches back to
 > > this task, the task FPU context will be restored and TS_USEDFPU set in
 > > the task flags, thereby voiding the effect of prepare_to_copy.
 > > 
 > 
 > You mean that the parent FPU context would leak into the child's one?

Yes, something like that. The result is random segfaults, I do not
remember exactly why.

 > Well, maybe the LKML people would like to know about this. As a
 > sidenote, I don't see anything bad with your latest counter-measure
 > disabling this optimization in Xenomai's context switch code, even in
 > the bugous case above. Right? 

Right, if there are random segfaults, they will not be xenomai's fault.

-- 


					    Gilles Chanteperdrix.

