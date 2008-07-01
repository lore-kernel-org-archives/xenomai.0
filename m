Message-ID: <486A3915.7010506@domain.hid>
Date: Tue, 01 Jul 2008 16:03:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <176721864.20080701150033@domain.hid>
In-Reply-To: <176721864.20080701150033@domain.hid>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai and TSC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Guido Moritz <guido.moritz@domain.hid>
Cc: xenomai@xenomai.org

Guido Moritz wrote:
> Hi.
> 
> I have tried to install Xenomai on a standard PC, but I still have
> some problems I couldn't solve up to now.
> 
> I installed Xenomai in two different Versions with two different
> Linux Kernel versions. I tried Linux 2.6.17.2+Xenomai 2.3.2 and Linux
> 2.6.25.9+Xenomai 2.4.4. In both cases, I couldn't run the xeno-test
> completly, because the "TSC" feature is missing.
> By using Google to solve this problem I found some hints using the
> ./configure --enable-x86-tsc --enable-x86-sep command e.g. But this
> also didn't help. I also didn't found any options for TSC in the
> .config file for the kernel. My CPU flags (see below) show that both,
> SEP and TSC, are available.
> 
> Is this a known problem with this kind of CPU? If anybody has a useful
> hint how to solve this, I would be appreciate.

The problem is that the TSC feature must be enabled in kernel-space if 
you want to enable it in user-space. So, you have two choices:
- either you enable the TSC in kernel-space by selecting the processor 
in kernel configuration which fits your processor (as suggested in 
Xenomai FAQ);
- either you disable usage of TSC in user-space by passing --disable-tsc 
to configure.

> 
> 
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 4
> model name      : AMD Athlon(tm) Processor
> stepping        : 4
> cpu MHz         : 1045.721
> cache size      : 256 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow up
> bogomips        : 2093.70

This means that your processor supports the "rdtsc" instruction, it does 
not mean that the kernel is configured to use it.

-- 
                                                  Gilles.

