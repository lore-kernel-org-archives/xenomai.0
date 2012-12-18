MIME-Version: 1.0
In-Reply-To: <50D08C0A.10502@xenomai.org>
References: <CAPpP=rPyuKK5Sr9mxXFw+KMhD3g1F+Q5=d8Xm7nQS6hF5OCebw@mail.gmail.com>
	<50D08B74.1010809@xenomai.org> <50D08C0A.10502@xenomai.org>
Date: Tue, 18 Dec 2012 17:16:50 +0100
Message-ID: <CAPpP=rPi6NvBV6OAfLM3Ynym2FWtO_i7iyKx0hT7eYJLUT+8Bg@mail.gmail.com>
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

My LDFLAGS is :
-Wl,@/usr/lib/posix.wrappers -L/usr/lib -lpthread_rt -lxenomai -lpthread
-lrt

and I use :
xenomai-2.6.1/ksrc/arch/x86/patches/adeos-ipipe-2.6.38.8-x86-2.11-01.patch

I guess "--wrap,malloc" is similar to @/usr/lib/posix.wrappers.
Anyway, malloc, nanosleep and pthread_create are well wrapped.

nm -g test | grep wrap
         U __wrap_malloc
         U __wrap_nanosleep
         U __wrap_pthread_create
         U __wrap_pthread_setschedparam
         U __wrap_puts


Actually, I realize a porting of a robotics software platform to
xenomai and allocations
are made in an initial phase where the real-time performance is not
important,
however I need to open my RTDM driver with blocking open during this
phase,I usenativeskin
semaphore for it. This page fault causes the blocking malfunction of the
semaphores (rt_sem_p returns EPERM).

2012/12/18 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 12/18/2012 04:27 PM, Gilles Chanteperdrix wrote:
>
>> On 12/18/2012 03:35 PM, alex alex wrote:
>>
>>> Hi all,
>>>
>>> The attached program shows an interraction bug between malloc and
>>> nanosleep.
>>> The use of these two functions in a rt thread leads to a page fault.
>>> The dmesg output is:
>>>
>>> Xenomai: Switching test to secondary mode after exception #14 from
>>> user-space at 0xb760393e (pid 30730)
>>>
>>> I need to remove this switch because it prevents me to used the
>>> rtdm_sem_down function ( which return -1) in my RTDM driver and I guess
>>> it
>>> must also deteriorate the real time performance of my application.
>>>
>>> Thanks for your help.
>>>
>>
>> If you are compiling with the Makefile in the attachment, your rt thread
>> is not in fact using xenomai.
>>
>>  Sorry, I mixed LDFLAGS and CFLAGS. Anyway, please try adding
> -Wl,--wrap,malloc to the LDFLAGS to see if you get the same issue.
>
> Also, if there is really an issue, I would expect this issue to be
> dependent on the architecture and I-pipe patch used, so, please give us
> this information.
>
> --
>                                             Gilles.
>
