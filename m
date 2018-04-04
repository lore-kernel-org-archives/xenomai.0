MIME-Version: 1.0
In-Reply-To: <DB6PR0701MB24563E2E1A942ABBBBF69E65B5A40@DB6PR0701MB2456.eurprd07.prod.outlook.com>
References: <DB6PR0701MB2456B23A97C5A7498981FC29B5A40@DB6PR0701MB2456.eurprd07.prod.outlook.com>
 <CALLqZ8Rv9PQLey6Z3eK5N7aJPBOv=ANym7uAkaeSwwRgmYCjLQ@mail.gmail.com>
 <DB6PR0701MB24563E2E1A942ABBBBF69E65B5A40@DB6PR0701MB2456.eurprd07.prod.outlook.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 4 Apr 2018 15:48:51 -0400
Message-ID: <CALLqZ8RdS3T=SNmUUkYjzzpw-paeES7X9n2FQvOTELCLYSeSmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] cobalt equivalent of rt_task_shadow()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Check out sched_setscheduler()

https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__cobalt__api__scheduler.html#ga84ad29a6f2ad27370df09c664ac65eac



On Wed, Apr 4, 2018 at 3:45 PM, Giulio Moro <g.moro@qmul.ac.uk> wrote:
> No, I have ported all the rest of the application to Cobalt (because of the faster thread wakeup time), this is the last bit that is missing.
> Thanks,
> Giulio
> ________________________________________
> From: Greg Gallagher <greg@embeddedgreg.com>
> Sent: 04 April 2018 20:44
> To: Giulio Moro
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai] cobalt equivalent of rt_task_shadow()
>
> Do you still want to use the alchemy API?  rt_task_shadow is still
> available in Xenomai 3
>
> -Greg
>
> On Wed, Apr 4, 2018 at 3:37 PM, Giulio Moro <g.moro@qmul.ac.uk> wrote:
>> On Xenomai 2.6, native API, I used to run
>>
>>   rt_task_shadow(&thisTask, threadName, threadPriority, T_JOINABLE | T_FPU);
>>
>> Now I am using Cobalt on Xenomai 3 and I am looking for a drop-in replacement.
>>
>> Going through the source of alchemy.c, copperplate/internal.c and cobalt/thread.c, it seems that rt_task_shadow() now is implemented by calling
>>
>>   pthread_setschedparam_ex(pthread_self(), SCHED_FIFO, &param_ex)
>>
>> where sched_param_ex param_ex.sched_priorirty = threadPriority
>>
>> Is that all that is needed to turn the current thread into a Xenomai thread of priority threadPriority?
>> Perhaps followed by
>>   __wrap_pthread_setname_np(pthread_self(), taskName);
>> ?
>>
>> Thanks,
>> Giulio
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> https://xenomai.org/mailman/listinfo/xenomai

