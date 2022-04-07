Message-ID: <36839700-8ca3-48b2-476e-8723a2030560@siemens.com>
Date: Thu, 7 Apr 2022 18:39:40 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/5] cobalt/events: add auto-clear feature
Content-Language: en-US
References: <20220406155648.1592472-1-rpm@xenomai.org>
 <53b70915-2040-d2aa-3077-698fa8be01af@siemens.com>
 <87pmltf82m.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <87pmltf82m.fsf@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
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

On 07.04.22 13:16, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 06.04.22 17:56, Philippe Gerum via Xenomai wrote:
>>> From: Philippe Gerum <rpm@xenomai.org>
>>>
>>> The current implementation does not atomically consume+clear the event
>>> set to be received by the waiter(s), which makes it useless for
>>> anything but a plain one-time latch due to the race window this opens
>>> with a consume[A]->signal[B]->clear[A] sequence.
>>>
>>> To address this issue, let's provide the auto-clear feature with
>>> __cobalt_event_wait().
>>>
>>> This change affects the ABI by adding the auto-clear mode as an opt-in
>>> feature, enabled by passing COBALT_EVENT_AUTOCLEAR to
>>> cobalt_event_init().
>>>
>>
>> Makes sense, but shouldn't autoclear be rather the default then? Which
>> users are affected? None in-tree so far?
>>
> 
> There is one user in copperplate:
> https://source.denx.de/Xenomai/xenomai/-/blob/28158391258eea52650856bef5d3ed6ebaaf813b/lib/copperplate/eventobj.c#L87
> 
> which indirectly affects rt_event_signal() from the alchemy API:
> https://source.denx.de/Xenomai/xenomai/-/blob/28158391258eea52650856bef5d3ed6ebaaf813b/lib/alchemy/event.c#L453
> 
> Nobody raised the issue so far with alchemy, which is why I refrained
> from turning the autoclear mode on by default so far. This is debatable,
> since no documentation explains the limitation on usage caused by not
> having the autoclear mode set.
> 

So, the pattern via Alchemy would be

Thread A		Thread B

rt_event_wait()
			rt_event_signal()
rt_event_clear()

That would force users to perform a state check via a side-channel after
clearing the event to avoid starting to waiting if the condition was met
again.

OK, but how could users request the new mode in rt_event_create? There
is not even a EV_AUTOCLEAR flag for it. Do you have more patches pending?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

