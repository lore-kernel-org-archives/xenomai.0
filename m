MIME-Version: 1.0
References: <CAK+-5=KyqTMv7+Dw_zZWyrWjeyF6P43kvS5iwWWtNWkqrsqvQA@mail.gmail.com>
 <CALLqZ8R9bC0F2t14-a-jktCRUvwMLJPXf3h+09=MDAdVciSj2Q@mail.gmail.com>
 <CAK+-5=+syrQHzNJUgK270XfSrgdDxxg9pkO_Qs5009SU4H9S1w@mail.gmail.com>
In-Reply-To: <CAK+-5=+syrQHzNJUgK270XfSrgdDxxg9pkO_Qs5009SU4H9S1w@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 13 Dec 2018 09:35:42 -0500
Message-ID: <CALLqZ8T1L9tswtU1P6CGZTzu2GfkvCfo1zk-BzyL_POQ1p2obg@mail.gmail.com>
Subject: Re: rtdm spi demo on Raspberri pi
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ho Tam <mophong@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

I haven't been bale to dig up my example code for this but I base it off
this test:

https://gitlab.denx.de/Xenomai/xenomai/blob/master/testsuite/spitest/spitest.c

I'll hopefully have some time in the very near future to put together a
quick example.

Thanks

Greg

On Sat, Dec 8, 2018 at 3:06 AM Ho Tam <mophong@gmail.com> wrote:

> Yes, linux spi driver has been isolated. I am waiting for your example
> code.
> Thank you,
>
>
> <https://www.avast.com/sig-email?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=webmail&utm_term=icon> Virus-free.
> www.avast.com
> <https://www.avast.com/sig-email?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=webmail&utm_term=link>
> <#m_-1121549771311806162_DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2>
>
> On Fri, Dec 7, 2018 at 11:32 PM Greg Gallagher <greg@embeddedgreg.com>
> wrote:
>
>> I've played with it a bit, I'll see if I have any example code laying
>> around.  Did you unbind the linux spi driver?
>>
>> Thanks
>>
>> Greg
>> On Thu, Dec 6, 2018 at 9:50 PM Ho Tam via Xenomai <xenomai@xenomai.org>
>> wrote:
>> >
>> > Hello group,
>> > I can see there is rtdm spi driver for raspberry pi but can't see any
>> > userspace demo for it.
>> > I have built and inserted xeno_spi_bcm2835, xeno_spi modules but
>> couldn't
>> > see any spi device in '/dev/rtdm/'.
>> > Does anyone have example using this driver?
>> > Thank you
>> > --
>>
>
>
> --
> http://www.mophong.com
>
