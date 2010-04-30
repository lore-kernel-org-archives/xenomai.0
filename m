MIME-Version: 1.0
In-Reply-To: <1272619558.24705.40.camel@domain.hid>
References: <i2z48abf2c21004282309r50f047bck4be213c0aac6efe1@domain.hid>
	<4BD99F8C.3090800@domain.hid>
	<p2y48abf2c21004290820g1dabc981y5a1dbd141f64059e@domain.hid>
	<1272554724.28983.444.camel@domain.hid>
	<y2x48abf2c21004291716m769fc355ld978b2da54d4ea1d@domain.hid>
	<1272616194.24705.36.camel@domain.hid>
	<s2g48abf2c21004300217q31bce099g588cb0bdc4bf380f@domain.hid>
	<1272619558.24705.40.camel@domain.hid>
Date: Fri, 30 Apr 2010 20:03:14 +0800
Message-ID: <p2k48abf2c21004300503od8d6e868r2cdeef0ab62e3376@domain.hid>
From: Peter Pan <pppeterpppan@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-help] cyclictest gives out segmentation fault with
	xenomai 2.5.2 in powerpc arch
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

OK, I got that.

But which task mode should this latency test be run for?
user-mode task or kernel periodic task?

2010/4/30 Philippe Gerum <rpm@xenomai.org>:
> On Fri, 2010-04-30 at 17:17 +0800, Peter Pan wrote:
>> I set the /proc/xenomai/latency to 0, and get some latency results.
>> How could I set the latency to a proper value? I'm on vocation now. I
>> will post my latency result when I'm back to work.
>
> You should run the /usr/xenomai/bin/latency test when your calibrated
> latency is reset to 0, for a few seconds on your idle platform. In the
> left most column after you stopped the test, you should see the minimum
> latency value, which your reported to be negative. Use abs(min-lat) as
> the next /proc/xenomai/latency value, and redo the test, until you end
> up with a min-lat slightly higher than 0, from a few tenths of
> nanoseconds.
>
>>
>> 2010/4/30 Philippe Gerum <rpm@xenomai.org>:
>> > On Fri, 2010-04-30 at 08:16 +0800, Peter Pan wrote:
>> >> It's an EVM board of PPC460GT.
>> >>
>> >> I think the processor is very powerful, that may make xenomai workable
>> >> on our system.
>> >
>> >> I'll try to reduce the latency to a proper value.
>> >
>> > When you are done, I'd be interested in knowing the proper calibration
>> > value for this platform, so that I can pre-set it in
>> > include/asm-powerpc/calibration.h for future users.
>> >
>> > PS: echo 0 > /proc/xenomai/latency is the way to disable the
>> > anticipation in setting timer shots, so that you can determine the
>> > minimum latency of your platform, i.e. abs(min-lat) from the latency
>> > test output, on an idle system.
>> >
>> > TIA,
>> >
>
>
> --
> Philippe.
>
>
>

