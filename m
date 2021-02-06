References: <874kixxf9e.fsf@xenomai.org>
 <f850676b-a67f-442e-4642-0b8791162236@siemens.com>
 <87k0rprr5a.fsf@xenomai.org>
 <46e13cc0-6f1c-65f3-34cc-4a6ea44d00d8@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [Dovetail] x86 test version available (kernel v5.10)
In-reply-to: <46e13cc0-6f1c-65f3-34cc-4a6ea44d00d8@siemens.com>
Date: Sat, 06 Feb 2021 18:23:20 +0100
Message-ID: <875z35qfef.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org, hongzha1 <hongzhan.chen@intel.com>


Jan Kiszka <jan.kiszka@siemens.com> writes:

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

I'll pick the trace-related fixes in my queue.

> Specifically
> https://gitlab.denx.de/Xenomai/xenomai/-/commit/4196216e821abea3107284a8e31e13bdf05141d5
> would a second look as the timer ipi abstraction became obsolete with
> the code moving to pipeline-specific code.
>

Yes, moving this to the pipeline-specific section, so that we reduce the
level of visual clutter in the generic code.

> I've just started also target runs, see
> https://gitlab.denx.de/Xenomai/xenomai-images/-/pipelines/6263. There
> will be several known breakages, though, namely the gdb test but also
> the unrelated arm[64]-5.4 regressions.
>

I'm fixing the RTnet build issues ATM.

-- 
Philippe.

