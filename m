Subject: Re: Porting questiong about mips
References: <bb0b247d-c21c-8416-b2ef-d341a1130d2f@linx-info.com>
 <e5b7c308-395c-50be-84ce-a95a9241c699@linx-info.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <af1c5b83-5434-2a0b-c55f-86ce22e9e1af@siemens.com>
Date: Thu, 20 Dec 2018 10:05:29 +0100
MIME-Version: 1.0
In-Reply-To: <e5b7c308-395c-50be-84ce-a95a9241c699@linx-info.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: duanwujie <wjduan@linx-info.com>, Philippe Gerum <rpm@xenomai.org>, =?UTF-8?B?5b2t5b+X6Iiq?= <zhpeng@linx-info.com>
Cc: Xenomai <xenomai@xenomai.org>

On 20.12.18 09:59, duanwujie wrote:
> Hi, Phi and Jan:
> 
>          The correct handler is handle_percpu_irq !
> 
> 
>> Hi, Phi and Jan:
>>
>>         I try to port the ipipe to mips arch  according the 
>> https://gitlab.denx.de/Xenomai/xenomai/wikis/Porting_Xenomai_To_A_New_Arm_SOC#terminology 
>>
>>
>>         Now it worked on the single cpu,but SMP failed. I consider the 
>> interrupt controller's problem. The flow handler is handle_irq_event_percpu. 
>> But the article haven't port information about this handler.
>>
>>         Is there any clue for it.
>>

First question is how your port fails on SMP: Does it no longer get interrupts 
so that you believe the it's interrupt controller related?

I do not know the MIPS arch and how it compares to ARM (which that other 
document covers). Does it have something comparable to the per-CPU interrupts 
(SGI, PPI) of ARM?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

