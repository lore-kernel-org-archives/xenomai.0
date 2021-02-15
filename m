Subject: Re: [Dovetail] x86 test version available (kernel v5.10)
References: <874kixxf9e.fsf@xenomai.org>
 <f850676b-a67f-442e-4642-0b8791162236@siemens.com>
 <87k0rprr5a.fsf@xenomai.org>
 <46e13cc0-6f1c-65f3-34cc-4a6ea44d00d8@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <aab28877-6309-edb3-45dc-b9d504451fc9@siemens.com>
Date: Mon, 15 Feb 2021 14:28:30 +0100
MIME-Version: 1.0
In-Reply-To: <46e13cc0-6f1c-65f3-34cc-4a6ea44d00d8@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 06.02.21 13:29, Jan Kiszka via Xenomai wrote:
> On 03.02.21 18:35, Philippe Gerum wrote:
>>
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>
>>> On 31.01.21 17:06, Philippe Gerum wrote:
>>>>
>>>> The initial port of the Cobalt core to Dovetail/x86 is available from
>>>> [1]. Ports to Dovetail/ARM and Dovetail/arm64 should follow within a
>>>> couple of weeks.
>>>>
>>>> So far, latency and switchtest run flawlessly. Most of the smokey test
>>>> suite passes successfully, except the GDB test at the moment.
>>>>
>>>> How to test this:
>>>>
>>>> - clone Xenomai from [1], switch to branch for-upstream/dovetail
>>>> - clone the Dovetail tree (v5.10) from [2], switch to branch dovetail/master
>>>> - run scripts/prepare-kernel.sh available from [1] into [2] (usual procedure)
>>>>   for x86, that would be: .../scripts/prepare-kernel.sh --arch=x86
>>>> - build your kernel using the sources from [2]
>>>>
>>>> There is no user-visible Kconfig change compared to an I-pipe based
>>>> version.
>>>>
>>>> Alternatively, the Xenomai code base in [1] can also run on top of the
>>>> I-pipe. prepare-kernel.sh detects which pipeline flavour is there, and
>>>> prepares the source tree accordingly.
>>>>
>>>> This code is being gradually merged into Xenomai's -next branch, and
>>>> will be at the core of Xenomai 3.2. Testing and feedback appreciated.
>>>>
>>>> Thanks,
>>>>
>>>> [1] https://lab.xenomai.org/xenomai-rpm.git, "for-upstream/dovetail" branch
>>>> [2] https://git.evlproject.org/linux-evl.git, "dovetail/master" branch
>>>>
>>>
>>> First try on my end looked good as well - great news, well done!
>>>
>>> Would it help to stick the wip branch into our CI/CT?
>>>
>>
>> Yep, it would. TIA,
>>
> 
> CI build is passing now, see
> 
> https://gitlab.denx.de/Xenomai/xenomai/-/pipelines/6258
> 
> I'm carrying two fixes and a could of tweaks:
> 
> https://gitlab.denx.de/Xenomai/xenomai/-/commits/wip/dovetail
> 
> Specifically
> https://gitlab.denx.de/Xenomai/xenomai/-/commit/4196216e821abea3107284a8e31e13bdf05141d5
> would a second look as the timer ipi abstraction became obsolete with
> the code moving to pipeline-specific code.
> 
> I've just started also target runs, see
> https://gitlab.denx.de/Xenomai/xenomai-images/-/pipelines/6263. There
> will be several known breakages, though, namely the gdb test but also
> the unrelated arm[64]-5.4 regressions.
> 

I think I (widely) understood the issue on x86 qemu:

posix-clock.c:285, assertion failed: diff >= 5500000000LL && diff <=
6500000000LL
/usr/lib/xenomai/testsuite/smokey: test posix_clock failed: Invalid argument

It should have been visible on a real machine as well - as long as
systemd-timesyncd is running. Stopping that service makes the test work.

As we are now sharing CLOCK_REALTIME with Linux, any ongoing tweak of
the system time by ntp and similar services will defeat our temporal
set-back in smokey's test case. We can address that in xenomai-images,
but I'm unsure how to resolve that more generically for smokey. Any ideas?

Now the next issue is

/usr/lib/xenomai/testsuite/smokey: test sched_quota failed: Protocol error
sched-quota.c:332, out of quota: 13.7%
(on a real target, an Atom-class box).

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

