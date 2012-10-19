MIME-Version: 1.0
In-Reply-To: <508171AB.8010707@xenomai.org>
References: <CAN0CFw3KM6VC-q9QHjoME0AqJOApw_9h4aEP0D2uxeD6rgcGcw@mail.gmail.com>
	<50798BD3.6010308@xenomai.org> <50798F8A.8060508@xenomai.org>
	<CAN0CFw0AhYwkGLQvugxw6NqPtv6mBxxLYnPWsdXXjO25_pmSVQ@mail.gmail.com>
	<508171AB.8010707@xenomai.org>
Date: Fri, 19 Oct 2012 09:17:56 -0700
Message-ID: <CAN0CFw3WqabceF1LoR===ZXQU5-WRCfYb_itk0_ig2NKKG9vtg@mail.gmail.com>
From: Grant <emailgrant@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Which kernel versions?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

>>>>> Does xenomai.org indicate which versions of the vanilla kernel can be
>>>>> patched with the latest xenomai release?
>>>>
>>>>
>>>>
>>>> Basically, any linux version older than the version for which the
>>>> patches are provided in xenomai sources, for which an Adeos patch exists in
>>>>
>>>> http://download.gna.org/adeos/patches/
>>
>> How can I tell for which kernel version the patches are provided?  I
>> believe the latest patches are contained here?
>>
>> http://download.gna.org/xenomai/testing/
>
> The patches are contained in the ksrc/arch/YOURARCH/patches directory of
> xenomai sources.
>
> Where YOURARCH is one of arm, blackfin, nios2, powerpc, sh, x86, etc...

Got it, but I'm still confused by the following definition:

"any linux version older than the version for which the patches are
provided in xenomai sources, for which an Adeos patch exists in:
http://download.gna.org/adeos/patches/"

The patches in 2.6.0-rc5 xenomai sources seem to be for these kernel versions:

2.6.35.9
2.6.37.6
2.6.38.8

And the Adeos patches are for these:

3.0.13
3.0.36
3.2.21

So the above definition doesn't match any versions?

- Grant

