MIME-Version: 1.0
In-Reply-To: <52EF71E0.3080208@xenomai.org>
References: <CAKKWdtc5QWhvcOwp2fjkUMHB1jTV9gV-hXf+3vzt0McLZ433fQ@mail.gmail.com>
 <52EF71E0.3080208@xenomai.org>
Date: Wed, 5 Feb 2014 14:38:50 +0330
Message-ID: <CAKKWdtdpVTdD6j1QYXB-wF_3SjpQWDTB62=kKrCWU7Y1zkc9_Q@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] installing a signal handler
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>

On 2/3/14, Philippe Gerum <rpm@xenomai.org> wrote:
> On 02/01/2014 01:36 PM, ali hagigat wrote:
>> It seems that signal handler does not execute...
>> -------------- next part --------------
>>> cat /proc/xenomai/sched
>> CPU  PID    CLASS  PRI      TIMEOUT   TIMEBASE   STAT       NAME
>>    0  0      idle    -1      -         master     R          ROOT/0
>>    1  0      idle    -1      -         master     R          ROOT/1
>>    2  0      idle    -1      -         master     R          ROOT/2
>>    3  0      idle    -1      -         master     R          ROOT/3
>>    0  0      rt      50      -         master     Df         KTask1
>>    0  0      rt      50      -         master     Df         KTask2
>>
>>
>>> dmesg
>> notify is successful...
>>
>
> This deprecated feature does not wake up the receiving task.
>
> --
> Philippe.
>

There are some warning messages complaining using the deprecated
function, "rt_task_create()" at compile.
but no warn message for rt_task_notify().
This function does not work at user space too.

