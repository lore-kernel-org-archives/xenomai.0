Message-ID: <4E8206F3.8010802@domain.hid>
Date: Tue, 27 Sep 2011 19:25:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <cover.1316774468.git.richard.cochran@domain.hid>
	<4E7C8EB2.1020308@domain.hid>
	<20110926114118.GA2213@domain.hid>
	<4E8188CB.4040102@domain.hid>
	<20110927120122.GA10155@domain.hid>
	<4E81BF9B.1030401@domain.hid>
	<20110927151009.GA3345@domain.hid>
	<4E81E8B9.8000004@domain.hid>
	<20110927160536.GA2425@domain.hid>
	<4E81F944.3070200@domain.hid>
	<20110927170012.GA6057@domain.hid>
In-Reply-To: <20110927170012.GA6057@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC 0/1] Class driver for raw Ethernet packets
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Richard Cochran <richardcochran@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2011-09-27 19:00, Richard Cochran wrote:
> On Tue, Sep 27, 2011 at 06:26:44PM +0200, Jan Kiszka wrote:
>> On 2011-09-27 18:05, Richard Cochran wrote:
>>
>> That's a common misunderstanding: RTnet is a networking stack with many
>> _optional_ components (like RTmac, RTcfg etc.). I would bet that it's
>> more frequently used today in minimal setups, i.e. just the core, some
>> driver, and either PF_PACKET or UDP/IP.
> 
> I understood about the modular design, but I really want to know if
> rtnet will help me if I want to use of the industrial Ethernet
> protocols. AFAICT, rtnet really doesn't offer these.
> 
> So I'll ask the direct question once again. Does rtnet help me with
> industrial Ethernet (apart from the rtnet protocols), or not?

It manages buffers for you, provides NIC drivers and interfaces to
either build the higher protocol layers in the kernel or in user space.
That's the mission, but I would not exclude that there is room for
improvements (lacking safe copy-to/from user, unneeded RX thread for
single-user scenarios and possibly more). Still, the Ethercat master
library folks chose it back then as a platform, maybe you want to ask them.

> 
>>> Unless rtnet implements (or helps to implement) these, it is kind of
>>> silly to say, "your way won't work, you should use rtnet instead."
>>>
>>> I don't know PowerLink or Profinet, but I do know EtherCAT and IEC
>>> 61850, and those two can surely be implemented on the interface that I
>>> am talking about.
>>
>> It works, but it won't give you a deterministic control loop as you
>> still have Linux in the game.
> 
> It really depends on how the driver is written. While my gianfar
> example does make use of normal Linux driver interrupts, it would not
> necessarily have to do so.
> 
>> I was simply hoping to collect some new ideas how to address the driver
>> maintenance issue in a better way but without dropping key features
>> needed for RT networking. Something like "let's add generic RT channels
>> to Linux upstream drivers and then only patch them fit RTDM". Not sure
>> if that works, but it would come with a vision how to keep things more
>> maintainable.
> 
> Well, can you turn the issue around and convince me that writing a
> rtnet driver is the best way to acheive raw Ethernet packet access?

It would at least avoid having to reinvent user interfaces and buffer
management layers. They may appear simple now, but that's how everything
once started.

> 
> You talk about the rtnet driver model, but is it described anywhere?
> 
> (BTW rtnet/Documentation/README.drvporting is horrible. It is just a
> random list of 40+ odd points without any sense. That document gave me
> the impression that developing an rtnet driver is a kind of extended
> "hack until it starts working.")

I know best. It once worked well, allowed you to more or less
mechanically convert a driver within a few hours, but that's quite a few
years ago. Driver complexity almost exploded since then.

But my goal is not necessarily convincing you to use current RTnet as
is, but to make you think ahead, reusing the experience of this project
if you start something new. That need not replace RTnet immediately, but
it should not block a transition architecturally. The first step to this
remains studying the legacy, even if not using it in the end.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

