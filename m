Message-ID: <50818781.7050204@xenomai.org>
Date: Fri, 19 Oct 2012 19:01:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAN0CFw3KM6VC-q9QHjoME0AqJOApw_9h4aEP0D2uxeD6rgcGcw@mail.gmail.com>	<50798BD3.6010308@xenomai.org>
	<50798F8A.8060508@xenomai.org>	<CAN0CFw0AhYwkGLQvugxw6NqPtv6mBxxLYnPWsdXXjO25_pmSVQ@mail.gmail.com>	<508171AB.8010707@xenomai.org>
	<CAN0CFw3WqabceF1LoR===ZXQU5-WRCfYb_itk0_ig2NKKG9vtg@mail.gmail.com>
In-Reply-To: <CAN0CFw3WqabceF1LoR===ZXQU5-WRCfYb_itk0_ig2NKKG9vtg@mail.gmail.com>
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
To: Grant <emailgrant@gmail.com>
Cc: xenomai@xenomai.org

On 10/19/2012 06:17 PM, Grant wrote:
>>>>>> Does xenomai.org indicate which versions of the vanilla kernel can be
>>>>>> patched with the latest xenomai release?
>>>>>
>>>>>
>>>>>
>>>>> Basically, any linux version older than the version for which the
>>>>> patches are provided in xenomai sources, for which an Adeos patch exists in
>>>>>
>>>>> http://download.gna.org/adeos/patches/
>>>
>>> How can I tell for which kernel version the patches are provided?  I
>>> believe the latest patches are contained here?
>>>
>>> http://download.gna.org/xenomai/testing/
>>
>> The patches are contained in the ksrc/arch/YOURARCH/patches directory of
>> xenomai sources.
>>
>> Where YOURARCH is one of arm, blackfin, nios2, powerpc, sh, x86, etc...
> 
> Got it, but I'm still confused by the following definition:
> 
> "any linux version older than the version for which the patches are
> provided in xenomai sources, for which an Adeos patch exists in:
> http://download.gna.org/adeos/patches/"
> 
> The patches in 2.6.0-rc5 xenomai sources seem to be for these kernel versions:

2.6.0-rc5 is not the latest version, 2.6.1 is. For the x86 architecture
for instance, it contains the following patches:

adeos-ipipe-2.6.37.6-x86-2.9-02.patch
adeos-ipipe-2.6.38.8-x86-2.11-01.patch
ipipe-core-3.2.21-x86-1.patch

So, any version earlier than 3.2.21 for which an Adeos patch exists in
http://download.gna.org/adeos/patches/v2.6/x86
http://download.gna.org/adeos/patches/v3.x/x86

Is supported.

That is:
2.6.24
2.6.25
2.6.26
2.6.26.7
2.6.26.8
2.6.27
2.6.27.13
2.6.27.19
2.6.28.2
2.6.28.7
2.6.28.9
2.6.29.1
2.6.29.4
2.6.29.5
2.6.30
2.6.30.5
2.6.30.8
2.6.31
2.6.31.1
2.6.31.8
2.6.32.11
2.6.32.13
2.6.32.15
2.6.32.2
2.6.32.20
2.6.32.7
2.6.34
2.6.34.5
2.6.35.7
2.6.35.9
2.6.37
2.6.37.6
2.6.38.8
3.2.21

-- 
					    Gilles.

