Message-ID: <4A49D935.3060900@domain.hid>
Date: Tue, 30 Jun 2009 11:21:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4A48FB71.6070506@domain.hid> <4A49CD81.4060706@domain.hid>	
	<4A49CFF0.7070202@domain.hid> <1246353623.7803.21.camel@domain.hid>
In-Reply-To: <1246353623.7803.21.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] x86: Endless minor faults
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> On Tue, 2009-06-30 at 10:42 +0200, Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Jan Kiszka wrote:
>>>> Hi all,
>>>>
>>>> seen such loops before? This particular trace is from a 2.6.29.3 kernel
>>>> with ipipe-2.3-01 (SMP/PREEMPT_VOLUNTARY), but the same happens with
>>>> 2.6.29.5/2.3-03:
>>>>
>>>> :|   +func                -653    0.084  __ipipe_handle_exception+0x11 (page_fault+0x26)
>>>> :|   +func                -653    0.096  ipipe_check_context+0xd (__ipipe_handle_exception+0x71)
>>>> :|   #end     0x80000000  -653    0.069  do_page_fault+0x33 (__ipipe_handle_exception+0x1ff)
>>>> :    #func                -653    0.078  __ipipe_unstall_root+0x9 (do_page_fault+0x3cb)
>>>> :|   #begin   0x80000000  -653    0.068  __ipipe_unstall_root+0x34 (do_page_fault+0x3cb)
>>>> :|   +end     0x80000000  -653    0.069  __ipipe_unstall_root+0x59 (do_page_fault+0x3cb)
>>>> :    +func                -653    0.060  down_read_trylock+0x4 (do_page_fault+0x424)
>>>> :    +func                -653    0.068  _spin_lock_irqsave+0x9 (__down_read_trylock+0x16)
>>>> :    +func                -653    0.108  ipipe_check_context+0xd (_spin_lock_irqsave+0x1d)
>>>> :    #func                -652    0.066  _spin_unlock_irqrestore+0x4 (__down_read_trylock+0x3f)
>>>> :    #func                -652    0.069  __ipipe_restore_root+0x4 (_spin_unlock_irqrestore+0x21)
>>>> :    #func                -652    0.074  __ipipe_unstall_root+0x9 (__ipipe_restore_root+0x2c)
>>>> :|   #begin   0x80000000  -652    0.066  __ipipe_unstall_root+0x34 (__ipipe_restore_root+0x2c)
>>>> :|   +end     0x80000000  -652    0.069  __ipipe_unstall_root+0x59 (__ipipe_restore_root+0x2c)
>>>> :    +func                -652    0.096  find_vma+0x4 (do_page_fault+0x465)
>>>> :    +func                -652    0.150  ltt_run_filter_default+0x4 (_ltt_specialized_trace+0xc1)
>>>> :    +func                -652    0.098  handle_mm_fault+0x11 (do_page_fault+0x537)
>>>> :    +func                -652    0.090  _spin_lock+0x4 (handle_mm_fault+0x680)
>>>> :    +func                -652    0.063  ptep_set_access_flags+0x9 (handle_mm_fault+0x6d1)
>>>> :    +func                -652    0.282  flush_tlb_page+0xd (handle_mm_fault+0x6e7)
>>>> :    +func                -651    0.162  ltt_run_filter_default+0x4 (_ltt_specialized_trace+0xc1)
>>>> :    +func                -651    0.062  up_read+0x4 (do_page_fault+0x5a9)
>>>> :    +func                -651    0.072  _spin_lock_irqsave+0x9 (__up_read+0x1c)
>>>> :    +func                -651    0.117  ipipe_check_context+0xd (_spin_lock_irqsave+0x1d)
>>>> :    #func                -651    0.074  _spin_unlock_irqrestore+0x4 (__up_read+0x92)
>>>> :    #func                -651    0.069  __ipipe_restore_root+0x4 (_spin_unlock_irqrestore+0x21)
>>>> :    #func                -651    0.060  __ipipe_unstall_root+0x9 (__ipipe_restore_root+0x2c)
>>>> :|   #begin   0x80000000  -651    0.056  __ipipe_unstall_root+0x34 (__ipipe_restore_root+0x2c)
>>>> :|   +end     0x80000000  -651    0.420  __ipipe_unstall_root+0x59 (__ipipe_restore_root+0x2c)
>>>> :|   +func                -650    0.084  __ipipe_handle_exception+0x11 (page_fault+0x26)
>>>>
>>>> and again and again...
>>>>
>>>> We are looping over a minor fault here (according to /proc/PID/stat),
>>>> the context is a Xenomai task in secondary mode. As the task no longer
>>>> processes signals in this state, the whole system is more or less
>>>> broken. Tomorrow I will try to find out the faulting address with an
>>>> instrumented kernel, but maybe you already have some ideas.
>>> The fault is apparently triggered by __xn_put_user(XNRELAX,
>>> thread->u_mode) in xnshadow_relax. thread->u_mode is pointing to an
>>> invalid region ATM. The questions are now: Who corrupted this, user
>>> space on init (not that likely) or kernel space later on (unpleasant
>>> thought)? Moreover: Why can't we recover from a fault on u_mode?
>> I already investigated such an issue, and my conclusion was that there
>> are some places in the code where we can not cope with a fault.
>> xnshadow_relax being such a place, because, if relax faults, then what
>> will the fault handler do? Call relax again. Fortunately, mlockall and
>> the nocow stuff fixes this.
> 
> 
> xnshadow_relax() faulting before the current thread bears the XNRELAX
> bit would mean that a creepy issue involving ondemand PTEs in _kernel_
> space must have caused this. Having the init_mm mappings known from all
> processes seems more relevant to this issue than anything nocow and/or
> mlockall could ever do to fix it.

u_mode is a user-space address.

-- 
                                          Gilles


