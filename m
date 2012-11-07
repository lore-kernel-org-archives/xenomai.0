Message-ID: <509ABA2F.3070507@xenomai.org>
Date: Wed, 07 Nov 2012 20:44:47 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <9A40FDD0-65C2-470A-ACB7-AB556CF62501@mah.priv.at>	<509AB38E.1060802@grandegger.com>
	<39DEC9F1-236E-481A-A685-E3EFE883BCFA@mah.priv.at>
In-Reply-To: <39DEC9F1-236E-481A-A685-E3EFE883BCFA@mah.priv.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM API: no CPU binding,
	FPU setting for tasks available?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org

On 11/07/2012 08:26 PM, Michael Haberler wrote:

> 
> Am 07.11.2012 um 20:16 schrieb Wolfgang Grandegger:
> 
>> On 11/07/2012 08:06 PM, Michael Haberler wrote:
>>> As suggested, I adapted the LinuxCNC kernel support from native
>>> to RTDM API; my remaining issues are:
>>> 
>>> - how do I achieve CPU binding which is available in
>>> rt_task_create() (T_CPU(cpuid))? - do I need to tell an RTDM task
>>> that the thread might use the FPU (T_FPU in rt_task_create()) ?
>> 
>> http://www.xenomai.org/documentation/trunk/html/api/group__task.html#ga03387550693c21d0223f739570ccd992
>>
>> 


it pretty clear.

> 
> Wolfgang -
> 
> I was suggested:
> 
>> Also note that if LinuxCNC code runs in kernel-space, you should
>> not be using the native API, but the RTDM API.
> 
> which I translate as 'use rtdm_task_init instead of rt_task_create'
> 
> I have the kernel code using the native API just fine. The concern I
> have is for long-term compatibility, which is why I'm attempting to
> port to RTDM.


In xenomai 3.0, FPU in kernel-space will not be supported. But it is
true that we lack a service to set affinity for RTDM tasks. Though if
you are creating the task from a linux context (module initialization
function, or linux kernel threas), you can probably use set_cpus_allowed
before rtdm_task_init to get the task created on the target cpu (set
call it again after to restore the mask).

-- 
                                                                Gilles.

