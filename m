Subject: Re: Deadlock during debugging
From: Philippe Gerum <rpm@xenomai.org>
References: <VI1PR05MB5917D854245374A7BF4E34BFF64D0@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <e16b6953-47d4-4a80-ed21-d138be84cac4@xenomai.org>
 <31819e6d-285d-e139-efc2-8b6ad157a66f@xenomai.org>
Message-ID: <733dde4d-f546-c270-11ca-7996a0fe182c@xenomai.org>
Date: Thu, 21 Nov 2019 16:31:46 +0100
MIME-Version: 1.0
In-Reply-To: <31819e6d-285d-e139-efc2-8b6ad157a66f@xenomai.org>
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
To: "Kiszka, Jan" <jan.kiszka@siemens.com>
Cc: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 11/19/19 6:39 PM, Philippe Gerum wrote:
> On 11/19/19 5:46 PM, Philippe Gerum via Xenomai wrote:
>> On 11/18/19 4:13 PM, Lange Norbert via Xenomai wrote:
>>> Hello,
>>>
>>> Here's one of my deadlocks, the output seems interleaved from 2 concurrent dumps,
>>> I ran the crashlog through decode_stacktrace.sh.
>>>
>>
>> Ok, I can reproduce this one, including in a vm. The symptom can be either a lockup, or recursive faults. I'm on it.
>>
> 
> #0b9e81807 seems to have introduced a regression. Something there may be subtly at odds with the core scheduler logic. More later.

Eh, no. #0b9e81807 only exposed a very serious and longstanding issue into the scheduler core, which may cause a CPU to pick threads from a remote runqueue in rare circumstances. And that bug is definitely mine. I need to review more code to make sure no more horror shows alike are waiting for prime time. This bug affects all Xenomai series, 3.1, 3.0, 2.x.

-- 
Philippe.

