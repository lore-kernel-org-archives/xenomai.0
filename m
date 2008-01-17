Message-ID: <2ff1a98a0801170520s53e3a63ey1d3eb5492c36003e@domain.hid>
Date: Thu, 17 Jan 2008 14:20:02 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <d3f72a390801170429r60f3b445jf4ed366780727515@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <mailman.1450.1200567103.28415.xenomai@xenomai.org>
	<d3f72a390801170429r60f3b445jf4ed366780727515@domain.hid>
Subject: Re: [Xenomai-core] ARM FLOATING POINT
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: axel axel <softaxel@domain.hid>
Cc: xenomai@xenomai.org

On Jan 17, 2008 1:29 PM, axel axel <softaxel@domain.hid> wrote:
> Hi,
>
> is it possible to support the FPU on arm ? I'm porting ipipe on ep9315 and i
> don't find the information on how to modify IPIPE for supporting FPU.
>
> Thanks for all.

It depends if you want to support FPU in kernel-space or not. If you
simply want to support FPU in user-space, you have to modify
rthal_thread_switch in ksrc/arch/arm/switch.S to add support for
cirrus logic FPU (rthal_thread_switch was copied from Linux 2.6.14
context switch at a time when cirrus logic processors were not yet
supported by mainline). I modified rthal_thread_switch recently and
hesitated to put the FPU switch in a separated C file, since in recent
kernels, FPU switch is done in C. So, if you ask, I could do that.

If you want to support FPU in kernel-space, you will have to implement
the various functions needed by Xenomai nucleus (xnarch_fpu_init_p,
xnarch_init_fpu, xnarch_save_fpu, xnarch_restore_fpu), and implement
include/asm-arm/fptest.h to allow switchtest to validate your
implementation.

-- 
                                               Gilles Chanteperdrix

