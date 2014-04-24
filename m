Message-ID: <53594F80.7010203@xenomai.org>
Date: Thu, 24 Apr 2014 19:53:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20140416180205.C2109F56@centrum.cz>,
 <534EAD14.9000906@xenomai.org>,
 <20140418105131.0F41467F@centrum.cz> <5356A4F0.8080700@xenomai.org>
 <20140424170623.DADE41D4@centrum.cz>
In-Reply-To: <20140424170623.DADE41D4@centrum.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] non-blocking rt_task_suspend(NULL)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Petr Cervenka <grugh@centrum.cz>
Cc: Xenomai <xenomai@xenomai.org>

On 04/24/2014 05:06 PM, Petr Cervenka wrote:
>> Od: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>
>>> SIGDEBUG signal was not received. Task status from
>>> rt_task_inquire() was 0x300180 or 0x300380 (depends where it is
>>> placed) When the task is in the "wrong" state, also the call of
>>> rt_task_sleep(100000) is returning permanently -EINTR code. Do
>>> you have any other idea what to check or what can cause perhaps
>>> every xenomai call fail with -EINTR in one task?
>>
>> If I had to debug this issue, I would enable the I-pipe tracer and
>> trigger a trace freeze when the -EINTR code is received. With
>> enough trace points, it should be possible to understand what
>> happens.
>>
> I called a xntrace_user_freeze() immediately when the issue occurs,
> but I simply don't understand what is happening there. The trace
> output is in the attachment. Could you please help me to understand
> it?
>
> I also got some minor problem with xntrace_user_freeze, because the
> linker was not able to find it: asyncwriter.cpp:(.text+0x843):
> undefined reference to `xntrace_user_freeze(unsigned long, int)' It
> is defined in src/skins/common/trace.c and (should be) contained in
> libxenomai.so. But I was not successful and I had to define it myself
> (under different name). Version of xenomai is 2.6.3.

We see that xnpod_suspend_thread returns immediately, likely because it 
has the XNKICKED bit set. Could you add more back trace points? So that 
we see what is setting the XNKICKED bit?


-- 
					    Gilles.

