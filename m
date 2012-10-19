Message-ID: <508171AB.8010707@xenomai.org>
Date: Fri, 19 Oct 2012 17:28:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAN0CFw3KM6VC-q9QHjoME0AqJOApw_9h4aEP0D2uxeD6rgcGcw@mail.gmail.com>	<50798BD3.6010308@xenomai.org>
	<50798F8A.8060508@xenomai.org>
	<CAN0CFw0AhYwkGLQvugxw6NqPtv6mBxxLYnPWsdXXjO25_pmSVQ@mail.gmail.com>
In-Reply-To: <CAN0CFw0AhYwkGLQvugxw6NqPtv6mBxxLYnPWsdXXjO25_pmSVQ@mail.gmail.com>
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

On 10/19/2012 05:12 PM, Grant wrote:
>>>> Does xenomai.org indicate which versions of the vanilla kernel can be
>>>> patched with the latest xenomai release?
>>>
>>>
>>>
>>> Basically, any linux version older than the version for which the
>>> patches are provided in xenomai sources, for which an Adeos patch exists in
>>>
>>> http://download.gna.org/adeos/patches/
> 
> How can I tell for which kernel version the patches are provided?  I
> believe the latest patches are contained here?
> 
> http://download.gna.org/xenomai/testing/

The patches are contained in the ksrc/arch/YOURARCH/patches directory of
xenomai sources.

Where YOURARCH is one of arm, blackfin, nios2, powerpc, sh, x86, etc...

-- 
					    Gilles.

