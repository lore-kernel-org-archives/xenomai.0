Message-ID: <4E820FC4.2080103@domain.hid>
Date: Tue, 27 Sep 2011 20:02:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <cover.1316774468.git.richard.cochran@domain.hid>	<4E7C8EB2.1020308@domain.hid>	<20110926114118.GA2213@domain.hid>	<4E8188CB.4040102@domain.hid>	<20110927120122.GA10155@domain.hid>	<4E81BF9B.1030401@domain.hid>	<20110927151009.GA3345@domain.hid>	<4E81E8B9.8000004@domain.hid>	<20110927160536.GA2425@domain.hid>	<4E81F944.3070200@domain.hid>
	<20110927170012.GA6057@domain.hid>
In-Reply-To: <20110927170012.GA6057@domain.hid>
Content-Type: text/plain; charset=UTF-8
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/27/2011 07:00 PM, Richard Cochran wrote:
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

>From the point of view of someone a bit external to the rtnet project,
rtnet is a TCP/IP stack, which contains the stack, useless for your
purposes, but defines an interface between drivers and the stack. By
following this interface to write a driver on one-side, and support for
raw packets on the other side you get:
- raw packets support for all drivers in rtnet repository
- TCP/IP support for the NIC you wrote a driver for.

As for the in-kernel driver patch versus out-of-tree driver, in-kernel
driver will have to be adapted for each release of the linux kernel,
when porting the I-pipe patch, and that is quickly going to become a
nightmare.

> You talk about the rtnet driver model, but is it described anywhere?
> 
> (BTW rtnet/Documentation/README.drvporting is horrible. It is just a
> random list of 40+ odd points without any sense. That document gave me
> the impression that developing an rtnet driver is a kind of extended
> "hack until it starts working.")

README.drvporting is frightening at first, but in fact, the job to port
a network driver to rtnet is not so hard.

> 
> Thanks,
> Richard
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 
                                                                Gilles.

