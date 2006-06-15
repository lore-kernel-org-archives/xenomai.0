Message-ID: <44916DB3.5000206@domain.hid>
Date: Thu, 15 Jun 2006 16:24:51 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <44720BD1.805@domain.hid>
	<447E9E9E.6070301@domain.hid>	<4486FCA3.2070501@domain.hid>
	<448703C2.8030601@domain.hid> <4487DEC5.50705@domain.hid>
	<448B4589.6030101@domain.hid> <448D2574.1000204@domain.hid>
	<448D2861.9010704@domain.hid> <448D337F.9060002@domain.hid>
	<449155C3.6030502@domain.hid>
In-Reply-To: <449155C3.6030502@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [PATCH] kgdb/x86 over I-pipe
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>Jan Kiszka wrote:
>>
>>>Philippe Gerum wrote:
>>>
>>>>While we are at it,
>>>>#define current ipipe_safe_current() /* ? */
>>>
>>>
>>>Nope, there is the need for some special changes.
>>>
>>
>>If you refer to the cache flushing issue, then it would be better to
>>actually check for foreign stacks explicitely, so that you could
>>substitute current globally:
>>
>>-    if (CACHE_FLUSH_IS_SAFE && current->mm &&
>>-            addr < TASK_SIZE)
>>+    if (CACHE_FLUSH_IS_SAFE && !testbit(IPIPE_NOSTACK_FLAG,         
>>+     &ipipe_percpu_domain[cpuid]->cpudata[cpuid].status) &&
>>+            current->mm && addr < TASK_SIZE)
>>
> 
> 
> Right - on first sight. I tried to redefine current, but the
> ipipe_safe_current macro requires that symbol itself, ugh. Turning
> ipipe_safe_current into a static inline doesn't work due to circular
> dependencies on linux/sched.h.
> 
> So I guess it's best to keep it as it is (though kgdb-ipipe.patch would
> have become really cute).
> 

Ack.

-- 

Philippe.

