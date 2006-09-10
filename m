Message-ID: <4503E889.2080306@domain.hid>
Date: Sun, 10 Sep 2006 12:27:21 +0200
From: Matthias Fuchs <matthias.fuchs@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: CAN updates & questions
References: <450290AC.6000009@domain.hid>
	<45029903.7030108@domain.hid>	<200609091739.00665.matthias.fuchs@domain.hid>
	<45031D1F.8050507@domain.hid>
In-Reply-To: <45031D1F.8050507@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Hi Wolfgang,

Wolfgang Grandegger wrote:
> Hi Matthias,
> 
> Matthias Fuchs wrote:
>> Hi Wolfgang,
>>
>> Wolfgang Grandegger wrote:
>>> You have to define the real CAN system clock, which is 16/2 = 8 Mhz for
>>> most SJA 1000 hardware even if the oscillator is running at 16 MHz. I
>>> will add some reasonable note to rtcan_dev.h
>> Is there any special reason for this? Wouldn't it be more meaningful
>> to pass the SJA1000 externally applied clock frequency? I can imagine
>> that others will also run into this issue as Jan and I did yesterday ;-)
> 
> The frequency is used to calculate reasonable bit-timing parameters, not
> only for SJA 1000. It's used in a similar way in the Linux socket CAN
> driver.
I am not very familiar with the socket CAN driver, but after a quick
glance at its svn repository it seems to me that they are also passing
the SJA1000 external clock frequency to the module (clk-parameter).

So I think other controller's drivers may use an other meaning of the
clk/clock parameter. But for SJA1000 the ext. clock frequency is best.
> 
>>>> Then we will soon have to discuss how to deal with a rtcan_isa
>>>> derivative that uses ioremapped memory instead of ports (naming,
>>>> separation or integration).
>>> We could add a generic device similar to ISA (or extend ISA
>>> accordingly).
>> The SJA1000 isa driver is very simple - and so is the modified version
>> for the memory mapped SJA1000. I think that merging both ways of
>> access to the SJA1000 into a single driver will make the code much
>> more dirty. I would prefer different source files (= different drivers). 
> 
> I agree.
> 
>> It would be a compromise to add support for boards that use some kind
>> of indirect addressing to access the SJA1000 (address + data register)
>> into the isa and mem versions of the driver.
> 
> Fine if this could be done in a generic way. We also should add a
> generic PCI driver sooner than later.
> 
>> One more proposal: I think many (old) ISA drivers name the module
>> parameter for the ISA io port "io" instead of "isa". For the memory
>> mapped SJA1000 driver, I'd like to call the parameter "mem".
> 
> Well, I cannot remember why I used the name "isa". Common is "io" or
> "port" or "ioport", indeed. "io" and "mem" or "ioport" and "iomem" would
> be fine for me.
I will use mem for the mem'mapped driver. The socket CAN project uses
base_addr - they must have an affection to a long parameter name :-)

Matthias


