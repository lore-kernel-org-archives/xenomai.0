References: <cover.1535375976.git.henning.schild@siemens.com>
 <8861ff377012947ab2239066c864253975ea5bad.1535375976.git.henning.schild@siemens.com>
 <14df678f-9f1c-8588-4c73-5f64b010f0b9@siemens.com>
 <20180827183230.415539ea@md1pvb1c.ad001.siemens.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8225cae2-10f3-95d9-2e20-8405122556e8@siemens.com>
Date: Mon, 27 Aug 2018 18:41:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180827183230.415539ea@md1pvb1c.ad001.siemens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 2/3] cobalt/x86: add ipipe-4.4 eager fpu
 support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 2018-08-27 18:32, Henning Schild wrote:
> Am Mon, 27 Aug 2018 18:18:01 +0200
> schrieb Jan Kiszka <jan.kiszka@siemens.com>:
> 
>> On 2018-08-27 15:28, Henning Schild wrote:
>>> Signed-off-by: Henning Schild <henning.schild@siemens.com>
>>> ---
>>>    kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h
>>> b/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h index
>>> 73df60cc6..0156e86f0 100644 ---
>>> a/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h +++
>>> b/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h @@ -29,6
>>> +29,12 @@ LINUX_VERSION_CODE > KERNEL_VERSION(4,9,108)
>>>    #define IPIPE_X86_FPU_EAGER
>>>    #endif
>>> +// actually 4.4.138 drops lazy, but in IPIPE we do it at 72
>>
>> Huh? We also do lazy up to 4.4.137, at least in x86 staging (latest
>> release was .71, indeed). But nothing has been removed from that old
>> version to prevent laziness.
> 
> The idea of these numbers is to make them work right after a
> (small) merge has been done on the kernel side. ipipe-4.4.y is at 71 so
> i chose 72, because we can switch to eager before we have to.
> 
> In fact i do not care but that was the easiest for testing, because it
> allowed testing without dealing with what happened between 71 and 152.
> I started off with that (big) merge and when conflicts came up i decided
> to devide the problem.
> 
> What we could do to stay in line with 4.9 is merge in the minor right
> before the upstream change (137), apply the patch with the exact number
> (138), and possibly merge 152 after that. But hey we can go eager
> whenever we want ... So i prefer the current way. Go eager in 72 and
> later merge 152+.
> 
> Where is that staging branch you are talking about?

https://gitlab.denx.de/Xenomai/ipipe-x86/tree/for-upstream/4.4

ipipe-x86/ipipe-4.4.y is just the mirror of upstream, thus will only 
start to carry that changes when upstream picked them up. I think I 
didn't send a PR so far, though.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

