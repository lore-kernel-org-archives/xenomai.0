MIME-Version: 1.0
In-Reply-To: <1296471234.2214.38.camel@domain.hid>
References: <AANLkTi=7M-cqps4b--i6Kud3o6-awuntk2Zpwj7JHZ8a@domain.hid>
	<1296469933.2214.35.camel@domain.hid> <4D469437.9050902@domain.hid>
	<1296471234.2214.38.camel@domain.hid>
Date: Mon, 31 Jan 2011 12:01:54 +0100
Message-ID: <AANLkTikz2UuirubwC1oRQoXBRCqWS0xf3z__3mD60rCn@domain.hid>
From: gryma biloy <gryma.biloy@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Is xenomai OK for early boot purpose ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, Jan 31, 2011 at 11:53 AM, Philippe Gerum <rpm@xenomai.org> wrote:
> On Mon, 2011-01-31 at 11:51 +0100, Gilles Chanteperdrix wrote:
>> Philippe Gerum wrote:
>> > On Mon, 2011-01-31 at 09:55 +0100, gryma biloy wrote:
>> >> Hello,
>> >>
>> >> On a project running Linux on a beagle board, I'd like to add the
>> >> following capabilities to my platform :
>> >> =A0 - real time processes with periodic tasks (10ms, 100ms & 200 ms) =
and
>> >> a low jitter (< 50 us)
>> >
>> > Kernel space apps then, likely. Userland apps (the recommended way)
>> > probably have a larger worst-case jitter on this hardware, albeit stil=
l
>> > below 100 us. Gilles?
>>
>> Las time I checked, latency measured on a 720MHz omap3 was around 55us
>> with a 1ms period and 35us with a 100us period.
>
> Yeah, I suspect that longer periods ( >=3D 10 ms ) may introduce more
> opportunities for cache eviction due to linux activity, and therefore
> higher jittery, even if bounded.

Does this mean that the main reason for jittery is due to the cache ?
What would be the other reasons, if any ?



>> >> =A0 - early boot operations (i.e. being able to perform some tasks as=
ap
>> >> after a power on reset)
>> >>

>> >
>> > I don't see how Xenomai could directly help in any way for the early
>> > boot goal. If you question is about whether Xenomai initializes fast
>> > enough, and early enough during the linux boot process for kicking rt
>> > applications as soon as possible, then the answer is yes, that should
>> > do.
>>
>> Well, user-space applications will not get started before user-space is
>> started, i.e. basically before root filesystem has been mounted and init
>> is running. You could write your real-time application as the init
>> application, but that would be kind of awkward.


Understand. I will make a try a see if I can meet some of my constraints.

Thanks for your replies,

--=20
Gryma

