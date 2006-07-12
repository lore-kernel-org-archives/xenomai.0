From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17588.59605.811336.920818@domain.hid>
Date: Wed, 12 Jul 2006 14:19:33 +0200
Subject: Re: [Xenomai-help] Pentium IV processor with Hyper Threading
In-Reply-To: <e325d110607120507x61180e92q744464ca3bb33a41@domain.hid>
References: <e325d110607120507x61180e92q744464ca3bb33a41@domain.hid>
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

Kim Chuan Lim wrote:
 > Hi all,
 > 
 > Unfortunally my xenomai box only able to detect 1 CPU.
 > :(
 > 
 > cat /proc/cpuinfo
 > processor       : 0
 > vendor_id       : GenuineIntel
 > cpu family      : 15
 > model           : 2
 > model name      : Intel(R) Pentium(R) 4 CPU 3.20GHz
 > stepping        : 9
 > cpu MHz         : 3216.028
 > cache size      : 512 KB
 > physical id     : 0
 > siblings        : 1
 > core id         : 0
 > cpu cores       : 1
 > fdiv_bug        : no
 > hlt_bug         : no
 > f00f_bug        : no
 > coma_bug        : no
 > fpu             : yes
 > fpu_exception   : yes
 > cpuid level     : 2
 > wp              : yes
 > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
 > mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe up
 > cid xtpr
 > bogomips        : 6440.75
 > 
 > Is xenomai currently only work with single processor machine?

hyper-threading is not good for determinism. Anyway, Xenomai
can work with SMP machines. Your problem is related to Linux. You
probably disabled ACPI, which disables detection of hyper-threads. The
only option that should really be disabled is CONFIG_ACPI_PROCESSOR, but
you probably already know about it, since you have read the
TROUBLESHOOTING file, haven't you ?

-- 


					    Gilles Chanteperdrix.

