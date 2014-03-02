MIME-Version: 1.0
In-Reply-To: <CAEbDrg=NkOMjtnqH623q_f4c6c6Hsm+OmqHhSgA02+cgPt0DLA@mail.gmail.com>
References: <CAEbDrgkifqMcqqEqh5hKA90YzFzcyDxLHFC79F8CWvZi5heyWQ@mail.gmail.com>
 <530D0BBD.6070704@xenomai.org>
 <CAK4EZFR_L+=-LtSVHkvZ36rPOA8ViVboB9M9rf4Yqk=crfBotw@mail.gmail.com>
 <CAEbDrgk=yrGq8KdpdN8e7RtO7qUpWTtwRXhrg0A0=KbDjqoDng@mail.gmail.com>
 <530D2C92.9010607@xenomai.org>
 <CAEbDrgkWZqSxjCUfjR3YCp=YOzh1r-=YC6Wyr-Jvk9d7JYEcmQ@mail.gmail.com>
 <530E6159.4050204@xenomai.org>
 <CAEbDrgmo==15Zar2X=yz=wBL3pJ4DOiqKy2xx43UPxuu6_5LhA@mail.gmail.com>
 <530F17EC.6020204@xenomai.org>
 <CAEbDrgnq46OJ6bi1FCQmC8JBWhSA6o=M9K=fg4x4hq3JpwcBjw@mail.gmail.com>
 <530F9CA2.2040601@xenomai.org>
 <CAEbDrgmLq08Xq5Cgt7oXX3koQDr+HVx_JS-7Nn_pC53rmTTV-g@mail.gmail.com>
 <531075E7.7060107@xenomai.org>
 <CAEbDrgmQNRjaTEm5TvM93Yy3k+fa+QRETFzXdM3bz8=-N15DPQ@mail.gmail.com>
 <53134A2E.1000406@xenomai.org>
 <CAEbDrgmB4vZ0TPrD2-_-vR8bDwYXLKL2fMdNzFZWGsoiK9ZBDQ@mail.gmail.com>
 <53137581.5060600@xenomai.org>
 <CAEbDrg=2nX1kKOGt6i7b-w5AsLXkEyoJCGUMw1dkMXvka4MeKw@mail.gmail.com>
 <53137F18.3020409@xenomai.org> <531380BA.70006@xenomai.org>
 <CAEbDrg=NkOMjtnqH623q_f4c6c6Hsm+OmqHhSgA02+cgPt0DLA@mail.gmail.com>
Date: Sun, 2 Mar 2014 21:03:21 +0000
Message-ID: <CAEbDrg=gCpB2=4gerJ82TnTdZo+knG6O5uvpzg5_odU-nLvaNQ@mail.gmail.com>
From: Gregory Dymarek <gregd72002@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] RaspberryPi kernel 3.8 issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

3.10 does not require the USB patch. It just requires the the ealier patch
where local_fiq_* are defined as hard_local_fiq_*

When I searched the USB issue around the net I found the explanation for
using FIQ in USB driver on this board:
http://hwswbits.blogspot.co.uk/2013/09/dwc-usb-interrupt-spam-in-rockchip-socs.html

"the Synopsys driver relies on the start of frame interrupt for scheduling
transfers if "descriptor DMA" is not implemented (which it isn't, on
BCM2835).  8000 is one interrupt per microframe."

A solution in 3.8 was to use FIQ for USB IRQs to discard USB microframes
that contain no data.

All clear now. Thanks Gilles.


On 2 March 2014 19:08, Gregory Dymarek <gregd72002@gmail.com> wrote:

> Understood. I will have a look.
>
> I'll be getting kernel 3.10 in a moment. It looks like USB driver is
> different to the one in 3.8.
> Will see what it does.
>
> Overall, there has been a lot of debate around the USB driver on this SOC
> so you might be right that the driver is not working as it is supposed to.
> Not yet at least.
>
>
>
> On 2 March 2014 19:04, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
>
>> On 03/02/2014 07:57 PM, Gilles Chanteperdrix wrote:
>> > On 03/02/2014 07:54 PM, Gregory Dymarek wrote:
>> >> This works!!
>> >>
>> >> I thought xenomai does not deal with fiq. Why is it required to enable
>> them
>> >> in the driver when having xenomai on?
>> >
>> > Because without CONFIG_IPIPE local_irq_restore deals with FIQs
>> > With CONFIG_IPIPE local_irq_restore does not deal with FIQs
>> >
>> > We can of course rework local_irq_restore to take into account FIQs with
>> > CONFIG_IPIPE, but that would make local_irq_restore heavier in a lot of
>> > places, whereas there are in fact only three spots to fix, for only one
>> SOC.
>> >
>> >
>> BTW, using FIQs for USB means that USB activity will be able to
>> influence xenomai latencies. So, it is really not recommended, if there
>> is a configuration option for disabling the use of FIQ with this driver,
>> this should be recommended for use with xenomai.
>>
>> --
>>                                                                 Gilles.
>>
>
>
