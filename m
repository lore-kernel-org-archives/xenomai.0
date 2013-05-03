MIME-Version: 1.0
In-Reply-To: <51840209.8010708@xenomai.org>
References: <CAG5EsAE0rcOW3DP=bwYpuOYEJoqXFTKDt+SzOzhqDpT8jXFjwA@mail.gmail.com>
	<51840209.8010708@xenomai.org>
From: Ross Williamson <rwilliamson@astro.caltech.edu>
Date: Fri, 3 May 2013 11:38:01 -0700
Message-ID: <CAG5EsAE6os5PZYOAdLM6jtaD7gUeuRw2Xgh9zpq3U+qJ1r6etw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Problems with xnintr_enable xnintr_disable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>

Ahhhh.........Well that would explain it.....

I don't think the kernel module I'm using will suddenly become GPL......

R

On Fri, May 3, 2013 at 11:29 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 05/03/2013 08:20 PM, Ross Williamson wrote:
>
>> I'm in the unfortunate position of having a closed-source kernel
>> module that I need to recompile a kernel for - I have matched the
>> kernel version/xenomai version however when I insert the module I get
>> the folllowing error:
>>
>> Unknown symbol xnintr_enable
>> Unknown symbol xnintr_disable
>>
>> both these symbols are in the System.map for the kernel so I'm
>> confused as to why the kernel module is reporting this.
>>
>> Module.symvers:0x00000000 xnintr_enable vmlinux EXPORT_SYMBOL_GPL
>> System.map:80068270 T xnintr_enable
>>
>> I suspect I'm doing something dumb....
>
>
> xnintr_enable and xnintr_disable, like all services exported by Xenomai
> in kernel-space, are only available to modules using the GPL license.
>
> --
>                                                                 Gilles.



-- 
Ross Williamson
Research Scientist - Sub-mm Group
California Institute of Technology
626-395-2647 (office)
312-504-3051 (Cell)

