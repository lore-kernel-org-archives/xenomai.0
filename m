Message-ID: <49A2EE25.9070303@domain.hid>
Date: Mon, 23 Feb 2009 19:42:45 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BAY135-W5F4633CFE181E5E1DFB22C6B20@domain.hid>	<49A1DEBE.6020002@domain.hid>
	<BAY135-W25DA8BBF5E569E370DB25DC6AE0@domain.hid>
	<49A2D774.9000706@domain.hid>
	<BAY135-W1AF75235EF97966746A7CC6AE0@domain.hid>
In-Reply-To: <BAY135-W1AF75235EF97966746A7CC6AE0@domain.hid>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_task_create with mode T_CPU(1)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas Schaefer <thomas_schaefer_canada@domain.hid>
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

Thomas Schaefer wrote:
> Hi,
> 
> ----------------------------------------
>> Date: Mon, 23 Feb 2009 18:05:56 +0100
>> From: gilles.chanteperdrix@xenomai.org
>> To: thomas_schaefer_canada@domain.hid
>> CC: jan.kiszka@domain.hid; xenomai@xenomai.org
>> Subject: Re: [Xenomai-help] rt_task_create with mode T_CPU(1)
>>
>> Thomas Schaefer wrote:
>>> Hi,
>>>
>>> I downloaded kernel 2.6.28.7 and used the xenomai svn revision 4639.
>>> BTW. I can't update my svn repository i get "svn: Can't find a temporary directory: Internal error".
>>> According to Google this means that your svn server is out of disk space.
>>>
>>> After running the new kernel and running ./latency -c1 it hangs after "warming up...".
>>> After ctrl+c I get:
>>>
>>> ^C---|------------|------------|------------|--------|-------------------------
>>> RTS| 4699.016| 0.000| -4699.016| 0| 00:11:21/00:11:21
>>>
>>> and it still hangs. Except for this windows the system stays responsive.
>>>
>>> Revision 4595 seems to work as expected.
>>>
>>> I tried booting the kernel with maxcpus=2 but it yields the same result.
>>>
>>> I am running debian lenny on a quad core xeon with 3GB ram.
>>> The Kernel is compiled for 64bit.
>>> I attached the kernel config file.
>> What does /proc/cpuinfo say ?
>>
>>
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 23
> model name      : Intel(R) Xeon(R) CPU           L5408  @ 2.13GHz
> stepping        : 6
> cpu MHz         : 2127.961
> cache size      : 6144 KB
> physical id     : 0
> siblings        : 2
> core id         : 0
> cpu cores       : 2
> apicid          : 0
> initial apicid  : 0
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 10
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2
> ss ht tm pbe syscall nx lm constant_tsc arch_perfmon pebs bts rep_good pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr
> pdcm dca sse4_1 lahf_lm tpr_shadow vnmi flexpriority
> bogomips        : 4255.92
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 38 bits physical, 48 bits virtual
> power management:
> 
> I turned on the APCI except for processor but ./latency -c1 still hangs.

That is normal, the kernel only detected one cpu.

-- 
                                                 Gilles.

