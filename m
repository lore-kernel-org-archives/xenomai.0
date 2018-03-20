References: <6aedc4bc-74b5-4a9f-5c38-036a3d7850b9@siemens.com>
 <ee7647d4-0bfd-0933-2f10-e9fdc5da2880@web.de>
 <e6331b58-4dec-171b-47eb-cd3e35a855a7@xenomai.org>
 <1807cec4-b41e-925a-a654-95352d5d1a1f@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <f1635a7c-3fd2-ac53-c80a-c327cb59aee1@xenomai.org>
Date: Tue, 20 Mar 2018 15:22:22 +0100
MIME-Version: 1.0
In-Reply-To: <1807cec4-b41e-925a-a654-95352d5d1a1f@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] 4.9 for x86 issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 03/20/2018 04:42 AM, Jan Kiszka wrote:
> On 2018-03-20 00:54, Philippe Gerum wrote:
>> On 03/10/2018 11:06 PM, Jan Kiszka wrote:
>>> On 2018-03-09 08:51, Jan Kiszka wrote:
>>>> 4.9 requires more work, I've pushed the beginning to wip/4.9 in the same
>>>> repo.
>>>
>>> I started to patch further on this during my flight (wip/4.9 updated),
>>> noticed that the 4.14-wip queue will need a little bit sysentry tweaking
>>> as well (missing 64-bit syscall dispatching), and then had to find 4.9
>>> in a rather unfortunate state /wrt x86-64: CPUs are no longer idling
>>> properly.
>>
>> Meaning they do not enter any high CSTATE although they should with
>> CPU_IDLE* properly set, or something breaks when doing so?
> 
> This was in KVM, no CSTATEs involved.
> 
>>
>> Please share your CONFIG_CPU_IDLE* settings. I'll try to reproduce here.
>>
> 
> #
> # CPU Idle
> #
> CONFIG_CPU_IDLE=y
> CONFIG_CPU_IDLE_GOV_LADDER=y
> CONFIG_CPU_IDLE_GOV_MENU=y
> # CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
> # CONFIG_INTEL_IDLE is not set
> 

Ok, #89146106e8 should restore the previous pipeline behavior from 4.4,
#595606457f in -stable should enable an (hopefully) smarter handling
with Xenomai having its say on whether the idle state should be entered.

-- 
Philippe.

