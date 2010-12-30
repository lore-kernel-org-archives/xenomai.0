From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTin5BCRNAnsfdaJr54iR=UcJ5svvVi-WT_fLOpXO@mail.gmail.com>
References: <AANLkTin3RZggnBPuFzfWgLiaARBJQE+u0iN-+m=Z80j9@domain.hid>
	<AANLkTin5BCRNAnsfdaJr54iR=UcJ5svvVi-WT_fLOpXO@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 30 Dec 2010 09:26:18 +0100
Message-ID: <1293697578.1837.11.camel@domain.hid>
Mime-Version: 1.0
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

On Wed, 2010-12-29 at 18:47 -0200, Alexandre Oliveira wrote:
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

The complete boot log would help.

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
> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm
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
> 
> 
> Thanks again for the help.
> 
> Att.
> Alexandre.
> 
> 
> 
> 
> 
> 2010/12/29 Alexandre Oliveira <alexandrenagy@domain.hid>
>         Hello Guys,
>         
>         I'm having trouble installing Xenomai for my project
>         
>         I use this tutorial for installing and it matches with the
>         installation at the Xenomai's website.
>         
>         http://www.lara.unb.br/wiki/index.php/Ubuntu_Real-time_Xenomai
>         
>         The new kernel was compiled ok with no problem.
>         
>         ====
>         phall@domain.hid$ uname -a
>         Linux PHall 2.6.34.1-xenomai #3 SMP PREEMPT Mon Dec 27
>         18:22:46 BRST 2010 i686 GNU/Linux
>         phall@domain.hid$ 
>         ====
>         
>         The problem is that when I run xeno-test, it doesn't work. Any
>         of the tests work. All tests return this message and I can't
>         undestard why:
>         
>         ====
>         root@domain.hid# ./run 
>         *
>         *
>         * Type ^C to stop this application.
>         *
>         *
>         Xenomai: /dev/rtheap is missing
>         (chardev, major=10 minor=254)
>         ====
>         
>         I'm sending the answers of xeno-test command.
>         
>         I'm using Orocos for a real time software and the compilation
>         went ok too. The configuration file is down. I could compile
>         all my files but the same error happens:
>         
>         ==============
>         Orocos RTT version  (1.10.4)
>         No orocos-rtt.cmake file loaded, using default settings.See
>         orocos-rtt.default.cmake
>         -- CMAKE_VERSION: 2.6.4
>         Boost found in /usr/include
>         -- Could NOT find Xerces  (missing:  XERCES_DEPDOM_LIBRARY)
>         Orocos target is xenomai
>         -- Found XENOMAI 
>         -- Found PTHREAD 
>         -- Detected gcc4: 4.4.1
>         
>         -- Found Doxygen -- API documentation can be built
>         -- Configuring done
>         -- Generating done
>         ===============
>         
>         ====
>         phall@domain.hid$ ./phall
>         Xenomai: /dev/rtheap is missing
>         (chardev, major=10 minor=254)
>         phall@domain.hid$ 
>         ====
>         
>         Anyone ever passed through this and could help?
>         
>         Att.
>         Alexandre Oliveira.
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



