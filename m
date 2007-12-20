Message-ID: <476A1B97.6060602@domain.hid>
Date: Thu, 20 Dec 2007 08:36:55 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <f8f856500712180507q16d5c21bp56b45ec23ae5d36@domain.hid>
In-Reply-To: <f8f856500712180507q16d5c21bp56b45ec23ae5d36@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Kernel hangs in initramfs with ipipe activated
 (arch=ppc)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: fabien <fabien.fb@domain.hid>
Cc: xenomai@xenomai.org

Hello,

fabien wrote:
> hello,
> 
> I'm new to this list and Xenomai. I've ported a Linux 2.6 kernel on a
> custom board based on MPC855T (PQ1). I'm able to boot my kernel
> 2.6.23-6 (DENX) compiled with eldk 4.1 (uClibC) and run userspace
> applications on flash filesystem without problems (Busybox). The
> booloader is ppcboot 1.1.5. My uart is on SMC1.

The old arch/ppc tree is deprecated and the removal is scheduled for
middle of the next year. Any chance to move to "arch/powerpc"?

> The prepare kernel script patchs correcly the kernel with
> adeos-ipipe-2.6.23-ppc-1.6-00.patch. I'm based on arch=ppc :
> scripts/prepare-kernel.sh
> --linux=/opt/eldk/ppc_8xx/usr/src/linux-2.6-denx/
> --adeos=ksrc/arch/powerpc/patches/adeos-ipipe-2.6.23-ppc-1.6-00.patch
> --arch=ppc
> 
> When i try to boot with Xenomai support my kernel hangs.

Support for MPC8xx boards in Linux 2.6 is still poor and rather
experimental and you are likely the first one trying Xenomai with it. We
still do not have a MPC8xx platform for testing under 2.6.

Wolfgang.

