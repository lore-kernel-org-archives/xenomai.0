Message-ID: <45DC4281.8030903@domain.hid>
Date: Wed, 21 Feb 2007 14:00:49 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CAN driver
References: <45DC1D05.1000206@domain.hid> <45DC2478.2020602@domain.hid>
	<45DC39DE.8050802@domain.hid> <45DC3E6C.8040905@domain.hid>
In-Reply-To: <45DC3E6C.8040905@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-help@domain.hid

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>> Jan Kiszka wrote:
>>> Roland Tollenaar wrote:
>>>> Hi list,
>>>>
>>>> does anyone have, or can anyone direct met to a project or code-snippet
>>>> that shows how the CAN driver in the xenomai patch is used in an
>>>> application? If not that any documentation that gives and explains what
>>>> calls it responds to.
>>> Check src/utils/can/ on some tools that can also serve as nice examples.
>>> But maybe we should also add even simpler demo code to the examples
>>> repository. Just takes someone to write them...
>> The utility programs rtcanconfig, rtcansend and rtcanrcv in
>> src/utils/can already demonstrate most of RT-Socket-CAN's functionality
>> including filter definition and error handling. I do not see a need for
>> simpler examples.
> 
> Yeah, maybe already a link (README) from the examples repos would be
> enough to point beginners to them. Or maybe we should ask some beginners
> what they expect, what they didn't understand... (Roland?)

Forgot to mention, that there is a README in src/utils/can and 
ksrc/drivers/can.

>> I have attached a patch for a nice program to measure
>> the round trip time of CAN messages. It contrast to the other CAN
>> utility programs, it uses the POSIX-API and works as-is for Socket-CAN
>> as well. Jan, any objections to include it? If yes, I'm going to provide
>> a README.
> 
> On first glance, nope, looks nice and clean.

OK, a revised patch will follow. And shouldn't we have separate sub-dirs 
for each skin in examples/rtdm/profiles/can and serial as well. The 
Makefile is currently valid only for one skin, at least.

> 
>> BTW: some time ago I provided a patch to make the CAN utility programs
>> part of the Doxygen documentation. IIRC, we said it's nice to have
>> hyperlinked examples in general.
> 
> Some link at hand? Does it still apply? Sounds like something worth to
> apply.

See https://mail.gna.org/public/xenomai-core/2006-11/msg00033.html.
My patch was for the CAN utilities only. The idea was to have a more 
general implementation including code snippets and now examples as well.

Wolfgang.


