Message-ID: <4FC5E768.5010302@xenomai.org>
Date: Wed, 30 May 2012 11:24:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <35191140.199124743.1338368888649.JavaMail.root@spooler3-g27.priv.proxad.net>
In-Reply-To: <35191140.199124743.1338368888649.JavaMail.root@spooler3-g27.priv.proxad.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Feature synchronisation with FASTSYNCH on TS-7553
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: aubin.rebillat@free.fr
Cc: xenomai@xenomai.org

On 05/30/2012 11:08 AM, aubin.rebillat@free.fr wrote:
> Hello,
> 
> I made a Xenomai 2.6 port on the TS-7553 SBC based on the cns2132/str8132 
> SoC (armv4 CPU) with a kernel 2.6.24. I wanted to test the port using the 
> Xenomai tests binaries (switchtest, clocktest, latency,...) but I'm having 
> configuration issues in the feature synchronisation between user-space 
> and kernel-space:        
> $ /usr/xenomai/bin/switchtest
> Xenomai : incompatible feature set
> (userland requires "fastsynch nosmp", kernel provides "sa1100 eabi tsc 
> nofastsynch", missing="fastsynch").
> 
> I compiled the kernel and user-space following exactly the procedure for 
> ARM in the README.INSTALL.
> In the kernel configuration for the CPU (arch/arm/mm/Kconfig), CPU_32v4 is 
> selected which disables XENO_FASTSYNCH_DEP. 
> Therefore the kernel configuration has correct features but in the log of 
> the user-space configure script CONFIG_XENO_FASTSYNCH_TRUE is set.
> 
> I understood that the user-space configuration is based on the kernel 
> .config but in my case the .config does not contain any line with 
> CONFIG_XENO_FASTSYNCH (not even a commented one), it contains only
> CONFIG_CPU_32v4 set to y.
> 
> Does anybody have an idea about what i missed ?

You are probably the first person to have ever tried Xenomai on processors
with CPU_32v4, only CPU_32v4T was tested. What you are missing is probably 
simply this patch:

diff --git a/ksrc/arch/arm/Kconfig b/ksrc/arch/arm/Kconfig
index 25ee469..f529210 100644
--- a/ksrc/arch/arm/Kconfig
+++ b/ksrc/arch/arm/Kconfig
@@ -4,7 +4,7 @@ config XENO_GENERIC_STACKPOOL
 
 config XENO_FASTSYNCH_DEP
        bool
-       default y if (CPU_32v3 || CPU_32v4T || CPU_32v5) && !SMP || CPU_32v6 || CPU_32v7
+       default y if (CPU_32v3 || CPU_32v4 || CPU_32v4T || CPU_32v5) && !SMP || CPU_32v6 || CPU_32v7
 
 config XENO_FASTSYNCH
        bool


> By the way, what is this FASTSYNCH feature and what does it provide ?

fast user-space mutexes (and condvars if using xenomai-forge).

-- 
					    Gilles.

