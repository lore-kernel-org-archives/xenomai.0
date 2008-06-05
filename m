Message-ID: <2ff1a98a0806050041v1f1dc987y156907af4fa88c72@domain.hid>
Date: Thu, 5 Jun 2008 09:41:16 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1212614370.21088.23.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1212614370.21088.23.camel@domain.hid>
Subject: Re: [Xenomai-help] Saving floating point registers inside ISR
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henry Bausley <hbausley@domain.hid>
Cc: xenomai@xenomai.org

On Wed, Jun 4, 2008 at 11:19 PM, Henry Bausley <hbausley@domain.hid> wrote:
>
> I am converting a 440EP power pc FSM Labs RT-Linux application to a
> Xenomai 2.4.2 posix application. Previously we saved the floating point
> registers in the ISR.  I had the following code with RTLinux.

Maybe what kills your box is an exception: when a user-space task has
not used the FPU, or when a kernel-space task did not set the XNFPU
bit, any use of floating point instructions triggers an exception. You
should normally get a clear message in the kernel logs. So, you should
try and call rthal_enable_fpu right before rthal_save_fpu. Note
however that when doing so, you break Xenomai and Linux FPU "state
machine". So, what you should really do is save the exception bit,
enable it before calling rthal_save_fpu, then restore it after
rthal_restore_fpu.

You can use for instance
#define rthal_save_fp_bit() ({                           \
    register unsigned long _msr;                        \
    __asm__ __volatile__ ( "mfmsr %0" : "=r"(_msr) );   \
    __asm__ __volatile__ ( "mtmsrd %0"                  \
                           : /* no output */            \
                           : "r"(_msr | MSR_FP)         \
                           : "memory" );                \
    _msr & MSR_FP;
})

#define rthal_restore_fp_bit(msr)  ({ \
    register unsigned long _msr;                        \
    __asm__ __volatile__ ( "mfmsr %0" : "=r"(_msr) );   \
    __asm__ __volatile__ ( "mtmsrd %0"                  \
                           : /* no output */            \
                           : "r"((_msr & ~MSR_FP) | (msr))         \
                           : "memory" );                \
})

Then you would do:

int phase_intr(xnintr_t *cookie)
{
 unsigned long fp_bit;
 rthal_fpenv_t fpustate;

 fp_bit = rthal_save_fp_bit();
 rthal_save_fpu(&fpustate);

 phase();

 rthal_restore_fpu(&fpustate);
 rthal_restore_fp_bit(fp_bit);

 return (XN_ISR_HANDLED);
}

-- 
 Gilles

