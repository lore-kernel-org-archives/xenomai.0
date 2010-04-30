MIME-Version: 1.0
In-Reply-To: <1272554724.28983.444.camel@domain.hid>
References: <i2z48abf2c21004282309r50f047bck4be213c0aac6efe1@domain.hid>
	<4BD99F8C.3090800@domain.hid>
	<p2y48abf2c21004290820g1dabc981y5a1dbd141f64059e@domain.hid>
	<1272554724.28983.444.camel@domain.hid>
Date: Fri, 30 Apr 2010 08:16:37 +0800
Message-ID: <y2x48abf2c21004291716m769fc355ld978b2da54d4ea1d@domain.hid>
From: Peter Pan <pppeterpppan@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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

It's an EVM board of PPC460GT.

I think the processor is very powerful, that may make xenomai workable
on our system.

I'll try to reduce the latency to a proper value.

Thanks alot.

2010/4/29 Philippe Gerum <rpm@xenomai.org>:
> On Thu, 2010-04-29 at 23:20 +0800, Peter Pan wrote:
>> I searched through the archive, some one says that there is a git
>> commit to sole the problem. I downloaded the latest xenomai-2.5 git,
>> the problem is gone.
>>
>> But I found another problem. When I use the "latency" test, all the
>> min latency time gives out a minus value. Is that normal?
>
> Yes. Your board has better internal latency than the default calibration
> expects (i.e. time to traverse the Xenomai stack from IRQ receipt to
> activating the thread), so the timer shot is anticipated too much.
> Try reducing the value stored in /proc/xenomai/latency, until your
> system is calibrated. You can wire this value in your Kconfig
> afterwards.
>
> Which ppc hw are you running Xenomai on?
>
>>
>> 2010/4/29 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>> > Peter Pan wrote:
>> >> I downloaded the ipipe-2.6 from git.denx.de, head =A0 =A0 is
>> >> "ipipe-2.6.32-powerpc". Then I downloaded xenomai-2.5.2 and patch the
>> >> kernel. Then I install the xenomai applications into our rootfs. I
>> >> just run cyclictest in /usr/xenomai/share/xenomai/testsuit/cyclic/run=
,
>> >> it gives out following line:
>> >>
>> >> *
>> >> *
>> >> * Type ^C to stop this application.
>> >> *
>> >> *
>> >> 0.00 0.05 0.03 2/24 1010
>> >>
>> >> T: 0 ( =A0 =A00) P:99 I: 1000000 C: =A0 =A0 =A0 0 Min: 1000000 Act: =
=A0 =A0 =A0 0 Avg:
>> >> =A0 =A0 =A0 0 Max:-1000000
>> >> Segmentation fault
>> >
>> > Probably a stack overflow. Could you run the application inside gdb to
>> > check that?
>> >
>> > --
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0Gilles.
>> >
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>
>
> --
> Philippe.
>
>
>

