Message-ID: <4D1F4BA4.6090000@domain.hid>
Date: Sat, 01 Jan 2011 16:43:32 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTin3RZggnBPuFzfWgLiaARBJQE+u0iN-+m=Z80j9@domain.hid>
	<AANLkTin5BCRNAnsfdaJr54iR=UcJ5svvVi-WT_fLOpXO@mail.gmail.com>
In-Reply-To: <AANLkTin5BCRNAnsfdaJr54iR=UcJ5svvVi-WT_fLOpXO@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problems with Installation. Error message in
 xeno-test: "Xenomai: /dev/rtheap is missing".
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alexandre Oliveira <alexandrenagy@domain.hid>
Cc: xenomai@xenomai.org

Alexandre Oliveira wrote:
> I think I discovered the problem at boot log.
> 
> 
> ====
> [    2.456000] Xenomai has detected a CPU frequency of 0. Aborting.
> [    2.456000] Xenomai: system init failed, code -19.
> [    2.456000] Xenomai: native skin init failed, code -19.
> [    2.456000] Xenomai: starting POSIX services.
> [    2.456000] Xenomai: POSIX skin init failed, code -19.
> [    2.456000] Xenomai: RTDM skin init failed, code -19.
> ===
> 
> My cpuinfo:
> 
> ===
> phall@domain.hid:~$ cat /proc/cpuinfo
> processor    : 0
> vendor_id    : GenuineIntel
> cpu family    : 15
> model        : 4
> model name    : Intel(R) Pentium(R) 4 CPU 3.00GHz
> stepping    : 3
> cpu MHz        : 0.000
> cache size    : 2048 KB
> fdiv_bug    : no
> hlt_bug        : no
> f00f_bug    : no
> coma_bug    : no
> fpu        : yes
> fpu_exception    : yes
> cpuid level    : 5
> wp        : yes
> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm
> constant_tsc up pebs bts pni dtes64 monitor ds_cpl est cid cx16 xtpr
> bogomips    : 1495.04
> clflush size    : 64
> cache_alignment    : 128
> address sizes    : 36 bits physical, 48 bits virtual
> power management:
> ====
> 
> I really don't know how to make this work. Is there anything to do for
> correctthe correction of the CPU frequency?
> 
> The same problem is discussed here, but I couldn't see the solution.
> 
> http://comments.gmane.org/gmane.linux.real-time.xenomai.devel/6632

The thread you are referring to describes the issue as happening inside
some emulator (virtualbox), and clearly shows that the a solution was
implemented (Xenomai refuses to start if the reported frequency is 0,
instead of crashing with a division by 0).

If you have this issue when running inside an emulator, then the
emulator needs fixing, if you do not run inside an emulator, then the
issue is a different one, and the thread you refer to is irrelevant.

-- 
                                                                Gilles.

