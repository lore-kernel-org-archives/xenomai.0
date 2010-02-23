From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <e325d111002221813u2c09b82r904c91b95f4b61b7@domain.hid>
References: <e325d111002221813u2c09b82r904c91b95f4b61b7@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 23 Feb 2010 08:38:06 +0100
Message-ID: <1266910686.26785.266.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai: incompatible feature set
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kim Chuan Lim <lim.kim.chuan@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2010-02-22 at 21:13 -0500, Kim Chuan Lim wrote:
> I followed the guide available at
> http://www.captain.at/xenomai-2.1-installation.php for installing
> Xenomai.

> May i know why the feature "tsc" is available in my cpuinfo but it
> said it is missing when i execute the Xenomai example program?
> 
> How should i fix this issue?

You have to ensure that your kernel and your Xenomai userland libs are
feature compatible. The message you get says they are not. To get them
in sync, you should have a kernel .config that provides the set of
features which the configure script assumes to be available from your
target kernel when building user-space application support code.

README.INSTALL is the doc you are looking for. The x86 CPU type you
picked in your kernel configuration is likely wrong. Do _not_ use the
kernel config shipped by your favorite distro blindly, it is most often
unsuitable for running any real-time system (Xenomai or anything else)
on your x86 box.

http://www.xenomai.org/index.php/FAQs#Tips_and_tricks_setting_up_your_x86_kernel

> 
> ./trivial-periodic
> Xenomai: incompatible feature set
> (userland requires "tsc fastsynch", kernel provides "sep fastsynch
> smp", missing="tsc").
> 
> cat /proc/cpuinfo
> processor	: 0
> vendor_id	: GenuineIntel
> cpu family	: 15
> model		: 4
> model name	: Intel(R) Pentium(R) 4 CPU 3.00GHz
> stepping	: 10
> cpu MHz		: 3000.304
> cache size	: 2048 KB
> physical id	: 0
> siblings	: 1
> core id		: 0
> cpu cores	: 1
> apicid		: 0
> initial apicid	: 0
> fdiv_bug	: no
> hlt_bug		: no
> f00f_bug	: no
> coma_bug	: no
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 5
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm
> constant_tsc up pebs bts pni dtes64 monitor ds_cpl est cid cx16 xtpr
> lahf_lm
> bogomips	: 6000.60
> clflush size	: 64
> cache_alignment	: 128
> address sizes	: 36 bits physical, 48 bits virtual
> power management:
> 
> BTW, i have 2 CPUs before installing Xenomai. One of them is missing
> at the moment.
> 

Check your kernel configuration; you likely did something wrong when
adapting your vendor config to your new setup. Xenomai has no impact on
the number of available CPUs.

If you CPU is a Pentium D 64bit, pick CONFIG_MPSC as "Processor family",
in the "Processor type and features" menu.

> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.



