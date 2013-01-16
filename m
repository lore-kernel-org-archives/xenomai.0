Message-ID: <50F662A8.9080904@xenomai.org>
Date: Wed, 16 Jan 2013 09:19:52 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <D9F55F45-EC38-45B2-A922-08F24868BA87@mah.priv.at>	<50F3F296.5000008@xenomai.org>	<3F8DFF0B-6F81-48E1-9D64-83B08DA6A599@mah.priv.at>	<50F41136.3070200@xenomai.org>
	<50F64ED2.7060503@zultron.com> <50F66131.2000903@siemens.com>
In-Reply-To: <50F66131.2000903@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] universal application binary: how to auto-detect
 Xenomai/RT-PREEMPT/vanilla kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: John Morris <john@zultron.com>, xenomai@xenomai.org

On 01/16/2013 09:13 AM, Jan Kiszka wrote:

> On 2013-01-16 07:55, John Morris wrote:
>> On 01/14/2013 08:07 AM, Philippe Gerum wrote:
>>> On 01/14/2013 01:05 PM, Michael Haberler wrote:
>>>> Is there any chance somebody runs Xenomai AND RT_PREEMPT patches
>>>> applied? I heard a rumor but havent actually seen that
>>>
>>> Yes, this works. The current target is ppc 85xx, but I don't see any
>>>  showstopper for running such combo on other archs, provided the
>>> I-pipe patch is adapted to a -rt kernel. This requires Xenomai
>>> 2.6.1+, stock.
>>
>> Comparing the xenomai-2.6.2 x86/patches directory and
>> http://www.kernel.org/pub/linux/kernel/projects/rt, it appears there's a
>> common kernel version in 3.2.21.
>>
>> I'm preparing RPM packages for 3.5 because I assume that's where most
>> development and bug fixing is going on, and because I hope the work will
>> be useful beyond the LinuxCNC community.  Unfortunately, RT_PREEMPT
>> seems to skip linux 3.5 entirely, jumping from 3.4 to 3.6.
> 
> I-pipe also jumps, and now happened to land on 3.5 with its latest fixes
> and features. When we jump the next time, we should probably pick 3.8 as
> target for that reason. I may look into this soon. But I'm also
> considering to backport recent work to 3.4 (for x86 targets at least).


I may jump to 3.6, at least for the ARM architecture. As for the
backports to 3.4, I still intend to re-release 2.6.2, so, it would be
nice to backport the bugfixes in the core-3.5 branch to the core-3.4 branch.

-- 
                                                                Gilles.

