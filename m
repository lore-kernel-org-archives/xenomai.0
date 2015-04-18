MIME-Version: 1.0
In-Reply-To: <20150418065520.GT15807@lukather>
References: <1429171505-5598-1-git-send-email-kinsamanka@gmail.com>
 <20150416131956.GC1589@hermes.click-hack.org>
 <CACreCVJd-1c8iYGuEJE4W_6Q4dpo4sPOtJvDLbQaTUN2m8Bwpw@mail.gmail.com>
 <20150418065520.GT15807@lukather>
Date: Sat, 18 Apr 2015 16:05:25 +0800
Message-ID: <CACreCVL8VdhBQNewr_iocc_1ZAj6uuF8mgWQRpz+wWErvCehXg@mail.gmail.com>
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
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Sat, Apr 18, 2015 at 2:55 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, Apr 17, 2015 at 12:04:22AM +0800, GP Orcullo wrote:
>> On Thu, Apr 16, 2015 at 9:19 PM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>> > On Thu, Apr 16, 2015 at 04:05:05PM +0800, GP Orcullo wrote:
>> >> Tested on a Cubieboard2 with v3.16.7-ckt9 kernel.
>> >
>> > Does not sunxi have GPIO ?
>> >
>> > --
>> >                                             Gilles.
>>
>> There's no GPIO driver in the mainline kernel. The original sunxi
>> kernel has incomplete support for GPIOs.
>
> That's not true.
>
> The GPIO support has been feature complete since 3.11.
>

I'm not sure if it supports interrupts though.

> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com



-- 
GP Orcullo

