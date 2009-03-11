Message-ID: <49B78113.3030308@domain.hid>
Date: Wed, 11 Mar 2009 10:14:59 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <67b6b3430903091727o4a60a28ay91c7ba35ad7d08ef@domain.hid>	
	<49B634F1.2040101@domain.hid>	
	<D8EB3A02-F76F-442A-8B0D-7F26D4E16D16@domain.hid>	
	<49B6C5E5.3090302@domain.hid>	
	<67b6b3430903101403r183d6d4cwe100619a293abae2@domain.hid>	
	<49B6D69E.8050707@domain.hid>	
	<67b6b3430903101516n354263d6of00c79e130118e1@domain.hid>	
	<49B6E8B1.2030900@domain.hid>
	<67b6b3430903101552u37244233s587898c4d0f9ef3d@domain.hid>
In-Reply-To: <67b6b3430903101552u37244233s587898c4d0f9ef3d@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_queue_write return 1, with no receiver
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mark Saiia <mark.saiia@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Mark Saiia wrote:
> I am unable to examine the kernel log.  When I say hard crash I mean
> that everything locks up, including the OS.

When the system detects a corruption, it first dumps a report to the console 
then halts the CPU. So what you need to do is a way to get the console output 
over a serial link, or maybe over a netconsole.

   Therefore, I cannot do a
> logread.  I modified syslogd to output to file. Klogd is outputting to
> syslog (the version being using does not have the option to output
> directly to file).  When I examine the log on disk after reboot, there
> is nothing relevant in there.

The report can't be synced to disk, so you can't find it after next boot anyway.

   The last log message is prior to the
> crash.
> 
> On Tue, Mar 10, 2009 at 3:24 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>> Mark Saiia wrote:
>>> With the debugging options enabled, at the point when the application
>>> has previously shifted from 1 waiter to 2 waiters, the system
>>> hardlocks, just as when I was catting the queue proc entry.
>>>
>> That is expected, but what does the kernel log say at that point?
>>
>>> On 3/10/09, Philippe Gerum <rpm@xenomai.org> wrote:
>>>> Mark Saiia wrote:
>>>>> When our app's log shows the number of waiters is 1(via
>>>>> rt_queue_inquire), catting the proc entry shows the queue info, and a
>>>>> + on the next line.  However, when the log shows the number of waiters
>>>>> is 2, catting the proc entry crashes the system hard, which
>>>>> necessitates a reboot.  This behavior is completely reproducible.
>>>>>
>>>> This is an evidence that some internal data structures are terminally
>>>> broken.
>>>> You may want to enable CONFIG_XENO_OPT_DEBUG,
>>>> CONFIG_XENO_OPT_DEBUG_NUCLEUS
>>>> and
>>>> CONFIG_XENO_OPT_DEBUG_QUEUES in your kernel config. The nucleus will pull
>>>> the
>>>> break when a corruption is detected at runtime.
>>>>
>>>>> Mark
>>>>>
>>>>>
>>>>> On 3/10/09, Philippe Gerum <rpm@xenomai.org> wrote:
>>>>>> Steven Seeger wrote:
>>>>>>>> Yes, the docs are correct, and the code looks sane as well. You may
>>>>>>>> want to
>>>>>>>> double-check your findings using rt_queue_inquire() before calling
>>>>>>>> rt_queue_write(), even if this won't be 100% reliable in case your
>>>>>>>> reader is
>>>>>>>> polling the queue.
>>>>>>> Philippe,
>>>>>>>
>>>>>>> We took your advice and tried rt_queue_inquire(). If we use a timeout
>>>>>>> on
>>>>>>> the read, It seems there are always 3 waiters, which is strange
>>>>>>> because
>>>>>>> we have only one thread reading from the queue. If we remove the
>>>>>>> timout,
>>>>>>> there is either 1 or 2 waiters. It got 0 waiters once and still hung.
>>>>>>> Very strange.
>>>>>>>
>>>>>> /proc/xenomai/registry/native/queues/* will tell you which threads are
>>>>>> pending
>>>>>> on the queue.
>>>>>>
>>>>>>> Thanks,
>>>>>>> Steven
>>>>>>>
>>>>>>>
>>>>>> --
>>>>>> Philippe.
>>>>>>
>>>> --
>>>> Philippe.
>>>>
>>
>> --
>> Philippe.
>>
> 


-- 
Philippe.

