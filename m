Subject: Re: [PATCH 2/5] cobalt/sched: dovetail: disable separate per-IRQ
 statistics
References: <20210327103524.2305814-1-rpm@xenomai.org>
 <20210327103524.2305814-3-rpm@xenomai.org>
 <be8126c4-66fd-fd5f-d1e9-245989cfc960@siemens.com>
 <874kgipawa.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <73422e23-64ba-d003-6c9e-e27a5c943190@siemens.com>
Date: Wed, 7 Apr 2021 18:16:15 +0200
MIME-Version: 1.0
In-Reply-To: <874kgipawa.fsf@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 07.04.21 13:55, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 27.03.21 11:35, Philippe Gerum wrote:
>>> From: Philippe Gerum <rpm@xenomai.org>
>>>
>>> This feature should be available directly from Dovetail.
>>>
>>
>> What is the corresponding kernel option of Dovetail? Can't we select it
>> here for compat reasons?
>>
> 
> Not yet implemented. I need to think about it a bit more.
> 

Ah, misread the comment then. Makes sense as it is for now.

Jan

>> Jan
>>
>>> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>>> ---
>>>  kernel/cobalt/Kconfig | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/cobalt/Kconfig b/kernel/cobalt/Kconfig
>>> index a266011d4..88953ff24 100644
>>> --- a/kernel/cobalt/Kconfig
>>> +++ b/kernel/cobalt/Kconfig
>>> @@ -137,7 +137,7 @@ config XENO_OPT_STATS
>>>  
>>>  config XENO_OPT_STATS_IRQS
>>>  	bool "Account IRQ handlers separatly"
>>> -	depends on XENO_OPT_STATS
>>> +	depends on XENO_OPT_STATS && IPIPE
>>>  	default y
>>>  	help
>>>  	When enabled, the runtime of interrupt handlers is accounted
>>> @@ -145,6 +145,8 @@ config XENO_OPT_STATS_IRQS
>>>  	occurrence of shared interrupts is accounted on a per-handler
>>>  	basis.
>>>  
>>> +	This option is available to legacy I-pipe builds only.
>>> +
>>>  config XENO_OPT_SHIRQ
>>>  	bool "Shared interrupts"
>>>  	help
>>>
> 
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

