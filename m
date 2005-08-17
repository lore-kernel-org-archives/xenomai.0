Message-ID: <43039C6A.2090508@domain.hid>
Date: Wed, 17 Aug 2005 22:22:02 +0200
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] do_gettimeofday in ADEOS ISR
References: <42EFF665.3060000@domain.hid> <42F07A35.7070001@domain.hid>
In-Reply-To: <42F07A35.7070001@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org

Ciao Philippe!

Philippe Gerum wrote:
> Hannes Mayer wrote:
> 
>> Hi all!
>>
>> I was just wondering if calling do_gettimeofday in an ADEOS interrupt
>> handler might cause any problems whatsoever ?
>>
>> My ISR:
>> flags = adeos_critical_enter (NULL);
>> [...]
>> do_gettimeofday()
>> [...]
>> adeos_critical_exit (flags);
>>
>> I saw that the code for do_gettimeofday is different in kernel 2.4 and
>> kernel 2.6:
>>
>> Kernel 2.4:
>> void do_gettimeofday(struct timeval *tv) {
>> [...]
>> read_lock_irqsave(&xtime_lock, flags);
>> [...]
>> read_unlock_irqrestore(&xtime_lock, flags);
>>
>> Kernel 2.6:
>> void do_gettimeofday(struct timeval *tv) {
>> [...]
>> do {
>> [...]
>> seq = read_seqbegin(&xtime_lock);
>> [...]
>> } while (read_seqretry(&xtime_lock, seq));
>>
>> Well, read_lock_irqsave in 2.4 looks like a possible source for trouble,
>> while read_seqbegin in 2.6 doesn't do anything with interrupts, right ?
>>
> 
> Yes, but that's not better anyway. Imagine what would happen if an 
> undergoing write sequence on the xtime_lock in the Linux domain was 
> preempted by an ISR from a higher priority domain which in turn calls 
> do_gettimeofday(): the read sequence running over your high priority ISR 
> would then loop on read_seqretry(), waiting for the undergoing write to 
> end. Problem is, that the undergoing write sequence would not be allowed 
> to resume until your current high priority domain running 
> do_gettimeofday() relinquishes the processor. Catch 22. This could 
> happen in both UP and SMP configs, not to speak of the funky behaviour 
> one would get with the additional spinlock recursion issue over SMP, 
> since a write sequence also grabs a spinlock.

Late "thank you"! Sorry! Was ill, but now I'm doing better.

So do_gettimeofday is out of question...

What would you suggest to do to get absolute time in RT context ?
I'd be more than happy if you'd have a few pointers for me.

Thanks a lot & best regards,
Hannes.

