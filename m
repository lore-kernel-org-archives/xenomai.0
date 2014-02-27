Message-ID: <530FA1D0.2000209@grandegger.com>
Date: Thu, 27 Feb 2014 21:36:32 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <4C58E39DE6620348B85D78E601C268AF437ABD@srv-exchang2-mi.jerviswebb.com>,
 <201402142329.10853.paul_c@tuxcnc.org>
 <4C58E39DE6620348B85D78E601C268AF438358@srv-exchang2-mi.jerviswebb.com>
 <1392655777.26562.YahooMailNeo@web163503.mail.gq1.yahoo.com>
 <53026F63.5080403@grandegger.com>
 <1392760838.41780.YahooMailNeo@web163505.mail.gq1.yahoo.com>
 <d3241e64b0ad1946aaa3952553fe354f@grandegger.com>
 <1392847535.52577.YahooMailNeo@web163501.mail.gq1.yahoo.com>
 <3a692b55821a5a04d7b55253388edeaf@grandegger.com>
 <5305BAA6.1040007@xenomai.org>
 <1393345381.78835.YahooMailNeo@web163505.mail.gq1.yahoo.com>
In-Reply-To: <1393345381.78835.YahooMailNeo@web163505.mail.gq1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] CAN ISA support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wayne Ross <mr_trekkie@yahoo.com>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 02/25/2014 05:23 PM, Wayne Ross wrote:
> On Thursday, February 20, 2014 3:19 AM Gilles Chanteperdrix wrote:
> 
>> On 02/20/2014 08:47 AM, Wolfgang Grandegger wrote:
>>> Am Mi, 19.02.2014, 23:05 schrieb Wayne Ross:
>>>> On Wednesday, February 19, 2014 3:16 AM Wolfgang Grandegger wrote:
>>>>> - What does "/proc/xenomai/irq" list after you have sent a message?
>>>>>
>>>> # cat /proc/xenomai/irq
>>>> IRQ         CPU0        CPU1        CPU2        CPU3
>>>>   12:           0           0           0           0         SJA1000
>>>>   15:           0           0           0           0         SJA1000
>>>
>>> ... the problem is here. No interrupts are triggered. Are your sure
>>> that the IRQ numbers are correct (check jumpers on the card/board)?>
>> You can also check cat /proc/interrupts when using the Linux driver.
>>
>> -- 
>>                                                                 Gilles.
> 
> 
> Thanks for all the in-sight.  Tracing down this lack of interrupts led me to the following solution:
> - the Advantech driver *transmits* without the aid of IRQs, so I "thought" it was working, when indeed no IRQs were seen.

It works for just one message.

> - I had never tried to receive CAN with the Advantech driver: when I did so, it would not (no IRQs)

You mean you only sent messages with the Advantech driver?

> - I found the setting in my v2.61 American Megatrends BIOS that allows "Legacy IRQs" to be "Reserved" (not allowed to be used by PCIPnP).

BIOS settings may need the be adjusted but I understood that the device
was already working with another driver.

> - I also had to select different IRQs that all components (BIOS, CAN card, 4 16550A UARTs & some ata/acpi Linux drivers) agree were unused and I could tag as "Reserved"

> - In hindsight, all of this should have been done first, but such is the lesson learned when venturing down a new road.  I'm not used to dealing with a BIOS that gets between the chips on my board and the software I write.

Does it now work (with IRQs)?

> I intend to look more at the btr1 register "issue".  As Wolfgang mentions, it *should* be 0x1c, so only sometimes do I get the correct value.  I think the 0x9c means "3 samples" (instead of 1) -- at least when I put these register settings into my Windows driver, that is how that software decodes the meaning.  But it does indeed transmit and receive thousands of messages without a problem.

Yes, that's weird.  Maybe there are register access problems.

Wolfgang.


