MIME-Version: 1.0
In-Reply-To: <552FE54F.6090606@siemens.com>
References: <1429171505-5598-1-git-send-email-kinsamanka@gmail.com>
 <20150416131956.GC1589@hermes.click-hack.org>
 <CACreCVJd-1c8iYGuEJE4W_6Q4dpo4sPOtJvDLbQaTUN2m8Bwpw@mail.gmail.com>
 <20150416161629.GF1589@hermes.click-hack.org>
 <552FE54F.6090606@siemens.com>
Date: Fri, 17 Apr 2015 06:29:52 +0800
Message-ID: <CACreCV+9OpTRpT=4r7vpb9ThxpEfEE5zX6YjjdUNPUVgamzotA@mail.gmail.com>
From: GP Orcullo <kinsamanka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] [PATCH] Add support for SUNXI boards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Apr 17, 2015 at 12:37 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On 2015-04-16 18:16, Gilles Chanteperdrix wrote:
>> On Fri, Apr 17, 2015 at 12:04:22AM +0800, GP Orcullo wrote:
>>> On Thu, Apr 16, 2015 at 9:19 PM, Gilles Chanteperdrix
>>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>> On Thu, Apr 16, 2015 at 04:05:05PM +0800, GP Orcullo wrote:
>>>>> Tested on a Cubieboard2 with v3.16.7-ckt9 kernel.
>>>>
>>>> Does not sunxi have GPIO ?
>>>>
>>>> --
>>>>                                             Gilles.
>>>
>>> There's no GPIO driver in the mainline kernel. The original sunxi
>>> kernel has incomplete support for GPIOs.
>>
>> Ok, what about timer and tsc? Basically, you should run through the
>> ARM porting guide and check every modification to be made. And if
>> you have done so, the commit message should mention it.
>
> sunxi is pretty generic ARMv7-class in that regard, but double-checking
> is surely better.
>
> If time permits, I will give things a try on our Banana Pi - provided it
> is fine with such an old kernel (I only started with 3.19 on it).
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RTC ITP SES-DE
> Corporate Competence Center Embedded Linux

Use the kernel provided by Debian:
https://packages.debian.org/jessie/linux-image-3.16.0-4-armmp-lpae, as
most of the sunxi patches were backported.

-- 
GP Orcullo

