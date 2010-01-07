Message-ID: <4B46125D.4010602@domain.hid>
Date: Thu, 07 Jan 2010 17:57:01 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B45F088.9010603@domain.hid> <4B45F163.4000504@domain.hid>
	<4B460255.30200@domain.hid>
In-Reply-To: <4B460255.30200@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] native skin 2.5.0: rt_task_create() segfaults if
 stacksize parameter too small
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

Stefan Kisdaroczi wrote:
> Am 07.01.2010 15:36, schrieb Gilles Chanteperdrix:
>> Stefan Kisdaroczi wrote:
>>> hi,
>>>
>>> i have upgraded xenomai to 2.5.0 (x86,32bit). My application segfaults when I
>>> try to create a task with stacksize 2048, this worked with 2.4.10.
>>> Because my app is written in pascal i have reproduced the problem with the
>>> xenomai trivial-periodic.c example:
>>>
>>> -	rt_task_create(&demo_task, "trivial", 0, 99, 0);
>>> +	rt_task_create(&demo_task, "trivial",16911, 99, 0);
>>>
>>> Stacksize 0 -> default stack size : ok
>>> Stacksize > 0 and <= 16911 : Segmentation fault
>>> Stacksize >= 16912 : ok
>>>
>>> Any hints ?
>> What does the task do? If it uses printf, printf needs a lot of room on
>> the stack.
>>
> 
> To clarify:
> It does not depend on the task body, the task is not even started.
> The segfault happens when calling rt_task_create(), before rt_task_start()
> is called.

Actually, when calling rt_task_create, the thread is created, under the
hood, and waits to be started. So the segmentation fault is most
certainly due to a stack overflow in the newly created thread.

And I am afraid I know why it happens: the newly merged user-space
signals support requires roughly 16 * sizeof(struct siginfo) on stack.
But this amounts to two Kbytes here. Could you run the following program
on your target ?

#include <stdio.h>
#include <signal.h>

struct xnsig {
        unsigned nsigs;
        unsigned remaining;
        struct {
                unsigned muxid;
                struct siginfo si;
        } pending[16];
};

int main(void)
{
        printf("%u\n", sizeof(struct xnsig));
        return 0;
}

-- 
					    Gilles.

