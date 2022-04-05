Message-ID: <498375c5-740c-23c5-0570-cf9b6b91e957@siemens.com>
Date: Tue, 5 Apr 2022 17:29:48 +0200
MIME-Version: 1.0
Subject: Re: Machine freezes under Ubuntu 20.04
Content-Language: en-US
References: <CAMMcbao60ib7YVUDsD5FD=J7aTCzsTAsG3ggUc7vXPHvbvd5uw@mail.gmail.com>
 <8e029de8-dac5-5788-c28b-1d20736ef494@siemens.com>
 <CAMMcbaoNMZWSk=UED8cCk=ToPFPeNq3Abx=KwCyPhL9Zbx9CYQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAMMcbaoNMZWSk=UED8cCk=ToPFPeNq3Abx=KwCyPhL9Zbx9CYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Arturo Laurenzi <arturo.laurenzi@gmail.com>
Cc: xenomai@xenomai.org

On 05.04.22 15:43, Arturo Laurenzi wrote:
>> On 04.04.22 15:21, Arturo Laurenzi via Xenomai wrote:
> 
>>>
>>> Recently, we have started a transition towards Ubuntu 20.04, and things
>>> have started to break.
>>>
>>> The first attempt was to install kernel 5.4.151 and stick to ipipe. Under
>>> this setup, we experience issues even before starting our applications. We
>>> have seen random crashes while compiling with GCC, sporadic "System Program
>>> Problem Detected" popups by Ubuntu, and others. We even tried to re-install
>>> OS and kernel from scratch with no luck.
>>
>> A reference setup for this kernel line can be found in xenomai-images
>> (https://source.denx.de/Xenomai/xenomai-images). Would be good to
>> understand which deviation from it makes the difference for which
>> component (see also further questions below).
> 
> I'm attaching the config we're using (from /boot/config-$(uname -r)).
> If that makes sense, we're going to try to configure the kernel
> according to this file
> (https://source.denx.de/Xenomai/xenomai-images/-/blob/master/recipes-kernel/linux/files/amd64_defconfig).
> What kernel version do you recommend to try?
> 

Always the latest of the individual kernel series.

>>>
>>> The second attempt was to stick to our old kernel 4.19.140. All the weird
>>> issues disappear and the system is stable. However, we are unable to have
>>> the system pass our suite of "stress tests", which basically involve starting,
>>> running, and killing process B multiple times in a cyclic fashion, while
>>> process A runs in the background. After a short while (minutes), the whole
>>> system just hangs, forcing us to do an hard reset. Only once, we managed to
>>> get this kernel oops after rebooting (journalctl -k -b -1 --no-pager).
>>>
>>
>> For reliably recording crashes, it is highly recommended to use a UART
>> as kernel debug output.
> 
> Will do ASAP and let you know.
> 
>>> The third attempt was to try out kernel 5.10.89 plus the new dovetail
>>> patch, and Xenomai v3.2.1. Again, all the weird issues are gone and the
>>> system is stable. However, we are unable to have the system pass our suite
>>> of "stress tests". Differently from 4.19-ipipe, the system resists for a
>>> longer time before hanging (few hours sometimes), but this also varies a
>>> lot.
>>>
>>> After some more investigation, we found out something interesting. By
>>> removing the code that interacts with Process A, Process B is then able to
>>> run "forever" (overnight at least), but *only if Process A is not running*.
>>> Otherwise, the system will hang. In other words, the mere presence of
>>> Process A is affecting Process B, even though both IDDP and ZMQ have been
>>> removed from B and replaced with fake data. Furthermore, the system does
>>> not freeze if we set B1's scheduling policy to SCHED_OTHER.
>>
>> Do you have the Xenomai watchdog enabled, thus will you be able to tell
>> RT application "hangs" (infinite loop at high prio) apart from real
>> hangs/crashes?
> 
> Yes. When we try a while(true) inside a RT context, we see the
> watchdog killing our application
> as expected.
> 
> 
>>>
>>> From these - rather heuristic - tests, it looks like there could be some
>>> coupling between unrelated processes which causes some sort of bug, that is
>>> probably related to some interaction with mutexes/condvars, when these are
>>> used from a RT context. This issue shows up (or at least we have seen it)
>>> only under Ubuntu 20.04 (GCC 9.x), whereas a 18.04 build (GCC 7.x) looks
>>> fine.
>>
>> Ubuntu toolchains are known for agressively enabling certain security
>> features. Maybe one that we didn't check yet flipped between 18.04 and
>> 20.04 - if that switch is only difference between working and
>> non-working builds in your case. GCC itself should be fine, we are
>> testing with gcc-10 via Debian 11 in our CI.
>>
>> Can you check whether the toolchain change breaks the kernel (kernel
>> with old toolchain runs fine with userspace built via new toolchain)?
> 
> We have tried this, and still the system freezes after a while. We
> followed the procedure that follows:
>  1) generate binaries for our "working" kernel 4.19.140-xeno-ipipe-3.1
> on a Ubuntu 18 machine (make deb-pkg)
>  2) copy the whole /usr/xenomai directory (compiled with the 18.04
> toolchain) to the test machine with Ubuntu 20.04
>  3) install the kernel binaries to the test machine
>  4) re-compile our application
> Is this ok?
> 

Wait, these are three variables: kernel, Xenomai application and Ubuntu
userspace. Does your system also break when using both kernel and
application binaries from a Ubuntu 18 build? Or will it start to break
once you recompile the Xenomai application with Ubuntu 20 toolchain?

>>>
>>> The purpose of this message is twofold.
>>> First, to see if these symptoms might "ring a bell" to anyone in the
>>> community, who might be able to suggest a fix.
>>> Second, we'd like to ask what you would do to debug this issue. Which tool
>>> could we use to trace what's going on, considering that whatever the bug
>>> is, it leads to a state where the machine is not usable at all. We can
>>> share our .config files if required, and we are willing to test more
>>> combinations of kernel and xenomai patch or library versions upon your
>>> advice. Any help you can give us is greatly appreciated.
>>>
>>
>> Can you simplify your test case to a level that makes it sharable,
>> executable by third parties? Please also share your kernel .config.
> 
> Will try. It's not going to be quick though, as any trial we make
> needs hours of testing to understand if it causes a system freeze.
> 
> What is the recommended to trace/debug this kind of problems? Is there
> anything "fancier" than broadcasting kernel output over a serial port?
> 

Hard to say in general. Full system freezes can be tricky to debug
unless there are at least some hints provided by the kernel. That's why
the focus is first on validating that.

If you want it fancier: In the past, we used kgdb on real hardware as
well, but that wasn't tried in a while. More reliable to debug -
provided the issue is reproducible then - is moving everything into a
KVM machine and debugging the guest from the host once it locked up.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

