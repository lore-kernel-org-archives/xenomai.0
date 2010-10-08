Message-ID: <4CAF993E.3080003@domain.hid>
Date: Sat, 09 Oct 2010 00:20:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=6tAnApCNw9hzQUEYR7BcsgDSU3YA5N+xn-uN2@domain.hid>
In-Reply-To: <AANLkTi=6tAnApCNw9hzQUEYR7BcsgDSU3YA5N+xn-uN2@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] latency spike when starting opengl windows
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Pastor <peter.pastor@domain.hid>
Cc: xenomai@xenomai.org

Peter Pastor wrote:
> Hey there,
> 
> I noticed a spike in the latency over around 600-800microseconds when
> starting an opengl window.
> 
> I have the SMI workaround enabled and also included my device id in the
> 
> /usr/src/xenomai/ksrc/arch/x86/smi.c
> 
> file
> 
> lspci -vvv -nn shows a
> 
> Intel Corporation 82801JIR (ICH10R) LPC Interface Controller [8086:3a16]
> 
> so I added
> 
> {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH10_1)},

You are using an outdated version of Xenomai, because the two last
releases contained this ID.

> 
> After recompiling the kernel I finally saw
> 
> [    2.443949] Xenomai: SMI-enabled chipset found
> 
> ( I did not see that line before )
> but unfortunately I also saw
> 
> [    2.443957] Xenomai: SMI workaround failed!
> 
> Well, the latency test still showed spikes of about 600-800microsends when
> for example starting or closing glxgears. I am using a nvidia FxQuadro FX
> 4800 and I am using the latest nvidia driver which I downloaded from the
> nvidia homepage (256.53).
> 
> I am running
> Linux xeno_machine 2.6.31.4-ipipe #1 SMP Thu Oct 7 18:13:54 PDT 2010 x86_64
> GNU/Linux
> and Xenomai version is 2.5.2

Needless to say, you need to recompile the nvidia drivers for the
Adeos-patched kernel. Your problem may not be SMIs, but an issue with
the X server you are using.

Just looking at the nvidia driver code, I see nothing wrong (namely,
they use local_irq_save and spin_lock_irqsave, so, they will use the
Adeos versions of these services), though when I see:

#define NV_MAX_ISR_DELAY_US           20000


RM_STATUS NV_API_CALL os_delay_us(NvU32 MicroSeconds)
{
    unsigned long mdelay_safe_msec;
    unsigned long usec;

#ifdef NV_CHECK_DELAY_ACCURACY
    struct timeval tm1, tm2;

    do_gettimeofday(&tm1);
#endif

    if (in_irq() && (MicroSeconds > NV_MAX_ISR_DELAY_US))
        return RM_ERROR;


I understand that these people do not care for latencies lower than
20ms. The Adeos patch will allow Xenomai to preempt this driver code,
but if the opengl libraries does the same thing in user-space there is
nothing we can do. The only thing we can tell you to do is to follow the
advice in the TROUBLESHOOTING guide.

-- 
                                                                Gilles.

