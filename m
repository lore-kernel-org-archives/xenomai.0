Message-Id: <1144724767.27088.258799393@domain.hid>
From: "Saul" <xeno@domain.hid>
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
References: <1143612388.32703.257789950@domain.hid>
	<442A7D19.2000009@domain.hid>
	<1143694058.30209.257882137@domain.hid>
	<442C46EC.6000605@domain.hid>
	<1143790982.14016.257982746@domain.hid>
	<442CFCA3.4070704@domain.hid>
	<17453.19513.723459.198259@domain.hid>
Subject: Re: [Xenomai-help] Non-deterministic behaviour in primary mode
In-Reply-To: <17453.19513.723459.198259@domain.hid>
Date: Tue, 11 Apr 2006 13:06:07 +1000
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

>  > > I thought SMI was supposed to increase latencies, but I only see
>  > > latencies < 60us at any load, unless I start video capture. Does
>  > > the latency test absolutely rule out SMI as the cause?
>  >
>  > Not really, e.g. if the video capture device is USB-attached, then
>  > SMI could possibly remain in the picture.
>
> I have used the bttv driver with xawtv or mythtv and nvidia
> proprietary drivers on a dual pIII machine running latency and the
> maximum latency was far less than 100 us. What produces large spots,
> however, is switching virtual terminals or changing resolution.
> Doesn't xawtv change resolution for full screen mode ? Did not you use
> the 768x576 modeline hack ?


The video capture is not USB, it's a PCI card. Since I don't see poor
latencies I'm guessing my problem is *not* SMI related.


>  >   Is there any way to
>  > > check whether SMI is actually disabled?
>  > >
>  >
>  > Gilles will likely have more clue here, but I guess that reading
>  > back the  state of the GBL_SMI_EN_BIT from the SMI's MMIO space
>  > would probably tell us if a previous request to disable SMI
>  > globally did succeed or not. The code in question is in
>  > ksrc/arch/i386/smi.c.
>
> That is a good idea. Another idea would also be to read the state of
> the lock bit (named SMI_LOCK).


At boot GEN_PMCON_1 = 0x0220. Bit 4 is SMI_LOCK, which is zero, so I
should be allowed to disable SMI. This was read using the following
code, which I hope is correct:

    u_int8_t hi, lo;
    int gen_pmcon_1;
    pci_read_config_byte(smi_dev, 0xA0, &lo);
    pci_read_config_byte(smi_dev, 0xA1, &hi);
    gen_pmcon_1 = ((int)hi<<8) | lo;

Further, reading SMI_CTRL_ADDR at boot:
 - before clearing GBL_SMI_EN_BIT -> 0x0000203B
 - after clearing GBL_SMI_EN_BIT -> 0x0000203A

GBL_SMI_EN_BIT is bit zero, which is reported as cleared i.e. SMI
is disabled.

If there are no further ideas on how to fix this, I would be interested
in hearing from people about the PC's that you use that are know to work
well with Xenomai. I'd be looking for a fast new desktop PC. Is AMD a
better bet? I deliberately avoided AMD when purchasing this new Intel PC
(the I/O controller is ICH6) since new AMD PC's have always given me
trouble with I/O controller drivers lagging behind hardware changes. Any
suggestions much appreciated.

Saul.

