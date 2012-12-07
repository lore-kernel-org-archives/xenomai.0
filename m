MIME-Version: 1.0
In-Reply-To: <50C1AC2A.70602@xenomai.org>
References: <CANKLDmvSr6j-=6T-YGCG8byGsZ6oy_7sTmcknL7YC8uk9ymTrQ@mail.gmail.com>
	<CANKLDmvhj_sbQnLgmWSo6QsOnrB1CnJcpvg0DRbnW+X93bozbQ@mail.gmail.com>
	<CANKLDms4gtzdTngtENm4aJrh_aXN5283yNLi-NuY9SCuNPgoLQ@mail.gmail.com>
	<CANKLDmtYfN_P-wROiVNU5BZj71K0r98FG32g+5R8Z4R=8ng6cQ@mail.gmail.com>
	<CANKLDmuGztuXdm8F=OjXkmXtejmu0kfx_r7msYxgiRWsAKnW6Q@mail.gmail.com>
	<50C0E337.2020907@xenomai.org>
	<CANKLDmtqsoX4---HGumHbMhzGWgaq5P1VwVbzNkasDxjXS9wrg@mail.gmail.com>
	<50C1A9A5.4040209@siemens.com> <50C1AC2A.70602@xenomai.org>
Date: Fri, 7 Dec 2012 12:56:46 +0100
Message-ID: <CANKLDmtKduhA9cHv91PMswtKCG2xZ9ACT_jS8FZ4yGA45ScyGA@mail.gmail.com>
From: Henri Roosen <henriroosen@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Strange behavior calling certain libraries from
 non-realtime shadow task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Dec 7, 2012 at 9:43 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On 12/07/2012 09:32 AM, Jan Kiszka wrote:
