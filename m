MIME-Version: 1.0
In-Reply-To: <50D099A2.3080407@xenomai.org>
References: <CAPpP=rPyuKK5Sr9mxXFw+KMhD3g1F+Q5=d8Xm7nQS6hF5OCebw@mail.gmail.com>
	<50D08B74.1010809@xenomai.org> <50D08C0A.10502@xenomai.org>
	<CAPpP=rPi6NvBV6OAfLM3Ynym2FWtO_i7iyKx0hT7eYJLUT+8Bg@mail.gmail.com>
	<50D099A2.3080407@xenomai.org>
Date: Tue, 18 Dec 2012 20:27:02 +0100
Message-ID: <CAPpP=rO9JjAeWS7evj9u-bVOZuS79NxVJhtLOUJRpFn1zRCb5w@mail.gmail.com>
From: alex alex <duch.alexandre@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] [Page fault - POSIX skin] Interraction between malloc
 en nanosleep
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

In fact, this is what I intend to use when the bug will be solved. I use
native because RTDM semaphore freezes my PC while with native,
semaphore is just
no longer blocking (so native helped me to find out the bug and it keeps me
from restart the PC when it bugs... )

Thanks for the link.

2012/12/18 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 12/18/2012 05:16 PM, alex alex wrote:
>
>> My LDFLAGS is :
>> -Wl,@/usr/lib/posix.wrappers -L/usr/lib -lpthread_rt -lxenomai -lpthread
>> -lrt
>>
>> and I use :
>> xenomai-2.6.1/ksrc/arch/x86/**patches/adeos-ipipe-2.6.38.8-**
>> x86-2.11-01.patch
>>
>
> This patch is known to be bogus, try:
> http://download.gna.org/adeos/**patches/v2.6/x86/adeos-ipipe-**
> 2.6.38.8-x86-2.11-03.patch<http://download.gna.org/adeos/patches/v2.6/x86/adeos-ipipe-2.6.38.8-x86-2.11-03.patch>
>
>
>
>> however I need to open my RTDM driver with blocking open during this
>> phase,I usenativeskin
>> semaphore for it. This page fault causes the blocking malfunction of the
>> semaphores (rt_sem_p returns EPERM).
>>
>
> Using native skin semaphore is deprecated. If writing an RTDM driver, why
> not using an RTDM semaphore?
>
> --
>                                             Gilles.
>
