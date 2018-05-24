From: Jan Kiszka <jan.kiszka@siemens.com>
References: <freemail.20180524135633.61226.1@fmxmldata03.freemail.hu>
 <a4df1809-1bf2-5e56-7234-a6b47d9ad950@siemens.com>
Message-ID: <ed2939b9-1410-f562-fe2b-680d8ef1f616@siemens.com>
Date: Thu, 24 May 2018 16:20:25 +0200
MIME-Version: 1.0
In-Reply-To: <a4df1809-1bf2-5e56-7234-a6b47d9ad950@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Posix named semaphore used by two separate
	applications
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paal Tamas <paal_to@freemail.hu>, Xenomai <xenomai@xenomai.org>

On 2018-05-24 16:18, Jan Kiszka wrote:
> Again, re-adding the list - please always use "reply to all".
> 
> On 2018-05-24 13:56, Paal Tamas wrote:
>>
>>
>> Jan Kiszka <jan.kiszka@siemens.com> írta:
>>> [re-adding the list]
>>>
>>> On 2018-05-24 13:35, Paal Tamas wrote:
>>>>
>>>>
>>>> Jan Kiszka <jan.kiszka@siemens.com> írta:
>>>>> On 2018-05-24 10:50, Paal Tamas wrote:
>>>>>> I would like to use the same named semaphore in two separate Xenomai binaries. I am using the Posix skin. It does not work as I am expecting it. 
>>>>>> The first instance of my test application creates a named semaphore. It goes to sleep after that. The second instance of the same applications starts than. It realizes that the semaphore with the name already exists, so it opens it. The sem_open() returns a valid (like) pointer. After that all semaphore functions in this second application return EINVAL (22) (Invalid argument). Both the sem_wait() and the sem_close() function behave this way.
>>>>>>
>>>>>> The same procedure worked fine in 2.6.2.1 (the previous version I used). I tried 3.0.5 and the latest git repository too. The same bad behavior there.
>>>>>>
>>>>>
>>>>> Did you configure userspace with --enable-pshared?
>>>>>
>>>>
>>>> Yes. I invoked the "configure" script this way:
>>>>
>>>> ./configure --with-core=cobalt --enable-smp --enable-pshared
>>>
>>> OK.
>>>
>>>>
>>>> This is my configuration:
>>>>
>>>> /xeno-config --info
>>>> Xenomai version: Xenomai/cobalt v3.0.6 -- #50ef005 (2018-05-13 16:21:13 +0200)
>>>> Linux clickandmove-NUC 4.9.51xeno #1 SMP Wed May 23 05:14:47 PDT 2018 x86_64 x86_64 x86_64 GNU/Linux
>>>> Kernel parameters: BOOT_IMAGE=/boot/vmlinuz-4.9.51xeno root=UUID=7e90a17b-1ea0-4b84-849f-7d621fe6d580 ro quiet splash vt.handoff=7
>>>> I-pipe release #5 detected
>>>> Cobalt core 3.0.6 detected
>>>> Compiler: gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.5)
>>>> Build args: --with-core=cobalt --enable-smp --enable-pshared
>>>>
>>>> When I tried the git repository I cheated a bit. I could not find the configure script (neither some others) and all the makefile.in files were missing, so I copied these files from the xenomai-3.0.6.tar.bz2. I've never tried the git  repositore before, always used the bz2 file(s). In case of the 3.0.5 version I used the bz2 file for the tests.
>>>
>>> Just run scripts/bootstrap when using a git checkout.
>>
>> Do I need any parameters to the scripts/bootstrap script in this case or I should simply run it?
>>
>>>
>>> To ensure that we are truly hunting a Xenomai issue: Does your testcase
>>> work with plain Linux?
>>>
>>
>> Yes, it works fine under plain Linux. Sorry that I forgot to mention this...
> 
> Confirmed.
> 
> In fact, your test also exposes some cleanup issue: When terminating a
> process, Xenomai does not remove the semaphore, and you need to reboot
> to remove the object.

Correction: This is not a wrong behavior, Linux does the same. The test
code just has no chance to clean up a preexisting sem because of the
other problem (EINVAL).

Jan

> 
> Will look into these problems.
> 
> Jan
> 


