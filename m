Message-ID: <470CADD7.8090207@domain.hid>
Date: Wed, 10 Oct 2007 12:47:51 +0200
MIME-Version: 1.0
References: 447E9383.8090403@domain.hid
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: Re: [Xenomai-help] [RTnet-users] compactPCI LAN Chip Support
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid, Xenomai-help@domain.hid

Hi Jan,

I am looking for a hardware platform to host hte final result of our
labours.

I have a machine with the following chip:

Intel 82541PI

and have found the below reply of yours to an email of someone else
asking the exact same question. However this was quite long ago and the
e1000 seems to have evolved. So my question is: is above chip supported?

Is there a list on the web that can help me convert device IDs to chip
types?

Kind regards,

Roland Tollenaar

hinus Viljoen wrote:
> Good day
>
> We intend to use RTnet in a compactPCI-based system. We have narrowed 
the
> possible Single Board Computers (SBC) down to the following 5 options:
>
> (LAN interface chip, SBC Manufacturer, SBC Part number)
> Intel 82546EB,  Kontron, CP6000
> Intel 82546GB,  Advantech, MIC-3369C-M0
> Intel 82573E,  Advantech, MIC-3390
> Intel 82541PI,  Concurrent technologies, PP-332/021
>

Looks like the e1000 driver is in charge here. I put Roman in the CC as
he happened to ask for the same driver a few days ago.

> All the cards support Linux, which (I would assume) implies that they 
have
> Linux LAN drivers.
>
> I have the following questions w.r.t. LAN drivers for RTnet:
> 1. Will any of the above work with RTnet "out of the box"? From the 
RTnet
> documentation I have read it does not seem that there are RTnet 
drivers for
> any of the above LAN chips?
>

Nope.

> 2. Have anybody had success running RTnet with one of the above LAN 
chips or
> SBCs?
>
> 3. Are there any of the above LAN chips that have known problems 
under RTnet?
>
> 4. How difficult will it be to adapt the supplied Linux LANop drivers 
for
> RTnet for someone with limited Linux driver coding experience? (I see
> README.drvporting gives some guidelines, I'm just a bit worried about 
the
> sentence "Some points may not apply to every driver, some may have to be
> added for others.")
>

Surely those remarks express the unknown variables of an RTnet port. The
most critical part is identifying and potentially converting the
synchronisation scheme of the driver, both internally and with the
hardware. The rest is, indeed, some kind of intelligent search&replace
as described in the porting doc.

It all melts down that you have to gain full control over the time your
driver spends a) in its transmission routine and b) in the interrupt
handler under any feasible RTnet load or other driver activity
(startup/shutdown e.g.). The e100 copes with unbounded hardware delays
by reducing the maximum waiting time e.g. This happens under the
assumption that related error conditions do not occur on a
(TDMA-)managed network, and the last years of practical use showed that
this is valid.

Unfortunately, such kind of conversion could not yet be applied to the
3c59x driver which has a more complex logic, and its timing is widely
unknown to us. But that's basically the only exception we faced so far -
further driver conversions depend on someone to work on it and to have
the hardware for intensively testing it.

So, the first step of a potential port must be analysing those two
critical routines of the e1000 as well as all invoked subroutines and to
understand their locking dependencies. If one of you (or both
cooperatively) is willing to start working on this, I can only invite to
discuss your findings here (or better on rtnet-developers). In this case
I could jump in and comment on it as well as far as time permits. The
analysis should not take too much time, and afterwards you can decide if
porting is feasible and how much effort it will likely require.

> Thanks
> Thinus Viljoen
>
> Electronic Engineer
> Aerospace Systems, a division of Denel
> http://www.kentron.co.za
>
> (P.S. Sorry about the footer, which I am sure my company will add. I 
don't
> have any control over it)
>

One is getting used to it. ;)

Jan



Thinus Viljoen wrote:
> Good day
>
> We intend to use RTnet in a compactPCI-based system. We have narrowed 
the
> possible Single Board Computers (SBC) down to the following 5 options:
>
> (LAN interface chip, SBC Manufacturer, SBC Part number)
> Intel 82546EB,  Kontron, CP6000
> Intel 82546GB,  Advantech, MIC-3369C-M0
> Intel 82573E,  Advantech, MIC-3390
> Intel 82541PI,  Concurrent technologies, PP-332/021
>

Looks like the e1000 driver is in charge here. I put Roman in the CC as
he happened to ask for the same driver a few days ago.

> All the cards support Linux, which (I would assume) implies that they 
have
> Linux LAN drivers.
>
> I have the following questions w.r.t. LAN drivers for RTnet:
> 1. Will any of the above work with RTnet "out of the box"? From the 
RTnet
> documentation I have read it does not seem that there are RTnet 
drivers for
> any of the above LAN chips?
>

Nope.

> 2. Have anybody had success running RTnet with one of the above LAN 
chips or
> SBCs?
>
> 3. Are there any of the above LAN chips that have known problems 
under RTnet?
>
> 4. How difficult will it be to adapt the supplied Linux LANop drivers 
for
> RTnet for someone with limited Linux driver coding experience? (I see
> README.drvporting gives some guidelines, I'm just a bit worried about 
the
> sentence "Some points may not apply to every driver, some may have to be
> added for others.")
>

Surely those remarks express the unknown variables of an RTnet port. The
most critical part is identifying and potentially converting the
synchronisation scheme of the driver, both internally and with the
hardware. The rest is, indeed, some kind of intelligent search&replace
as described in the porting doc.

It all melts down that you have to gain full control over the time your
driver spends a) in its transmission routine and b) in the interrupt
handler under any feasible RTnet load or other driver activity
(startup/shutdown e.g.). The e100 copes with unbounded hardware delays
by reducing the maximum waiting time e.g. This happens under the
assumption that related error conditions do not occur on a
(TDMA-)managed network, and the last years of practical use showed that
this is valid.

Unfortunately, such kind of conversion could not yet be applied to the
3c59x driver which has a more complex logic, and its timing is widely
unknown to us. But that's basically the only exception we faced so far -
further driver conversions depend on someone to work on it and to have
the hardware for intensively testing it.

So, the first step of a potential port must be analysing those two
critical routines of the e1000 as well as all invoked subroutines and to
understand their locking dependencies. If one of you (or both
cooperatively) is willing to start working on this, I can only invite to
discuss your findings here (or better on rtnet-developers). In this case
I could jump in and comment on it as well as far as time permits. The
analysis should not take too much time, and afterwards you can decide if
porting is feasible and how much effort it will likely require.

> Thanks
> Thinus Viljoen
>
> Electronic Engineer
> Aerospace Systems, a division of Denel
> http://www.kentron.co.za
>
> (P.S. Sorry about the footer, which I am sure my company will add. I 
don't
> have any control over it)
>

One is getting used to it. ;)

Jan

