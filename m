Subject: Re: About the priority that is seen by /proc/xenomai/sched/threads
References: <CAAvDm6aw3mLyhsJsXmd0G+EbYddR-GC+bWTunCzsRgfOY2ws4w@mail.gmail.com>
 <6ecdedda-a2eb-c940-a3e8-70488a8c8cb8@siemens.com>
 <CAAvDm6Zkj-2R9nXWyCYnPjXGGNsQaE846gx=RGxVvKSL4vBSNA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <05f1c1bf-a29c-60d4-ef01-263c600f4f30@siemens.com>
Date: Thu, 27 Aug 2020 10:31:49 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6Zkj-2R9nXWyCYnPjXGGNsQaE846gx=RGxVvKSL4vBSNA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
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
To: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On 27.08.20 09:55, 孙世龙 sunshilong wrote:
> Thank you for your attention to my question.
> 
>>> Which one has a higher priority, the thread named by "main" that is
>>> created by rt_task_create or the
>>> one named by "timer-internal" that is created internally?
>>>
>>> As far as I know, the priority of the thread created by rt_task_create
>>> is between 0 to 99. It could not
>>> be greater than 99.
> 
>> It's timer-internal. The Xenomai core has an extended priority range
>> (0..259).
> 
> What are relations between the priority set by rt_task_create and the
> extended priority used by the Xenomai core?
> Is there a one to one correspondence?
> How to know which one has a higher priority?

The alchemy skin uses T_LOPRIO..T_HIPRIO (0..99). Thus, skins using the
extended range can create task with even higher prio.

Jan

> 
> On Thu, Aug 27, 2020 at 2:08 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 27.08.20 05:00, 孙世龙 sunshilong via Xenomai wrote:
>>> Hi, list
>>>
>>> Which one has a higher priority, the thread named by "main" that is
>>> created by rt_task_create or the
>>> one named by "timer-internal" that is created internally?
>>>
>>> As far as I know, the priority of the thread created by rt_task_create
>>> is between 0 to 99. It could not
>>> be greater than 99.
>>>
>>> $cat /proc/xenomai/sched/threads
>>> CPU  PID    CLASS  TYPE      PRI   TIMEOUT       STAT       NAME
>>>   0  0      idle   core       -1   -             R          [ROOT/0]
>>>   1  0      idle   core       -1   -             R          [ROOT/1]
>>>   2  0      idle   core       -1   -             R          [ROOT/2]
>>>   0  630    rt     core       98   -             W          [rtnet-stack]
>>>   0  631    rt     core        0   -             W          [rtnet-rtpc]
>>>   1  5414   rt     cobalt     50   1ms887us      D          main
>>>   1  5416   rt     cobalt    259   -                        timer-internal
>>>   2  6708   rt     cobalt     50   1ms994us      D          main
>>>   2  6710   rt     cobalt    259   -             W          timer-internal
>>>
>>
>> It's timer-internal. The Xenomai core has an extended priority range
>> (0..259).
>>
>> Jan
>>
>> --
>> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>> Corporate Competence Center Embedded Linux

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

