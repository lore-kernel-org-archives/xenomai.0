Message-ID: <5396D780.4020704@xenomai.org>
Date: Tue, 10 Jun 2014 12:01:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20140606135912.GJ5765@lukather> <20140606140031.GK5765@lukather>
 <539322FA.5030004@xenomai.org> <20140610094057.GJ9791@lukather>
 <5396D469.7060701@xenomai.org> <20140610095422.GK9791@lukather>
In-Reply-To: <20140610095422.GK9791@lukather>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai on Atmel SAMA5D3 with a 3.14 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Michael Opdenacker <michael@free-electrons.com>, Thomas Petazzoni <thomas@free-electrons.com>, Boris Brezillon <boris@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, xenomai@xenomai.org, =?UTF-8?B?QW50b2luZSBUw6luYXJ0?= <antoine@free-electrons.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/10/2014 11:54 AM, Maxime Ripard wrote:
> On Tue, Jun 10, 2014 at 11:48:25AM +0200, Gilles Chanteperdrix
> wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> On 06/10/2014 11:40 AM, Maxime Ripard wrote:
>>> On Sat, Jun 07, 2014 at 04:34:34PM +0200, Gilles Chanteperdrix 
>>> wrote:
>>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>>>> 
>>>> On 06/06/2014 04:00 PM, Maxime Ripard wrote:
>>>>> On Fri, Jun 06, 2014 at 03:59:12PM +0200, Maxime Ripard
>>>>> wrote:
>>>>>> Hi Gilles,
>>>>>> 
>>>>>> I've been experimenting these days with the i-pipe 3.14 
>>>>>> kernel, and current xenomai master branch on the Atmel 
>>>>>> SAMA5D3 SoC.
>>>>>> 
>>>>>> There's a few issues there, the first one being that 
>>>>>> at91_ipipe_early_init crashes because of a NULL pointer 
>>>>>> dereference. This is due to the clk_get_rate call on the 
>>>>>> clock returned by clk_get(NULL, "mck").
>>>>>> 
>>>>>> This clk_get call cannot since 3.14 because the clock
>>>>>> code has been rewritten, and you can't use clkdev
>>>>>> anymore.
>>>>>> 
>>>>>> This is quite simple to fix, and after actually fixing
>>>>>> it, you get a more interesting issue: either the timers
>>>>>> or the interrupts don't work at all.
>>>>>> 
>>>>>> The first symptom is that it get stuck at the delay loop
>>>>>>  calibration. Setting the loops per jiffy in the command
>>>>>> line make the boot go further, until the switch to the
>>>>>> ipipe_tsc clocksource. This actually makes me think that
>>>>>> it's more the timers that are broken rather than the
>>>>>> interrupts. Changing the timer counter block doesn't
>>>>>> solve anything.
>>>>>> 
>>>>>> Do you have an idea of what could be going on?
>>>>> 
>>>>> 
>>>>> Actually, the boot seem just to be *much* slower, so maybe
>>>>> the timers are working after all, but it's just yet another
>>>>> issue with the clocks.
>>>>> 
>>>> Does __ipipe_tsc_update get called in Linux timer interrupt?
>>> 
>>> Here is what's happening: http://pastebin.com/m2mz66pU
>>> 
>>> You can see that at line 35, the timer interrupt (a spurious
>>> one?) gets called, and calls __ipipe_tsc_update. At that point,
>>>  ipipe_tsc_value seems to be NULL, and hence __ipipe_tsc_update
>>>  returns.
>>> 
>>> The thing is, the timer interrupt doesn't seem to be called
>>> again. The fact that it was actually called once makes me think
>>> that it's rather the timer clock that is not running... I will
>>> dig into it.
>> 
>> If you have CONFIG_NO_HZ enabled, try to turn it off.
> 
> CONFIG_NO_HZ is disabled, here is the full config: 
> http://pastebin.com/fmVGTX4W
> 
If you compile the kernel without I-pipe and Xenomai support and
enable the tcb_clksrc clocksource driver does it work?

- -- 
                                                                Gilles.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iD8DBQFTlteAGpcgE6m/fboRAlMrAJ9Vbi6jmURQNiUg0jo6pYABOYaXGgCeMw8p
2hdc5SX8OG0SYPaUI/OGQI0=
=LG2j
-----END PGP SIGNATURE-----

