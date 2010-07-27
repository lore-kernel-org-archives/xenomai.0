Message-ID: <4C4EDF5C.9000901@domain.hid>
Date: Tue, 27 Jul 2010 15:30:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTilWSsSuCKRxQg0NIkeeR28eqpdJfaVm_CiemnqF@mail.gmail.com>	<4C46D49F.6030102@domain.hid>	<AANLkTikJgzkkxQyM8DQqVz17ovJmPiIkdZMIFJImExIE@mail.gmail.com>	<4C46F0D9.4030906@domain.hid>	<AANLkTilP98GMfCx1rcgWto9eBmnDwtuavBteD8inFM6V@mail.gmail.com>	<4C47F932.3060400@domain.hid>	<AANLkTilP1f217jN3krm_Cdqu4LaYwpUMu6mMnLiUJq2f@domain.hid>	<4C4823DC.4050500@domain.hid>	<AANLkTi=GuZADaU-CedYiqBU1Bj_Li+EAQ_7ZJKXA_qRR@mail.gmail.com>	<4C4D7B8E.4000309@domain.hid>	<AANLkTim4ZHVhPbzwX5skDWujFcA2d8ceUgUoEvs_R5S1@domain.hid>	<4C4D9171.5000202@domain.hid>
	<AANLkTi=NSEHpoxYHM0HmjtA-xW7Ec69eTgryOYzrvRhC@mail.gmail.com>
In-Reply-To: <AANLkTi=NSEHpoxYHM0HmjtA-xW7Ec69eTgryOYzrvRhC@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Unexpected preemption of highest priority thread
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stephen Bryant <sbxenomai@domain.hid>
Cc: xenomai@xenomai.org

Stephen Bryant wrote:
> On 26 July 2010 14:45, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org
> <mailto:gilles.chanteperdrix@xenomai.org>> wrote:
> 
>     Stephen Bryant wrote:
>     > Do you mean enabling / disabling the individual options in the SMI
>     > Workaround section of the kernel config file, or are you suggesting
>     > something lower level / something else?
> 
>     The options in the SMI workaround section of the kernel config file
>     actually disable some bits in some SMI registers, so they are already
>     low level. Anyway, yes, it is what I ask you to do.
> 
> 
>     --
>                                                Gilles.
> 
> 
> I've been looking into this when I've had the time and the results so
> far are that:
> - Globally disabling SMI fails.
> - Disabling all 8 'non-global' SMI options succeeds, but does not change
> my latency results.
> 
> From this I conclude that 'Globally disable SMI' really does try to
> disable every SMI signal, which is different from just deselecting each
> of the 8 'Enable ... SMI' options presented, which I had not realised.

The "Global disabling" bit, disable all SMI sources without even having
to list them. As such, as explained in the TROUBLESHOOTING file, it is
way more reliable than having to know all the SMI sources and disable
them one by one.

> Also, my problem may still be SMI related, and I can only test this if I
> can convince the BIOS to allow global SMI disabling.
> 
> So my next steps are to:
> 1 - Look for ways to change or circumvent the BIOS (if possible).

There is an "SMI lock" bit, which once enabled, can not be disabled. So,
if the BIOS you use uses this bit, there is nothing you can do, except
changing the BIOS. You can ask the board manufacturer to give you
another BIOS where this bit is not locked, so that you can test whether
SMI are the source of your problem.

> 2 - Try a few other kernel settings (for examples the timers available)
> to find out if my issue stems from something other than SMIs.
> 3 - Progressively change the Xenomai SMI disabling code to test SMIs not
> covered by the 8 options presented.
> 
> I'll be checking the literature for help with these, but if anyone has
> any pointers that would be much appreciated,

What you need is the datasheet of your chipset. I had looked at a
datasheet when doing this code, and found other sources, but did not
implement their disabling, you will find references in the
ksrc/arch/x86/smi.c file, and they are probably incomplete for your
particular chipset, which is why you should look for the datasheet of
your exact chipset.

-- 
					    Gilles.

