References: <DM5PR11MB18525F69E34389DE7A8EE49BF2409@DM5PR11MB1852.namprd11.prod.outlook.com>
 <87mtti3325.fsf@xenomai.org> <87k0om32jb.fsf@xenomai.org>
 <DM5PR11MB1852E0C420E68BFB8CAFEE21F25F9@DM5PR11MB1852.namprd11.prod.outlook.com>
 <DM5PR11MB1852D3221BDFC752C9CC1946F25E9@DM5PR11MB1852.namprd11.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: gdb  test failure debug status update
In-reply-to: <DM5PR11MB1852D3221BDFC752C9CC1946F25E9@DM5PR11MB1852.namprd11.prod.outlook.com>
Date: Fri, 30 Apr 2021 09:34:33 +0200
Message-ID: <87bl9w2pkm.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


Chen, Hongzhan <hongzhan.chen@intel.com> writes:

> The final xnthread_relaxed call path is like this asm_sysv_apic_timer_interrupt ->handle_irq_pipelined_finish 
> ->dovetail_call_mayday ->handle_oob_mayday>xnthread_relax. 
> That means that handle_irq_pipelined_finish is called under OOB condition of arch_pipeline_entry in
>  arch/x86/kernel/irq_pipeline.c.  Does that means that kernel entry/exit code is never called after return from 
> xnthread_relax to handle_irq_pipelined_finish then to asm_sysv_apic_timer_interrupt?  Even I enforce to 
> call  dovetail_request_ucall before calling final xnthread_relax system would not try to switch back to primary mode
> because kernel exit code is never called in this case?
>

The IRQ frame is indeed kept from unwinding until the preempted task
context returns from irq_exit_pipeline(), which branches to the Cobalt
rescheduling procedure. From the Dovetail interface POV,
irq_exit_pipeline() is called by handle_irq_pipelined_finish() to allow
the companion core to perform post-IRQ chores, such as running its own
rescheduling procedure.

IOW, if task @foo is preempted by an IRQ, then suspended in oob context
as a result of what the interrupt handler just did for it (e.g. raising
XNDBGSTOP, XNRELAX, XNPEND, XNSUSP in its state), then
handle_irq_pipelined_finish()->irq_exit_pipeline()->xnsched_run() will
cause the @foo context to switch away, effectively preventing
handle_irq_pipelined_finish() to return, until @foo resumes execution
eventually.

The underlying issue I'd like to understand, is why do we have a mayday
condition raised in the context of this test in the first place? That
may be the root of the issue, the mayday and synchronous-bp handling
code may not cope that well.

So, question to address first: who ends up calling
dovetail_call_mayday(), detecting that the underlying task went south?
And why that?

-- 
Philippe.

