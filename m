Message-ID: <52F223B5.2010408@xenomai.org>
Date: Wed, 05 Feb 2014 12:42:45 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtc5QWhvcOwp2fjkUMHB1jTV9gV-hXf+3vzt0McLZ433fQ@mail.gmail.com>	<52EF71E0.3080208@xenomai.org>
 <CAKKWdtdpVTdD6j1QYXB-wF_3SjpQWDTB62=kKrCWU7Y1zkc9_Q@mail.gmail.com>
In-Reply-To: <CAKKWdtdpVTdD6j1QYXB-wF_3SjpQWDTB62=kKrCWU7Y1zkc9_Q@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] installing a signal handler
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On 02/05/2014 12:08 PM, ali hagigat wrote:
> On 2/3/14, Philippe Gerum <rpm@xenomai.org> wrote:
>> On 02/01/2014 01:36 PM, ali hagigat wrote:
>>> It seems that signal handler does not execute...
>>> -------------- next part --------------
>>>> cat /proc/xenomai/sched
>>> CPU  PID    CLASS  PRI      TIMEOUT   TIMEBASE   STAT       NAME
>>>     0  0      idle    -1      -         master     R          ROOT/0
>>>     1  0      idle    -1      -         master     R          ROOT/1
>>>     2  0      idle    -1      -         master     R          ROOT/2
>>>     3  0      idle    -1      -         master     R          ROOT/3
>>>     0  0      rt      50      -         master     Df         KTask1
>>>     0  0      rt      50      -         master     Df         KTask2
>>>
>>>
>>>> dmesg
>>> notify is successful...
>>>
>>
>> This deprecated feature does not wake up the receiving task.
>>
>> --
>> Philippe.
>>
>
> There are some warning messages complaining using the deprecated
> function, "rt_task_create()" at compile.
> but no warn message for rt_task_notify().
> This function does not work at user space too.
>

Your application code does wrong assumptions on what 
rt_task_notify/catch really does. So I'm unsure what "too" refers to in 
your sentence, but as a matter of fact, your code can't work.

Besides, would you have cared for the warning at rt_task_create() and 
refrained from using a dead interface from kernel space, you would not 
have even considered using rt_task_notify() for sending signals to a 
kernel-based native task in the first place.

Regarding the behavior of rt_task_notify() from user-space, you have to 
provide evidence that you are properly using the interface, so that 
people are not always investing time fixing your own bugs. You received 
more than enough information in the previous conversations to do so. 
FWIW, I had a quick look at the Xenomai code, and did not find anything 
wrong.

-- 
Philippe.

