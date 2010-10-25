Message-ID: <4CC5603E.1090707@domain.hid>
Date: Mon, 25 Oct 2010 12:47:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinN+KBK2B77opSCwDvb9bneObxL1+FTmmwpQGup@domain.hid>	<4CC20AD2.4060501@domain.hid>	<AANLkTimyj5TRgan5nE5ey6h8-WO_-na=U66si-e9Xx9F@mail.gmail.com>	<4CC44C02.4050003@domain.hid>	<AANLkTinjUHYvNJwcuEd2RQuQLWL3WvGx-jFb5iG88f0c@domain.hid>	<AANLkTikGFw6dxQHC1ukWHsTP-QoHzpbDzeMdLj=jZRP5@domain.hid>
	<AANLkTimsGjmPNE1GOzmyF4pHQe6m4RmFphuhGqdTrs1D@mail.gmail.com>
In-Reply-To: <AANLkTimsGjmPNE1GOzmyF4pHQe6m4RmFphuhGqdTrs1D@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Slow hard drive access in xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Eric Noulard <eric.noulard@domain.hid>
Cc: xenomai@xenomai.org, Peter Pastor <peter.pastor@domain.hid>

Eric Noulard wrote:
> 2010/10/24 Peter Pastor <peter.pastor@domain.hid>:
>> Hey Gilles,
>> I am in the process to configure the xenomai kernel as you suggested.
>> I found and disabled the options that you suggested (NUMA, SPARSEMEM,
>> SECCOMP, AUDITSYSCALL, KPROBES, FTRACE, SELINUX), However, I could not
>> disable SPARSEMEM. Searching for SPARSEMEM in the kernel configuration
>> simply says "Symbol: SPARSEMEM [=y]" and does not give me any further info.
>> Can you tell me how to disable it ?
> 
> SPARSEMEM may be a dependence for other options.
> If you look into the mm/Kconfig file
> http://lxr.linux.no/#linux+v2.6.32/mm/Kconfig#L103
> you may discover which options you have may need SPARSEMEM.
> 
> For example the CONFIG_MEMORY_HOTPLUG depends on SPARSEMEM.
> 
>> Also, I disabled NUMA even though the info states "For 64-bit this is
>> recommended if the system is Intel Core i7 (or later), AMD Opteron, or
>> EM64T" and my system is a 64bit, with 8 Intel Xeon cores. Hope that is ok...
> 
> NUMA stands for Non Uniform Memory Access essentially it is for multiprocessor
> machine which have a memory layout which is not "symmetric" (aka Uniform) with
> respect to each processor.
> You have some "pictured" example of NUMA systems on the HWLOC project
> http://www.open-mpi.org/projects/hwloc/
> http://www.open-mpi.org/projects/hwloc/doc/v1.0.2/#examples
> 
> Now I really don't know if enabling NUMA handling is mandatory for NUMA systems
> I guess yuo could disable NUMA handling at kernel level but yuo may
> get performance
> weirdness because the kernel is not aware of the NUMA nature.
> 
> This is pure guess, I let others give you a more "secure" answer to this.

>From what I understood NUMA means that you have several "nodes" with a
fast local memory and a slow remote memory. If you only have one CPU,
which accesses only one DRAM bank, you do not need NUMA. In any case,
the boot logs will tell you how many NUMA nodes are created. But since
Peter never sent a full boot log, I have no idea what the boot logs say.


-- 
                                                                Gilles.

