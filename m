Message-ID: <4E09D243.4050706@domain.hid>
Date: Tue, 28 Jun 2011 15:08:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTi=2WnfLFC9DVQY81obGPO6_CG_PCA@mail.gmail.com>	<4E086122.7060405@domain.hid>
	<BANLkTimCab2u0EOrJ6JtLTVLNAzktbvFQg@domain.hid>
In-Reply-To: <BANLkTimCab2u0EOrJ6JtLTVLNAzktbvFQg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Program hangs using "rt_task_sleep" in a
 particular way
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Adrien LEMAITRE <adrien.lemaitre@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 06/28/2011 02:20 PM, Adrien LEMAITRE wrote:
> 2011/6/27 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> 
>> On 06/27/2011 08:31 AM, Adrien LEMAITRE wrote:
>>> Hello,
>>>
>>> I raise a problem encountered and always present. Before on this
>> configuration
>>> :
>>>
>>> - linux kernel : 2.6.29.6
>>> - adeos patch : adeos-ipipe-2.6.29-arm-1.13-00.patch
>>> - xenomai : 2.4.8
>>> - host linux distribution : ubuntu 10.04 (64 bits)
>>> - compiler : gcc 4.2.1 (buildroot's generated toolchain)
>>>
>>> And it is always present with this configuration :
>>>
>>> - Linux kernel : 2.6.37
>>> - Adeos patch : adeos-ipipe-2.6.37-x86-2.9-00.patch
>>> - Xenomai : 2.5.6
>>> - Host Linux distribution : Ubuntu 10.04
>>> - Compiler : gcc-4.4.3
>>>
>>> Configuration of kernel:
>>>
>>> I used the default configuration of Ubunut 10.04 and i change this:
>>> In "Power management and ACPI options" :
>>> - deactivate ACPI
>>
>> This is a bad idea. Only ACPI_PROCESSOR is problematic. See:
>> http://www.xenomai.org/index.php/Configuring_x86_kernels
>>
>>> - deactivate CPU idle PM support
>>> In "Device drivers/Input device support/Miscelaneous devices":
>>> - deactivate PC Speaker support
>>> In "Processor type and features":
>>
>> You should only need this if you have mis-configured your kernel. Again,
>> see the "Processor type" paragraph in the Configuring_x86_kernels page.
>>
> 
> I applied these changes. In fact, i used the default configuration kernel
> and i changed only the processor family. But I must desactivate  "Enable
> -fstack-protector buffer overflow detection (EXPERIMENTAL)" otherwise i have
> an error during the compilation.
> But the problem is still here.
> 
> 
>>  > - deactivate HPET_TIMER
>>> - deactivate Enable -fstack-protector buffer overflow detection
>>> (EXPERIMENTAL)
>>>
>>>
>>> We encounter a problem in a particular situation. In the attached
>>> source, when we change the value passed to rt_task_sleep (line 36), the
>>> program never returns.
>>>
>>> This appears only with values greater or equal to 100000 (and maybe some
>>> other values between 10000 and 100000) and only when we use
>>> rt_task_sleep between the two rt_task_spawn calls.
>>>
>>> Is there something we've done wrong ? A problem with the kernel
>>> configuration? Or a bug of Xenomai ?
>>
>> The real-time task are using 100% cpu time. You can not do that. A
>> real-time task should suspend from time to time and let non real-time
>> activities run.
>>
> 
> I am supprised by this answer, we are supposed to think that real-time tasks
> are before others tasks. And we made attention at used only functions in
> real-time. And why this problem is only when value of rt_task_sleep is
> greater or equal to 100000? the master tasker was supposed to take his turn
> after, didn't it? And I don't understand why in a case no problems and in  a
> other case the program never finishes.
> 
> Is it a problem with preemption of kernel?

The problem is that the "rt_task_spawn" service causes its caller to
switch to secondary mode. This means, that the task is no longer real-time.
If you do not have root priority coupling enabled, this means that the
thread just created will have priority as long as it does not suspend.

Normally, root thread priority coupling should allow to avoid that.
Unfortunately, there is a small hole in this functionality which make it
not work in some conditions (and fixing this hole would introduce a
possibility of priority inversion).

As for the influence of the length of the call to rt_task_sleep, a short
rt_task_sleep will cause the "go" task to switch to primary mode and
preempt the task "WorkingTask1" before it is completely started.

Nevertheless, now that I give you the probable explanation, I have some
doubts and will run your test case to confirm this explanation.

Nevertheless(2), xenomai needs linux to run in order to work correctly,
so, the real-time tasks should always suspend to let linux run. I bet if
you put an rt_task_sleep in WorkingTask1 and WorkingTask2 loop, the test
will no longer hang.

Please no private mails.

-- 
					    Gilles.

