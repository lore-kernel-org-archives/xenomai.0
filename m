Message-ID: <4B4738FE.4020605@domain.hid>
Date: Fri, 08 Jan 2010 14:54:06 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B45F088.9010603@domain.hid> <4B45F163.4000504@domain.hid>
	<4B460255.30200@domain.hid> <4B46125D.4010602@domain.hid>
	<4B471B48.6040301@domain.hid> <4B471D96.7050001@domain.hid>
	<4B473206.90209@domain.hid> <4B47338E.9080304@domain.hid>
	<4B4735F4.6060503@domain.hid>
In-Reply-To: <4B4735F4.6060503@domain.hid>
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
> Am 08.01.2010 14:30, schrieb Gilles Chanteperdrix:
>> Stefan Kisdaroczi wrote:
>>> Am 08.01.2010 12:57, schrieb Gilles Chanteperdrix:
>>>> Stefan Kisdaroczi wrote:
>>>>> Am 07.01.2010 17:57, schrieb Gilles Chanteperdrix:
>>>>>> Stefan Kisdaroczi wrote:
>>>>>>> Am 07.01.2010 15:36, schrieb Gilles Chanteperdrix:
>>>>>>>> Stefan Kisdaroczi wrote:
>>>>>>>>> hi,
>>>>>>>>>
>>>>>>>>> i have upgraded xenomai to 2.5.0 (x86,32bit). My application segfaults when I
>>>>>>>>> try to create a task with stacksize 2048, this worked with 2.4.10.
>>>>>>>>> Because my app is written in pascal i have reproduced the problem with the
>>>>>>>>> xenomai trivial-periodic.c example:
>>>>>>>>>
>>>>>>>>> -	rt_task_create(&demo_task, "trivial", 0, 99, 0);
>>>>>>>>> +	rt_task_create(&demo_task, "trivial",16911, 99, 0);
>>>>>>>>>
>>>>>>>>> Stacksize 0 -> default stack size : ok
>>>>>>>>> Stacksize > 0 and <= 16911 : Segmentation fault
>>>>>>>>> Stacksize >= 16912 : ok
>>>>>>>>>
>>>>>>>>> Any hints ?
>>>>>>>> What does the task do? If it uses printf, printf needs a lot of room on
>>>>>>>> the stack.
>>>>>>>>
>>>>>>> To clarify:
>>>>>>> It does not depend on the task body, the task is not even started.
>>>>>>> The segfault happens when calling rt_task_create(), before rt_task_start()
>>>>>>> is called.
>>>>>> Actually, when calling rt_task_create, the thread is created, under the
>>>>>> hood, and waits to be started. So the segmentation fault is most
>>>>>> certainly due to a stack overflow in the newly created thread.
>>>>>>
>>>>>> And I am afraid I know why it happens: the newly merged user-space
>>>>>> signals support requires roughly 16 * sizeof(struct siginfo) on stack.
>>>>>> But this amounts to two Kbytes here. Could you run the following program
>>>>>> on your target ?
>>>>> salut gilles,
>>>>>
>>>>> as the stacksize is already checked and increased to PTHREAD_STACK_MIN if
>>>>> the value is too small, i suggest to take the stacksize needed by xenomai
>>>>> into account too. The attached patch is clearly wrong, but it solved the
>>>>> problem for me.
>>>> PTHREAD_STACK_MIN varies a lot depending on architectures and even
>>>> depending on the glibc versions. Which is why we took 32 Kb as the
>>>> default stack size. Since the default is enough even for struct xnsig,
>>>> if you are asking a smaller size, you may have good reasons to do so. We
>>>> should check that the size is at least sizeof(struct xnsig), but since
>>>> PTHREAD_STACK_MIN is larger than struct xnsig, it should work as is.
>>>>
>>>> The point is that your system seems to require 16 Kb whereas
>>>> sizeof(struct xnsig) is only 2Kb. So, there is something wrong somewhere
>>>> else.
>>>>
>>>> Could you run the segfaulting program inside gdb, and print the frames
>>>> infos ?
>>> gdb logfile attached
>> Ok. Could you get the value of the "esp" register at the time of the
>> failure, as well as the contents of /proc/<pid>/smaps where <pid> is the
>> pid of the failing application ? You can run the cat /proc/<pid>/smaps
>> when the process is stopped in gdb.

How much is PTHREAD_STACK_MIN on your system by the way ?

-- 
					    Gilles.

