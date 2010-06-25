MIME-Version: 1.0
Sender: epedrett@domain.hid
In-Reply-To: <20100605214004.GC8097@domain.hid>
References: <AANLkTilOsBQXASMpEHjKs0JwOy8c2EaLG26Vej8sueZC@mail.gmail.com>
	<20100602221243.GC2590@domain.hid>
	<AANLkTikzXKkmKfglVBiXusKjXG0LHqAxDh7XY5gw1O7B@mail.gmail.com>
	<20100605214004.GC8097@domain.hid>
Date: Fri, 25 Jun 2010 14:55:27 +0100
Message-ID: <AANLkTilMiOVs__1a7uOEDuquvuRqxaHowYgbvWbrl6cx@domain.hid>
From: Ettore Pedretti <ep41@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-help] National Instruments PCI-6711
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alexis Berlemont <alexis.berlemont@domain.hid>
Cc: xenomai@xenomai.org, John Monnier <monnier@domain.hid>

Hi,

Sorry for the delay in answering. I left the observatory and went on
holiday for a while.

The standard NI driver can be downloaded from:
http://sine.ni.com/nips/cds/view/p/lang/en/nid/14480

We found this on the NI web site. I do not know if it is useful:

http://sine.ni.com/nips/cds/view/p/lang/en/nid/11737

Maybe it is the standard example that you already used to develop
comedi/analogy drivers. Please let me know if it is of any use for
you.

Best regards
Ettore

On 5 June 2010 22:40, Alexis Berlemont <alexis.berlemont@domain.hid> wrote:
> Hi,
>
> Ettore Pedretti wrote:
>> Hi,
>>
>> > On the other side, that is just the theory. I would not be surprised
>> > to find a Comedi driver which proposes the behaviour you ask thanks to
>> > a driver-specific hidden cheat flag somewhere in the structure.
>>
>> How can I find out the "hidden cheat" and how can I exploit it?
>>
>
> That was just a supposition. I have not seen such a thing in the
> Analogy NI driver (inherited from the Comedi one). Have you had a look
> at the Comedi list ?
>
> I just read again your first mail. You said the NI Linux driver
> provides the requested option. Do you have any source code ? I
> remember just having found a binary driver.
>
>> >> What is the closest functionality I can get to programming the card
>> >> and letting it run without further intervention?
>> >>
>> >
>> > I have no answer so far. That would need an extension of the framework.
>>
>> How difficult would that be? Is it a major change to the framework? It
>> seems to me that this is a nice option. You would not use any of your
>> bus bandwidth and could just change the waveform when you need it.
>>
>
> I agree this feature would be nice but I cannot tell you that I will
> add some tricky code in some corner just to let this option work. The
> problem with the command system is that it expects a continuous data
> transfer until the end of the acquisition.
>
> Maybe, a way to quickly implement it would be to use an instruction
> (it may be possible, I cannot ensure you); but to do so I need the
> code which properly programs the DAQ-STC.
>
>> Ettore
>>
>> >> All the best
>> >> Ettore
>> >>
>> >> _______________________________________________
>> >> Xenomai-help mailing list
>> >> Xenomai-help@domain.hid
>> >> https://mail.gna.org/listinfo/xenomai-help
>> >
>> > --
>> > Alexis.
>> >
>>
>>
>>
>> --
>> Ettore Pedretti, SUPA
>> School of Physics and Astronomy
>> University of St Andrews, North Haugh,
>> St Andrews, Fife, KY16 9SS, Scotland
>> Ph: +44-1334-461666, Fax: +44-1334-463104
>> The University of St Andrews is a charity registered in Scotland : No SC013532
>
> --
> Alexis.
>



-- 
Ettore Pedretti, SUPA
School of Physics and Astronomy
University of St Andrews, North Haugh,
St Andrews, Fife, KY16 9SS, Scotland
Ph: +44-1334-461666, Fax: +44-1334-463104
The University of St Andrews is a charity registered in Scotland : No SC013532

