Message-ID: <4E81F944.3070200@domain.hid>
Date: Tue, 27 Sep 2011 18:26:44 +0200
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
In-Reply-To: <20110927160536.GA2425@domain.hid>
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

On 2011-09-27 18:05, Richard Cochran wrote:
> On Tue, Sep 27, 2011 at 05:16:09PM +0200, Jan Kiszka wrote:
>> On 2011-09-27 17:10, Richard Cochran wrote:
>>> On Tue, Sep 27, 2011 at 02:20:43PM +0200, Jan Kiszka wrote:
>>>> On 2011-09-27 14:01, Richard Cochran wrote:
>>>>> Again, every MAC driver needs to be tastefully and wisely adapted. I
>>>>> don't necessarily need to avoid coalescing. The goal (for me) is *not*
>>>>> to provide deterministic Ethernet performance. Instead the RT packets
>>>>> should just be delivered ASAP.
>>>>
>>>> This is obviously the point I completely missed. And it makes the whole
>>>> thing fairly uninteresting IMHO. If you want to do Ethercat, PowerLink
>>>> or Profinet (RT), you do need a certain level of determinism along the
>>>> *whole* packet path. And for the latter two, you definitely need RT IRQ
>>>> support, Ethercat can be OK to poll in fast setups.
>>>>
>>>> From that POV, your approach is likely OK. But I doubt its of generic
>>>> use, specifically for industrial RT Ethernet.
>>>
>>> So, how does rtnet support EtherCAT?
>>
>> There was once the EtherCAT Master Library. IIRC, it was discontinued
>> and removed from the web for non-technical reasons.
>>
>>>
>>> Does it support PowerLink and Profinet?
>>
>> Not that I know, but that's not the point. You said your approach could
>> provide the technical foundation for such a class of use cases while I
>> doubt it would work as is.
> 
> But that is the point. Correct me please if I am wrong, but isn't
> rtnet a competitor or alternative to EtherCAT, PowerLink, and
> Profinet?

That's a common misunderstanding: RTnet is a networking stack with many
_optional_ components (like RTmac, RTcfg etc.). I would bet that it's
more frequently used today in minimal setups, i.e. just the core, some
driver, and either PF_PACKET or UDP/IP.

> 
> Unless rtnet implements (or helps to implement) these, it is kind of
> silly to say, "your way won't work, you should use rtnet instead."
> 
> I don't know PowerLink or Profinet, but I do know EtherCAT and IEC
> 61850, and those two can surely be implemented on the interface that I
> am talking about.

It works, but it won't give you a deterministic control loop as you
still have Linux in the game.

> 
> Also, the interface that I propose does not preclude the use of RTDM
> ISR in the driver, so I wonder what exactly bothers you about it?

That you claim it's simpler based on lacking features - like RT IRQ
support and the associated proper driver integration of that. Maybe it
turns out to be simpler, but that is by far proven yet.

I was simply hoping to collect some new ideas how to address the driver
maintenance issue in a better way but without dropping key features
needed for RT networking. Something like "let's add generic RT channels
to Linux upstream drivers and then only patch them fit RTDM". Not sure
if that works, but it would come with a vision how to keep things more
maintainable.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

