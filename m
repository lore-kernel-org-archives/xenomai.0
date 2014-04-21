Message-ID: <5354F784.5060301@xenomai.org>
Date: Mon, 21 Apr 2014 12:48:36 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1396785025.43347.YahooMailNeo@web171602.mail.ir2.yahoo.com>
 <534276FE.7000805@xenomai.org>
 <1397673291.55013.YahooMailNeo@web171601.mail.ir2.yahoo.com>
In-Reply-To: <1397673291.55013.YahooMailNeo@web171601.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Deadlock in CANCEL_RESTORE with
 CONFIG_XENO_ASYNC_CANCEL during thread suspension
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/16/2014 08:34 PM, Matthias Schneider wrote:
> ----- Original Message -----
>
>> From: Philippe Gerum <rpm@xenomai.org>
>> To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai.org" <xenomai@xenomai.org>
>> Cc:
>> Sent: Monday, April 7, 2014 11:59 AM
>> Subject: Re: [Xenomai] Deadlock in CANCEL_RESTORE with CONFIG_XENO_ASYNC_CANCEL during thread suspension
>>
>> On 04/06/2014 01:50 PM, Matthias Schneider wrote:
>>>   Hi all,
>>>
>>>   using xenomai-forge with mercury, when
>>>   CONFIG_XENO_ASYNC_CANCEL is defined, CANCEL_RESTORE
>>>   will include a call to backtrace_check(), which in turn
>>>   will call backtrace_dump, which will take the
>>>   mutex "__printlock".
>>>
>>>   In case a thread gets suspended while holding that lock,
>>>   the next call to CANCEL_RESTORE from whatever thread will
>>>   cause a deadlock.
>>
>> That's the price for using thread suspend/resume unsafe constructs, we
>> never know at which location we will be preempting threads.
>>
>>
>>>
>>>   Is there any way of getting around that?
>>>
>>
>> We could block the notification signal when holding this internal lock.
>> I'll have a look.
>>
>> --
>> Philippe.
>>
>
> Would the enclosed patch be an acceptable solution to the problem? It seems to
> work quite well in my case.
>

We need to block the notification signal each time the printout 
serialization lock is acquired, not only when dumping a backtrace.

It is also preferable not to assume any sigmask disposition when doing 
so, i.e. forcibly unblocking SIGNOTIFY may prove dangerous in the 
future, depending on the call site.

Also, the code should work for both the mercury and cobalt cores.

The commit below should address these issues:

http://git.xenomai.org/xenomai-forge.git/commit/?h=next&id=9ba637cc7902cea15944a894443e22caf0c19139

-- 
Philippe.

