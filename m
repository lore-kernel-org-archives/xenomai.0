Message-ID: <490B37D6.8050809@domain.hid>
Date: Fri, 31 Oct 2008 17:52:38 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <857546.30206.qm@domain.hid>
	<490B32EF.8050503@domain.hid>
	<327543.30247.qm@domain.hid>
In-Reply-To: <327543.30247.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] floating point (int 16) exception
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gabriele Moabiti <gabmoa@domain.hid>
Cc: xenomai@xenomai.org

Gabriele Moabiti wrote:
> 
>> No, simply doing an fnclex will not do the trick.
>> 
>> If you do not know the details of Xenomai and Linux FPU handling on
>> x86, I advise you to let xenomai handle the fault, it does it
>> without switching to secondary mode, so, you can use it. I do not
>> want to explain you how it works because it is rather hairy, so,
>> the only way to understand, if you really want to, is to read the
>> xenomai and linux relevant sources.
> 
> I need to manage exceptions in a different way of the x86 default so
> I have to unmask fpu exceptions. I have read and follow how it works
> but in xenomai fpu exceptions invoke a switch to linux...
> 
> int xnpod_trap_fault(xnarch_fltinfo_t *fltinfo) { ... if
> (xnpod_shadow_p()) { ... 
> xnshadow_relax(xnarch_fault_notify(fltinfo)); } return 0; }
> 
> so there is not in the source code an example on how to trap
> exception and remain into real time task...

No, you do not read the sources correctly. Xenomai does handle FPU
exception in primary mode. You know, I implemented part of this, so, you
should not assume that I do not know what I am talking about.

int xnpod_trap_fault(xnarch_fltinfo_t *fltinfo)
{
...
#ifdef __KERNEL__
        if (xnarch_fault_fpu_p(fltinfo)) {
#if defined(CONFIG_XENO_OPT_PERVASIVE) && defined(CONFIG_XENO_HW_FPU)
                xnarchtcb_t *tcb = xnthread_archtcb(thread);

                if (xnpod_shadow_p() && !xnarch_fpu_init_p(tcb->user_task)) {
                        /* The faulting task is a shadow using the FPU
for the
                           first time, initialize its FPU. Of course if
Xenomai
is
                           not compiled with support for FPU, such use
of the FP
U
                           is an error. */
                        xnarch_init_fpu(tcb);
			return 1;

So, here the exception was handled in primary mode, and the comments are
rather explicit.

By the way, your mailer is misconfigured and does not trunc lines.

-- 
                                                 Gilles.

