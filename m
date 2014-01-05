Message-ID: <52C9599E.1070805@xenomai.org>
Date: Sun, 05 Jan 2014 14:09:50 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAFnctWFSGJc0Q6ebZ0zBhxRmFEwkvCYKinAEgD-xzcCbfLaPBg@mail.gmail.com>
 <52C7CF1E.2050404@xenomai.org> <52C85088.7020501@xenomai.org>
 <52C86093.4000609@xenomai.org>
 <CAFnctWG1QoQ=f9JCsdxAoU25mc797fKoT9dVS_DdZFRcQ5CP3A@mail.gmail.com>
 <52C87C01.1070900@xenomai.org>
 <CAFnctWH07OsA45ucoYcijFKBJH-c-e6oNuA=_r0F+04SfvOQ2g@mail.gmail.com>
 <52C892D6.9030202@xenomai.org>
 <CAFnctWFiFM4KV04siquXk=ZCQggztwb_TYVwmQ8Une1Yoan7mQ@mail.gmail.com>
In-Reply-To: <CAFnctWFiFM4KV04siquXk=ZCQggztwb_TYVwmQ8Une1Yoan7mQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtdm_task_init call freezes the system
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Nima Nourozi <n.nourozi@gmail.com>
Cc: xenomai@xenomai.org

On 01/05/2014 01:31 AM, Nima Nourozi wrote:
> On Sat, Jan 4, 2014 at 3:01 PM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
> 
>> On 01/04/2014 10:31 PM, Nima Nourozi wrote:
>>> On Sat, Jan 4, 2014 at 1:24 PM, Gilles Chanteperdrix <
>>> gilles.chanteperdrix@xenomai.org> wrote:
>>>
>>>> On 01/04/2014 09:29 PM, Nima Nourozi wrote:
>>>>> Here is the task function. But I'm not seeing the printout.
>>>>>
>>>>> void xx_start_transfer(void *arg) {
>>>>>   rtdm_wait_period();
>>>>>   rtdm_printk("hello world\n");
>>>>> }
>>>>
>>>> Two things to try:
>>>> - see if:
>>>> latency -t 1 -p 100000
>>>> has the same issue?
>>>> - xenomai 2.6.3 instead of 2.6.1
>>>>
>>>>
>>>> --
>>>>                                                                 Gilles.
>>>>
>>>
>>> Will do when I get back to the office on Monday. I don't have the
>> hardware
>>> at the house.
>>>
>>> I noticed xenomai 2.6.3 does not contain the adeos patch for linux
>>> 2.6.38.8. Should I just put the patch I downloaded from adeos in the
>> patch
>>> folder and patch the vanilla kernel that way?
>>>
>>
>> Yes, it should work.
>>
>> Also, the bug you mention reminds me of an old issue, which I am afraid
>> got forgotten.
>>
>> Could you try disabling CONFIG_HIGH_RES_TIMERS ?
>>
>> --
>>                                                                 Gilles.
>>
> 
> OK I'll try 2.6.3 on Monday and I'll disable CONFIG_HIGH_RES_TIMERS which
> is currently enabled.
> 
> I'm curious to hear more about the bug you mentioned.

The AT91 clocksource is based on a 16 bits counter which wraps fast. To
get the clocksource working, we need to "update" the clocksource at
least once for every wrap. The solution found to do this which has the
lowest overhead is to do this in Linux timer interrupt. But with
CONFIG_HIGH_RES_TIMERS (and a real one-shot timer, which not all the
AT91 have), we have no guarantee that the Linux timer interrupt will
tick often enough.

I am not sure this is the issue you see, since you mentioned that you
could start a timer.


-- 
                                                                Gilles.

