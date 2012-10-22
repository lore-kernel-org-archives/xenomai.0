Message-ID: <50855FFD.90706@xenomai.org>
Date: Mon, 22 Oct 2012 17:02:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAN0CFw3KM6VC-q9QHjoME0AqJOApw_9h4aEP0D2uxeD6rgcGcw@mail.gmail.com>	<50798BD3.6010308@xenomai.org>
	<50798F8A.8060508@xenomai.org>	<CAN0CFw0AhYwkGLQvugxw6NqPtv6mBxxLYnPWsdXXjO25_pmSVQ@mail.gmail.com>	<508171AB.8010707@xenomai.org>	<CAN0CFw3WqabceF1LoR===ZXQU5-WRCfYb_itk0_ig2NKKG9vtg@mail.gmail.com>	<50818781.7050204@xenomai.org>
	<CAN0CFw0ZvkqHO6txvq17xBsU7S52dFW1rn=EC7uz87T95npR9w@mail.gmail.com>
	<50827B74.2030408@xenomai.org> <50829C67.9040909@xenomai.org>
	<50829D93.7000407@xenomai.org> <50829E28.2020801@xenomai.org>
	<50829EC8.1030809@xenomai.org> <5082A25C.4030204@xenomai.org>
	<50854DB4.3080100@xenomai.org> <50855FBE.7020403@xenomai.org>
In-Reply-To: <50855FBE.7020403@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Which kernel versions?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 10/22/2012 05:01 PM, Philippe Gerum wrote:

> On 10/22/2012 03:44 PM, Gilles Chanteperdrix wrote:
>> On 10/20/2012 03:08 PM, Philippe Gerum wrote:
>>
>>> On 10/20/2012 02:53 PM, Gilles Chanteperdrix wrote:
>>>> On 10/20/2012 02:50 PM, Philippe Gerum wrote:
>>>>
>>>>> On 10/20/2012 02:48 PM, Gilles Chanteperdrix wrote:
>>>>>> On 10/20/2012 02:43 PM, Philippe Gerum wrote:
>>>>>>
>>>>>>> On 10/20/2012 12:22 PM, Gilles Chanteperdrix wrote:
>>>>>>>
>>>>>>>> Note that the list is not exhaustive, because it does not includes
>>>>>>>> patches that were published before the i386/x86_64 merge, if you take
>>>>>>>> that into account, you can even run Xenomai 2.6.1 with 2.4 kernels.
>>>>>>>>
>>>>>>>
>>>>>>> 2.4.25/ppc only though. We stopped maintaining 2.4/x86 setups many moons
>>>>>>> ago, so I doubt this would even build.
>>>>>>
>>>>>>
>>>>>> It is build-tested with every release.
>>>>>>
>>>>>
>>>>> Build AND tested, or tested for build? I did not test such configuration
>>>>> for ages, do you actually test this?
>>>>>
>>>>
>>>>
>>>> tested for build only.
>>>>
>>>
>>> We can pull the plug on this.
>>>
>>
>>
>> On the other hand, it does not cost us much to maintain this.
>>
> 
> We don't maintain this, I mean we don't test it at all anymore, and we
> have no bandwidth to put it back in our manual test routines, and would
> these fail, I don't think we should spend a minute fixing it. So we are
> left with a decision to let it bit rot, or remove it. Bit rotting of
> architecture ports is something we have been trying hard to avoid since
> day #1, so removing such support would be consistent with that policy.


Ok, if we remove the support in asm/wrappers.h


-- 
                                                                Gilles.

