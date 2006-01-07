Message-ID: <43C00542.9070403@domain.hid>
Date: Sat, 07 Jan 2006 19:15:30 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <43BFB26F.8020409@domain.hid> <43BFF568.2030804@domain.hid>
	<43BFF69C.4040705@domain.hid> <43BFF919.60706@domain.hid>
	<43C00044.7000109@domain.hid>
In-Reply-To: <43C00044.7000109@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [PATCH] move RTDM headers
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>Jan Kiszka wrote:
>>
>>
>>>Philippe Gerum wrote:
>>>
>>>
>>>>Jan Kiszka wrote:
>>>>
>>>>
>>>>
>>>>>Hi Philippe,
>>>>>
>>>>>this patches cleans up the include/rtdm folder by moving internal
>>>>>headers to ksrc/skins/rtdm, leaving only rtdm.h, rtdm_driver.h, the two
>>>>>profile headers, and syscall.h there. The latter is still only needed
>>>>>for building Xenomai itself, thus it will not be installed.
>>>>>Successfully
>>>>>built for 2.4 and 2.6. Additionally, I compiled latest RTnet SVN
>>>>>against
>>>>>it without problems (x86, PPC is currently being fixed by Wolfgang).
>>>>>
>>>>>Please apply/move the involved headers and run bootstrap.
>>>>>
>>>>
>>>>This one broke the build here:
>>>>
>>>>-- 
>>>> CC      kernel/xenomai/skins/rtdm/core.o
>>>>kernel/xenomai/skins/rtdm/core.c:36:18: core.h: No such file or
>>>>directory
>>>>kernel/xenomai/skins/rtdm/core.c:37:20: device.h: No such file or
>>>>directory
>>>>-- 
>>>
>>>
>>>
>>>Updated your repos? As you forgot to apply the moving, I also got
>>>problems and applied my local versions of core.h, device.h, and proc.h,
>>>also removing the three from their previous location.
>>>
>>
>>The problem is that the patch does not recreate those files in
>>ksrc/skin/rtdm, but only deletes them from include/rtdm.
>>
> 
> 
> Oops, indeed. I was sure "svn diff" will include locally added files in
> the output, but it didn't -- ah, my svn version is too old! :)
> 
> 
>>>>Additionally, it's a really very bad idea to start including things like
>>>>"core.h" removing the rtdm/ prefix, while other include files like
>>>>nucleus/core.h exist. For the sake of readability, I'm going to revert
>>>>this particular change at least.
>>>>
>>>
>>>
>>>That's why I use #include "core.h", which -for me- clearly states: "Pick
>>>the local one!"
>>
>>
>>Nope, it "states pick the first one you find outside of the system dirs
>>depending on the order of the directories listed by -I in your
>>Makefile", which is quite different, and leads to all sort of
>>braindamage issues if you happen to screw up your CFLAGS in your Makefile.
> 
> 
> #include "file.h" -> start searching for file.h in that place you found
> the file containing this statement. Likely one can overwrite this
> behaviour with some strange gcc flags.
>

-I- for instance, which bluntly cancels the above behaviour. One 
sometimes may have to make extensive use of it to work around funky 
include directory layouts some applications have; early versions of the 
simulator had even needed this to somewhat control which portion of the 
"include space" was picked.

> 
>> You will now have to tweak the Makefiles again...
>>
>>
>>That's ok, I will do that. The prefix rule is enforced everywhere for
>>internal headers so that nobody gets mad trying to find why the wrong
>>one is included, and the best way not to depend on "-I" pecularities is
>>to avoid playing with them in the first place. Additionally, this leaves
>>no doubt about which header you wanted to include, regardless of the
>>sanity of your Makefile.
> 
> 
> Ok, it's a matter of taste, and if you like to keep it this way for all
> skins, I'm fine with it.
> 
> Jan


-- 

Philippe.

