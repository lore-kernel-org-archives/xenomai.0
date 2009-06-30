Message-ID: <4A49CD81.4060706@domain.hid>
Date: Tue, 30 Jun 2009 10:32:01 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4A48FB71.6070506@domain.hid>
In-Reply-To: <4A48FB71.6070506@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
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
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi all,
> 
> seen such loops before? This particular trace is from a 2.6.29.3 kernel
> with ipipe-2.3-01 (SMP/PREEMPT_VOLUNTARY), but the same happens with
> 2.6.29.5/2.3-03:
> 
> :|   +func                -653    0.084  __ipipe_handle_exception+0x11 (page_fault+0x26)
> :|   +func                -653    0.096  ipipe_check_context+0xd (__ipipe_handle_exception+0x71)
> :|   #end     0x80000000  -653    0.069  do_page_fault+0x33 (__ipipe_handle_exception+0x1ff)
> :    #func                -653    0.078  __ipipe_unstall_root+0x9 (do_page_fault+0x3cb)
> :|   #begin   0x80000000  -653    0.068  __ipipe_unstall_root+0x34 (do_page_fault+0x3cb)
> :|   +end     0x80000000  -653    0.069  __ipipe_unstall_root+0x59 (do_page_fault+0x3cb)
> :    +func                -653    0.060  down_read_trylock+0x4 (do_page_fault+0x424)
> :    +func                -653    0.068  _spin_lock_irqsave+0x9 (__down_read_trylock+0x16)
> :    +func                -653    0.108  ipipe_check_context+0xd (_spin_lock_irqsave+0x1d)
> :    #func                -652    0.066  _spin_unlock_irqrestore+0x4 (__down_read_trylock+0x3f)
> :    #func                -652    0.069  __ipipe_restore_root+0x4 (_spin_unlock_irqrestore+0x21)
> :    #func                -652    0.074  __ipipe_unstall_root+0x9 (__ipipe_restore_root+0x2c)
> :|   #begin   0x80000000  -652    0.066  __ipipe_unstall_root+0x34 (__ipipe_restore_root+0x2c)
> :|   +end     0x80000000  -652    0.069  __ipipe_unstall_root+0x59 (__ipipe_restore_root+0x2c)
> :    +func                -652    0.096  find_vma+0x4 (do_page_fault+0x465)
> :    +func                -652    0.150  ltt_run_filter_default+0x4 (_ltt_specialized_trace+0xc1)
> :    +func                -652    0.098  handle_mm_fault+0x11 (do_page_fault+0x537)
> :    +func                -652    0.090  _spin_lock+0x4 (handle_mm_fault+0x680)
> :    +func                -652    0.063  ptep_set_access_flags+0x9 (handle_mm_fault+0x6d1)
> :    +func                -652    0.282  flush_tlb_page+0xd (handle_mm_fault+0x6e7)
> :    +func                -651    0.162  ltt_run_filter_default+0x4 (_ltt_specialized_trace+0xc1)
> :    +func                -651    0.062  up_read+0x4 (do_page_fault+0x5a9)
> :    +func                -651    0.072  _spin_lock_irqsave+0x9 (__up_read+0x1c)
> :    +func                -651    0.117  ipipe_check_context+0xd (_spin_lock_irqsave+0x1d)
> :    #func                -651    0.074  _spin_unlock_irqrestore+0x4 (__up_read+0x92)
> :    #func                -651    0.069  __ipipe_restore_root+0x4 (_spin_unlock_irqrestore+0x21)
> :    #func                -651    0.060  __ipipe_unstall_root+0x9 (__ipipe_restore_root+0x2c)
> :|   #begin   0x80000000  -651    0.056  __ipipe_unstall_root+0x34 (__ipipe_restore_root+0x2c)
> :|   +end     0x80000000  -651    0.420  __ipipe_unstall_root+0x59 (__ipipe_restore_root+0x2c)
> :|   +func                -650    0.084  __ipipe_handle_exception+0x11 (page_fault+0x26)
> 
> and again and again...
> 
> We are looping over a minor fault here (according to /proc/PID/stat),
> the context is a Xenomai task in secondary mode. As the task no longer
> processes signals in this state, the whole system is more or less
> broken. Tomorrow I will try to find out the faulting address with an
> instrumented kernel, but maybe you already have some ideas.

The fault is apparently triggered by __xn_put_user(XNRELAX,
thread->u_mode) in xnshadow_relax. thread->u_mode is pointing to an
invalid region ATM. The questions are now: Who corrupted this, user
space on init (not that likely) or kernel space later on (unpleasant
thought)? Moreover: Why can't we recover from a fault on u_mode?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

