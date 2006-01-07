Message-ID: <43C009EC.70306@domain.hid>
Date: Sat, 07 Jan 2006 19:35:24 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Fix ppc fpu support
References: <43BEBA0D.5090708@domain.hid> <43BFC344.2030907@domain.hid>
	<43BFF955.7010205@domain.hid> <43BFFD58.80303@domain.hid>
	<43C001A7.1010408@domain.hid>
In-Reply-To: <43C001A7.1010408@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Heikki Lindholm <holindho@domain.hid>
Cc: xenomai@xenomai.org

Heikki Lindholm wrote:
> Philippe Gerum kirjoitti:
> 
>> Heikki Lindholm wrote:
>>
>>> Philippe Gerum kirjoitti:
>>>
>>>> Heikki Lindholm wrote:
>>>>
>>>>> Xenomai might preempt linux when linux has cleared a tasks MSR_FP, 
>>>>> but not yet set last_task_used_math to NULL. As a result the tasks 
>>>>> MSR_FP will get set, although it should be cleared. If the task 
>>>>> happens to hit one of the codepaths that save FPU state if MSR_FP 
>>>>> is set, the wrong FPU state might be saved to the task. The 
>>>>> attached patch should fix this. I couldn't try it on most recent 
>>>>> Xenomai trunk, because latency wouldn't build anymore. However, I 
>>>>> see no reason it shouldn't work. All thee having trouble with X and 
>>>>> Xenomai, give this a shot.
>>>>>
>>>>
>>>> Merged in r383, thanks.
>>>
>>>
>>>
>>>
>>> On a related note, how do you think patches to Linux kernel that 
>>> don't fit into I-pipe should be handled? Put into patches directory 
>>> separately? There are now at least two instances for 2.6.14/ppc: the 
>>> fpu bug that I already posted on this thread and the ppc64 UP 
>>> building bug that effectively makes impossible to build I-pipe 2.6.14 
>>> for UP on ppc64.
>>>
>>
>> I'm going to put those patches on GNA, so that people can access to 
>> them easily. I'm going to add a fix for x86 too, which is needed at 
>> least on one of my boxen since 2.6.13 to make the PCI setup correct 
>> again.
>>
>> Is this patch still the right one to fix the UP build on ppc64?
>> http://patchwork.ozlabs.org/linuxppc64/patchcontent?id=3178
> 
> 
> Yep. That makes it build. But catenate it with the following and it'll 
> boot, too ;)
>

Ah! Great release. Mm, do we need another one in order to use it on a 
console shell, or should we only telnet to the G5 and look at the syslog 
for bash output? :o>

> -- Heikki Lindholm
> 
> 
> ------------------------------------------------------------------------
> 
> diff -Nru linux-2.6.14/arch/ppc64/kernel/prom.c linux-2.6.14-dev/arch/ppc64/kernel/prom.c
> --- linux-2.6.14/arch/ppc64/kernel/prom.c	2005-10-28 03:02:08.000000000 +0300
> +++ linux-2.6.14-dev/arch/ppc64/kernel/prom.c	2005-11-06 14:14:07.000000000 +0200
> @@ -1019,6 +1019,7 @@
>  		 */
>  		boot_cpuid_phys = initial_boot_params->boot_cpuid_phys;
>  		boot_cpuid = 0;
> +		set_hard_smp_processor_id(boot_cpuid, boot_cpuid_phys);
>  	} else {
>  		/* Check if it's the boot-cpu, set it's hw index in paca now */
>  		if (get_flat_dt_prop(node, "linux,boot-cpu", NULL) != NULL) {


-- 

Philippe.

