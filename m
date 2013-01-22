MIME-Version: 1.0
In-Reply-To: <50FE6259.40406@xenomai.org>
References: <CAPpP=rM-0xrf5N9iKVq2S+7wRrD4LoHxMTUxnxYb6aYbNP9nEA@mail.gmail.com>
	<50FE6259.40406@xenomai.org>
Date: Tue, 22 Jan 2013 12:09:28 +0100
Message-ID: <CAPpP=rP0Br9Jv0Rp73=CW7Qd2Tw8c7xFguXYGSSuRi+jBvPDDw@mail.gmail.com>
From: alex alex <duch.alexandre@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] [Posix skin] program test with pthread_set_mode_np
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

2013/1/22 Philippe Gerum <rpm@xenomai.org>

> On 01/22/2013 10:41 AM, alex alex wrote:
>
>> Hi,
>>
>> In the attached test program I test the scheduler lock operation with
>> pthread_set_mode_np and the PTHREAD_LOCK_SCHED bit mask.
>>
>> Description:
>> Two tasks are created.
>> t1 lock the scheduler then load the cpu, sleep then load the cpu again but
>> t2 task start when t1 sleep while the scheduler is locked. Why t1 is
>> preempted?
>>
>
> Think of what would happen would a blocked task be allowed to keep the
> scheduler lock.
>
>
>>
According to the documentation :
"PTHREAD_LOCK_SCHED when set, locks the scheduler, which prevents the
current thread from being switched out by the scheduler until the scheduler
is unlocked"
This is what t1 do, locking the scheduler then unlocked it.
t1 shouldn't be switched out until the scheduler be unlocked.
