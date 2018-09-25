References: <E1fxEEU-0004LE-Ln@xenomai.org>
 <77d089a2-a261-c90f-ef54-83c107a3f606@siemens.com>
 <d2ae4167-c52b-5f3e-ecfb-57f69fc9015a@xenomai.org>
 <e027f8b8-ba4f-2184-fc45-98c7ea213850@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <6301072d-3d4c-1dee-e445-4f6d1e078093@xenomai.org>
Date: Tue, 25 Sep 2018 15:10:01 +0200
MIME-Version: 1.0
In-Reply-To: <e027f8b8-ba4f-2184-fc45-98c7ea213850@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] cobalt/kernel: always use explicit
 preprocessor conditionals
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 09/25/2018 01:47 PM, Jan Kiszka wrote:
> On 24.09.18 16:03, Philippe Gerum wrote:
>> On 09/24/2018 03:52 PM, Jan Kiszka wrote:
>>> On 04.09.18 15:31, Philippe Gerum wrote:
>>>> Testing debug switches using '#if XENO_DEBUG(<feat>)' may confuse the
>>>> build system's dependency tracker, breaking the build, or even
>>>> producing a non-bootable kernel in extreme cases. Typically, turning
>>>> on/off the lock debugging code - usually in absence of any other
>>>> change - may cause the following error to pop up at the link stage:
>>>>
>>
>> [snip]
>>
>>>
>>> I've picked this one now as stable backport to our 3.0.x branch. I'm not
>>> that sure we should put the other two ("cobalt/sched: improve watchdog
>>> accuracy", "cobalt/sched: group high-level init/cleanup code") there as
>>> well, though.
>>>
>>
>> We don't need the second one in stable for sure. Merging the first one
>> there would be beneficial to people who want timeouts shorter than 4s.
>> E.g. one just cannot use the watchdog feature with a 1s timeout, false
>> positives would trigger almost immediately even with mildly busy rt
>> systems.
>>
>> This said, the only report I got (unfortunately privately) about such
>> issue was only a few weeks ago, so this problem does not look like
>> affecting many people.
>>
> 
> Yeah, and we are getting closer to be able to release 3.1 with that
> improvement included. Therefore, I'm leaning towards declaring it a
> feature, not a stable fix.
> 

Ack.


-- 
Philippe.