>
>> On 2012-12-07 09:18, Henri Roosen wrote:
>>
>>> On Thu, Dec 6, 2012 at 7:25 PM, Gilles Chanteperdrix <
>>> gilles.chanteperdrix@xenomai.**org <gilles.chanteperdrix@xenomai.org>
>>> <mailto:gilles.**chanteperdrix@xenomai.org<gilles.chanteperdrix@xenomai.org>>>
>>> wrote:
>>> On 12/06/2012 05:35 PM, Henri Roosen wrote:
>>>
>>>  On Thu, Dec 6, 2012 at 12:23 PM, Henri Roosen <henriroosen@gmail.com
>>>> <mailto:**henriroosen@gmail.com <henriroosen@gmail.com>>> wrote:
>>>>
>>>>  On Wed, Dec 5, 2012 at 6:08 PM, Henri Roosen <henriroosen@gmail.com
>>>>> <mailto:**henriroosen@gmail.com <henriroosen@gmail.com>>>wrote:
>>>>>
>>>>>  On Wed, Dec 5, 2012 at 12:42 PM, Henri Roosen <henriroosen@gmail.com
>>>>>> <mailto:**henriroosen@gmail.com <henriroosen@gmail.com>>>wrote:
>>>>>>
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On Tue, Dec 4, 2012 at 5:53 PM, Henri Roosen <henriroosen@gmail.com
>>>>>>> <mailto:**henriroosen@gmail.com <henriroosen@gmail.com>>>wrote:
>>>>>>>
>>>>>>>  Hi,
>>>>>>>>
>>>>>>>> I have a task that is using the libvlc (v2.0.4) library to play some
>>>>>>>> media streams. This all works when it is a normal posix task. When
>>>>>>>> the task
>>>>>>>> is a non-realtime shadow task (prio 0, autorelax), then the shared
>>>>>>>> libraries that libvlc loads (its plugins, codecs etc) get corrupted
>>>>>>>> on
>>>>>>>> disk. A second run of the program is not working.
>>>>>>>>
>>>>>>>>
>>>>>>> The files get corrupted when they are loaded with a dlopen() call.
>>>>>>> Is a dlopen() call allowed from a shadowed non-realtime task? Or what
>>>>>>> can cause the loaded library to get corrupted at this point?
>>>>>>>
>>>>>>> Traced this problem a little further. We found out the problem was
>>>>>>> easy
>>>>>>>
>>>>>> to reproduce running the testcode below. An md5sum on the
>>>>>> file /usr/lib/libavutil.so.50 before and after calling the application
>>>>>> shows the md5 of this file changed.
>>>>>>
>>>>>> Debugging into dlopen() was not easy, but it looked like the file
>>>>>> changed
>>>>>> somewhere around were the file was mapped to memory.
>>>>>>
>>>>>> In parallel we found out the problem was not reproducable on our
>>>>>> "next"
>>>>>> development status which uses xenomai-2.6.1+ and kernel 3.4.6. A step
>>>>>> by
>>>>>> step upgrade of the platform showed that the problem disappeared after
>>>>>> upgrading the kernel form 2.6.38.8 (ipipe-2.6.38.8-x86-2.11-02) to
>>>>>> 3.4.6
>>>>>> (git 0bd76072135271ad58e7bea559acb5**24ab8c7dfe).
>>>>>>
>>>>>> Now I would like to find out if this behavior is fix with a newer
>>>>>> kernel
>>>>>> or whether it is hidden.
>>>>>> Does anyone on the list have any input on this?
>>>>>>
>>>>>>
>>>>>>  We thought that by spawning a normal pthread that does the dlopen()
>>>>> call,
>>>>> the problem would disappear, but unfortunately that is not the case.
>>>>> The
>>>>> problem can still be reproduced when then maintask is shadowed. Without
>>>>> shadowing the main task there is no problem.
>>>>>
>>>>> Anyone an idea how to debug this?
>>>>>
>>>>> I have been debugging this a little further. In libc, the dlopen() call
>>>>>
>>>> maps the file, changes the __mprotect of the code segment to writable to
>>>> put in addresses. In case the main thread has been shadowed, then these
>>>> changes are written through to the file, while when the mainthread is
>>>> not
>>>> shadowed, the addresses are changed only in memory, but not written
>>>> back to
>>>> the file.
>>>>
>>>> I'm not sure whether the file is mapped wrong or the mprotect is doing
>>>> incorrect things. I will now debug into the kernel to find out.
>>>>
>>>> Searching through Xenomai commits I found there is a configure option
>>>> --enable-dlopen-skins. This option is not set in my configuration as I
>>>> am
>>>> under the impression that it should only be enabled when dynamically
>>>> loading a _skin_ using dlopen(). Can some confirm this impression is
>>>> correct and I don't need to set this option?
>>>>
>>>
>>>
>>> Please try reverting this patch:
>>> http://git.denx.de/ipipe.git/?**p=ipipe.git;a=commit;h=**
>>> 641d8e87531c6367a6357335378194**ea06a23701<http://git.denx.de/ipipe.git/?p=ipipe.git;a=commit;h=641d8e87531c6367a6357335378194ea06a23701>
>>>
>>> Thanks Gilles! This looks like the patch that is introducing the
>>> problem; when reverted I cannot reproduce the library corruption.
>>>
>>> Now, wondering why core-3.2 didn't show the problem, I noticed commit
>>> c9f834f80257c4e7c2c01a3c6d34f5**485af2be51 which is missing in the
>>> ipipe for 2.6.38.8. I will test to add this patch instead of reverting the
>>> other one.
>>> I'll put Jan on the copy list. Maybe he can shine a light on this and
>>> advice.
>>>
>>
>> Yes, those patches (the one before it as well) were never merged into
>> 2.6-ipipe, but they will fix the issues. If 3.6.38 is still maintained,
>> I can send a pull request, including also some unrelated fix I recently
>> developed.
>>
>
I've cherry-pick'ed both c9f834f802 and 0897122198 for
ipipe-2.6.38.8-x86-2.11-02 and can confirm it works; no more corrupting the
library's.

Thanks!


>>
> Please do, I'll close 2.6.38 on this changeset. I'm about to roll out a
> new set of 3.4 patches, now that the ARM stuff is merged. So if you have
> anything pending for this branch, please push this too.
>
> TIA,
>
>
> --
> Philippe.
>
