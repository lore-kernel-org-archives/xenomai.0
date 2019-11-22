Subject: Re: Deadlock during debugging
References: <VI1PR05MB5917D854245374A7BF4E34BFF64D0@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <e16b6953-47d4-4a80-ed21-d138be84cac4@xenomai.org>
 <31819e6d-285d-e139-efc2-8b6ad157a66f@xenomai.org>
 <733dde4d-f546-c270-11ca-7996a0fe182c@xenomai.org>
 <71190701-958e-851b-894d-5445a552398a@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <89b073f1-7d13-b7de-82a2-519c7ebb2793@xenomai.org>
Date: Fri, 22 Nov 2019 18:35:22 +0100
MIME-Version: 1.0
In-Reply-To: <71190701-958e-851b-894d-5445a552398a@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 11/21/19 4:52 PM, Jan Kiszka wrote:
> On 21.11.19 16:31, Philippe Gerum wrote:
>> On 11/19/19 6:39 PM, Philippe Gerum wrote:
>>> On 11/19/19 5:46 PM, Philippe Gerum via Xenomai wrote:
>>>> On 11/18/19 4:13 PM, Lange Norbert via Xenomai wrote:
>>>>> Hello,
>>>>>
>>>>> Here's one of my deadlocks, the output seems interleaved from 2 concurrent dumps,
>>>>> I ran the crashlog through decode_stacktrace.sh.
>>>>>
>>>>
>>>> Ok, I can reproduce this one, including in a vm. The symptom can be either a lockup, or recursive faults. I'm on it.
>>>>
>>>
>>> #0b9e81807 seems to have introduced a regression. Something there may be subtly at odds with the core scheduler logic. More later.
>>
>> Eh, no. #0b9e81807 only exposed a very serious and longstanding issue into the scheduler core, which may cause a CPU to pick threads from a remote runqueue in rare circumstances. And that bug is definitely mine. I need to review more code to make sure no more horror shows alike are waiting for prime time. This bug affects all Xenomai series, 3.1, 3.0, 2.x.
>>
> 
> Uh... good that we surfaced this now. Curious to see the result!
> 

Good news is that unlike initially suspected, Xenomai 2.x is _not_ affected by the thread-suspend bug. The synchronous bp feature increased the likeliness of triggering it, as XNDBGSTOP needs to be sent to multiple threads while single-stepping.

-- 
Philippe.

