Message-ID: <444CF176.8030902@domain.hid>
Date: Mon, 24 Apr 2006 17:40:38 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Error while running test suit (required="sep tsc", 
	present="sep", missing="tsc").
References: <3e9157940604240829u22307f54v2108ff8744c4ebeb@domain.hid>
In-Reply-To: <3e9157940604240829u22307f54v2108ff8744c4ebeb@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Deepak Joglekar <joglekar.deepak@domain.hid>
Cc: xenomai@xenomai.org

Deepak Joglekar wrote:
> Hi,
> 
> I am using kernel 2.6.15.7 <http://2.6.15.7/> and Xenomai 2.1
> 
> While writing this mail I noticed the probable reason.
> parameter
> #define CONFIG_X86_TSC 1 should be
> #define CONFIG_XENO_X86_TSC 1
> 
> I changed this in src/include/xeno_config.h
> 
> After recompile testsuit worked.
> 
> I changed the same in
> src/include/xeno_config.h.in
> 
> original line
> #undef CONFIG_X86_TSC
> changed to.
> #undef CONFIG_XENO_X86_TSC
> 
> Then normal ./configure ... make etc.
> 
> It worked.
> 

By luck since you only circumvented the proper checks, unfortunately. 
The variables as defined in the configure script are perfectly ok, 
CONFIG_X86_TSC is the right option to set.

The message you got initially told you that a discrepancy between the 
CPU selected at kernel level and the user-support has been detected. To 
fix this, you need to select a x86 CPU supporting a timestamp counter 
when configuring your kernel, since by default, the configure script 
assumes --enable-x86-tsc.

In any case, keep in mind that updating the configure script output 
(xeno_config.h) by hand is always the wrong way to fix an issue.

> Thanks,
> 
> Deepak Joglekar
> 
> ------------------------------
> --------------------------
> 
> I get following error while running test suit.
> 
> 
> Xenomai: incompatible feature set
> (required="sep tsc", present="sep", missing="tsc").
> 
> I configured the xenomai with
> ./configure --enable-x86-tsc --enable-x86-sep
> 
> 
> config.log file entries
> 
> configure:20569: checking for x86 TSC support
> configure:20579: result: y
> #define CONFIG_X86_TSC 1
> 
> configure:20556: checking for x86 SEP instructions in syscalls
> configure:20566: result: y
> #define CONFIG_XENO_X86_SEP 1
> 
> 
> cat /proc/cpuinfo shows sep and tsc.
> 
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm 
> pni monitor ds_cpl est cid cx16 xtpr
> 
> ---------------------------
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 

Philippe.

