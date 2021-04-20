References: <20210416053133.23412-1-hongzhan.chen@intel.com>
 <20210416053133.23412-4-hongzhan.chen@intel.com>
 <17adb9ac-7510-f1f6-9805-67ef8353b536@siemens.com>
 <DM5PR11MB1852339EA17CEADCE2D3DB25F2489@DM5PR11MB1852.namprd11.prod.outlook.com>
 <da74b515-3982-1827-8b77-2ec3977aecea@siemens.com>
 <DM5PR11MB1852A989610602EE30EA5E05F2489@DM5PR11MB1852.namprd11.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH V2 3/3] testsuite/latmus: introduce latmus benchmark
In-reply-to: <DM5PR11MB1852A989610602EE30EA5E05F2489@DM5PR11MB1852.namprd11.prod.outlook.com>
Date: Tue, 20 Apr 2021 10:27:08 +0200
Message-ID: <87bla95pk3.fsf@xenomai.org>
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
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org


Chen, Hongzhan via Xenomai <xenomai@xenomai.org> writes:

>>-----Original Message-----
>>From: Jan Kiszka <jan.kiszka@siemens.com> 
>>Sent: Tuesday, April 20, 2021 2:48 PM
>>To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
>>Subject: Re: [PATCH V2 3/3] testsuite/latmus: introduce latmus benchmark
>>
>>On 20.04.21 03:02, Chen, Hongzhan wrote:
>>> 
>>> 
>>>> -----Original Message-----
>>>> From: Jan Kiszka <jan.kiszka@siemens.com> 
>>>> Sent: Friday, April 16, 2021 8:05 PM
>>>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
>>>> Subject: Re: [PATCH V2 3/3] testsuite/latmus: introduce latmus benchmark
>>>>
>>>> On 16.04.21 07:31, hongzha1 via Xenomai wrote:
>>>>> Measure response time to GPIO events sent by a remote Zephyr-based
>>>>> latency monitor (latmon). This monitor collects then sends the latency
>>>>> data over a network connection to the latmus front-end which displays
>>>>> the results received:
>>>>>
>>>>> [Linux device under test running latmus]  <--+
>>>>>                                              |
>>>>>         ^                 | (GPIO ack)       |
>>>>>         |                 |                  |  TCP/IP network connection
>>>>>         |                 |                  |  (control & data samples)
>>>>>         | (GPIO pulse)    v                  |
>>>>>                                              |
>>>>> [Zephyr-based device running latmon]      <--+
>>>>>
>>>>> The generic latency monitor code running the measurement loop is
>>>>> available from the zephyr/ directory. This support comes with a Zephyr
>>>>> device tree patch for enabling this monitor on NXP's FRDM-K64F
>>>>> development board.
>>>>
>>>> Where is all this?
>>> 
>>> Actually , this zephyr directory is located in libevl project  at https://git.evlproject.org/libevl.git/tree/benchmarks/zephyr.  
>>> at this time. Do you think it is suitable to make a copy for this folder in xenomai code base? Or I just described in comments
>>> that it is from https://git.evlproject.org/libevl.git/tree/benchmarks/zephyr .
>>> 
>>
>>It's fine to link that. But, again, this needs to go into proper in-tree
>>documentation.
>
> Could you be more specific about documentation that I need to do? Currently
> I need to add ./doc/asciidoc/man1/latmus.adoc as you mentioned to tell how to 
> use latmus app on Xenomai side. But actually it is more complicated than just
> using latmus on xenomai side as described in  [1]
> to get latmus gpio latency. Do I need to cover all [1]'s contents in
> ./doc/asciidoc/man1/latmus.adoc?
>
> [1]: https://evlproject.org/core/benchmarks/

I believe Jan is referring to gathering all the bits required to run
latmus on top of Cobalt, including the Zephyr code, along with the doc.

This is part of a larger effort to have Xenomai 3 and EVL share common
bits and co-exist under the umbrella of the Xenomai project, as the
latter will become Xenomai 4 eventually.

As announced during several Community Meetings over the past months,
moving the EVL development infrastructure from git.evlproject.org to
git.xenomai.org (as xenomai4) is going to happen this month, I've been
doing some prep work on the EVL side for this lately. Problem #1 ATM
concerns the current EVL documentation at [1], which is composed of a
set of Markdown-formatted files, which is rendered by the hugo [2]
static generator, depending on several of its short-codes.

Regarding the Zephyr code, we could have a separate repo for it both
Xenomai 3 & 4 would share as a common git module for instance.

For the time being, the best course of action may be that your
latmus-over-Cobalt code sits into my tree, where it can wait for the
rest of the Cobalt-over-Dovetail code it depends on to be merged
upstream. The documentation and latmon issues can be solved in parallel
while Xenomai 4 emerges at git.xenomai.org. IOW, I will be picking this
patch series, it does not belong to upstream/next yet.

[1] https://evlproject.org
[2] https://gohugo.io

-- 
Philippe.

