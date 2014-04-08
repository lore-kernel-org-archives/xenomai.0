Message-ID: <5343A3A2.7080000@xenomai.org>
Date: Tue, 08 Apr 2014 09:22:10 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1396262085.387.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <53395104.6050109@xenomai.org> <53396B31.1090903@xenomai.org>
 <5339AACA.4090807@xenomai.org>
 <1396782702.1096.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <53416D09.7060805@xenomai.org>
 <1396889360.63594.YahooMailNeo@web171605.mail.ir2.yahoo.com>
In-Reply-To: <1396889360.63594.YahooMailNeo@web171605.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] EINTR in notifier.c (mercury)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/07/2014 06:49 PM, Matthias Schneider wrote:
> ----- Original Message -----
>
>> From: Philippe Gerum <rpm@xenomai.org>
>> To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai.org" <xenomai@xenomai.org>
>> Cc:
>> Sent: Sunday, April 6, 2014 5:04 PM
>> Subject: Re: [Xenomai] EINTR in notifier.c (mercury)
>>
>> On 04/06/2014 01:11 PM, Matthias Schneider wrote:
>>>>   On Monday, March 31, 2014 7:50 PM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>
>>>>>   On 03/31/2014 03:18 PM, Philippe Gerum wrote:
>>>>>     On 03/31/2014 01:27 PM, Gilles Chanteperdrix wrote:
>>>>>>     On 03/31/2014 12:34 PM, Matthias Schneider wrote:
>>>>>>>     Hi all,
>>>>>>>
>>>>>>>
>>>>>>>     still working on thread suspension in mercury, I noticed
>> that some
>>>>>>>     threadobj_suspend() and threadobj_resume() calls seemed
>> not to have the desired
>>>>>>>     effect. Analyzing the issue, I found out that sometimes
>> the read operations on
>>>>>>>     the pipe in notifier_wait() seem to return with EINTR,
>> especially in
>>>>>>>     heavily loaded systems. Restarting the read system call
>> in that case made
>>>>>>>     thread suspension a lot more reliable in my case.
>>>>>>>
>>>>>>>     I have attached a patch adding loops to deal with the
>> EINTR situation in all
>>>>>>
>>>>>>     You can probably avoid testing for EINTR if all signal
>> handlers are
>>>>>>     registered with the SA_RESTART flag.
>>>>>>
>>>>>
>>>>>     The app may not explicitly care for signals (granted, most would
>> do, but
>>>>>     we would then have to assume they do it right).
>>>>>
>>>>
>>>>   Yes, applications may want to use signals to interrupt a call to read
>>>>   and voluntarily get EINTR anyway.
>>>>                            Gilles.
>>>
>>>
>>>   Please find attached a third version of my patch dealing with
>>>   EINTR syscalls. Note that I also stumbled over unexpected behavior
>>>   in threadobj_sleep and cancel_sync due to EINTRs. Considering that
>>>   mercury is using signals for user-space round-robin and thread
>>>   suspension, even without any application signals EINTR happens
>>>   quite often.
>>
>> @@ -86,9 +88,13 @@ static void notifier_sighandler(int sig, siginfo_t *siginfo,
>> void *uc)
>>          if (nf->owner && nf->owner != tid)
>>              continue;
>>
>> -        while (__STD(read(nf->psfd[0], &c, 1)) > 0)
>> -            /* Callee must run async-safe code only. */
>> -            nf->callback(nf);
>> +        do {
>> +            ret = __STD(read(nf->psfd[0], &c, 1));
>> +            if (ret > 0)
>> +                /* Callee must run async-safe code only. */
>> +                nf->callback(nf);
>> +        } while (ret > 0 || errno == EINTR);
>>
>> In theory, we could receive a zero byte count on EOF, in which case we should
>> not test errno, rather we should bail out immediately.
>>
>> @@ -1093,7 +1093,9 @@ int threadobj_sleep(struct timespec *ts)
>>       */
>>      current->run_state = __THREAD_S_DELAYED;
>>      threadobj_save_timeout(&current->core, ts);
>> -    ret = -__RT(clock_nanosleep(CLOCK_COPPERPLATE, TIMER_ABSTIME, ts, NULL));
>> +    do
>> +        ret = -__RT(clock_nanosleep(CLOCK_COPPERPLATE, TIMER_ABSTIME, ts,
>> NULL));
>>
>> We should definitely pass and use the "remain" field in
>> clock_nanosleep(), not to restart a complete wait each time we get interrupted.
>>
>>
>> --
>> Philippe.
>>
>
> I have attached a new version of the patch leaving the loop on ret == 0. Note
> that this will be a new behavior in compared to before the patch.
>
> Gilles already pointed out that TIMER_ABSTIME allows restarting the same syscall
> in threadobj_sleep.
>

Merged, thanks.


-- 
Philippe.

