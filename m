Message-ID: <3283ee7b-cede-39bf-ffe7-c53751cfbad6@siemens.com>
Date: Tue, 25 Jan 2022 17:48:15 +0100
MIME-Version: 1.0
Subject: Re: Dovetail 5.10 - Xenomai huge page support
Content-Language: en-US
References: <a92cf71bb68a9e0701fcd6de46055eb7f584136a.camel@siemens.com>
 <745119239ef0a715f703f8315befc79ee34d0511.camel@siemens.com>
 <87sftig62e.fsf@xenomai.org>
 <33f3d640bea5967b794d817d0025e6b61d9fb4eb.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <33f3d640bea5967b794d817d0025e6b61d9fb4eb.camel@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian (T CED SES-DE)" <florian.bezdeka@siemens.com>, "rpm@xenomai.org" <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 20.01.22 10:15, Bezdeka, Florian (T CED SES-DE) wrote:
> On Thu, 2022-01-20 at 09:32 +0100, Philippe Gerum wrote:
>> "Bezdeka, Florian" <florian.bezdeka@siemens.com> writes:
>>
>>> On Wed, 2022-01-19 at 13:35 +0000, Bezdeka, Florian via Xenomai wrote:
>>>> Hi all,
>>>>
>>>> after migrating from 4.19-ipipe to 5.10-dovetail internal users are
>>>> reporting that they receive sporadic SIGXCPUs. The reported reason is
>>>> "page_fault_user".
>>>>
>>>> After disabling the huge page support in 5.10 the issue vanished. Tests
>>>> are still running, but we are optimistic that we found the root cause.
>>>>
>>>> Are there any known limitations to the huge page support in Xenomai /
>>>> Dovetail? My understanding is that huge pages are supported by Xenomai,
>>>> so any ideas where to look at?
>>>
>>> [1] is part of the 5.15-rebased dovetail branch but not part of the
>>> 5.10-rebase branch and mentions huge page handling. Could that be
>>> related? Maybe this patch is not 5.15 specific?
>>>
>>
>> It is not 5.15 specific. The same logic would apply to 5.10.
> 
> Thanks Philippe! I will give it a try! Even with huge page support
> disabled the problem came back. The first run was OK, starting a second
> run after 2h of idle triggers kind of a SIGXCPUs storm.
> 

That patch [1] is not targeting 5.10 - that was at least the information 
you shared, Philippe, when I asked this question as well back then.

Meanwhile we understood that the mode changes originated from 
CONFIG_MIGRATION. We are now trying to understand if we can live without 
it in that large NUMA setup or if some more targeted per-process pinning 
would be desirable. Such pinning may also come with implicit unCOW in 
the end, let's see.

Jan

>>
>>> [1] https://source.denx.de/Xenomai/linux-dovetail/-/commit/b0a4f4c3891949d079aa3d65f2a56428a67e580c
>>>
>>>>
>>>> Best regards,
>>>> Florian
>>
>>
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux

