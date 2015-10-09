Date: Fri, 9 Oct 2015 10:58:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151009085854.GC5923@hermes.click-hack.org>
References: <56139C8B.3060509@control.lth.se>
 <20151006192323.GB30765@hermes.click-hack.org>
 <5614C8E3.5090809@sigmatek.at> <5614D22A.8030203@sigmatek.at>
 <5615108A.6070001@control.lth.se>
 <20151007124107.GB30140@hermes.click-hack.org>
 <E56D0663-C3E8-42E8-A6D7-8CFCF9F7C116@control.lth.se>
 <20151007144156.GC30140@hermes.click-hack.org>
 <CAPRPZsAm5=TpD7K9S6i+rEStR3Pokk=yOPEP2ZRaFL39Szf+3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPRPZsAm5=TpD7K9S6i+rEStR3Pokk=yOPEP2ZRaFL39Szf+3Q@mail.gmail.com>
Subject: Re: [Xenomai] Problems disabling SMI interrupts on MSI H87-G43
 motherboard
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Cc: "xenomai@xenomai.org" <Xenomai@xenomai.org>

On Thu, Oct 08, 2015 at 11:08:46AM +0200, Jeroen Van den Keybus wrote:
> >> >> Thanks everybody, seems like I have to give up on that motherboard:
> >> >>
> >> >> 1. Nothing found to disable in the BIOS
> >> >> 2. Disabling all sourcecs with smictrl
> >> >(git://git.kiszka.org/smictrl.git)
> >> >>    still gives high latencies with RTNet (+1.5 milliseconds).
> >> >> 3. latency test does not show anything suspicious, so it might
> >> >>    be some other issue.
> >> >>
> >> >> Anybody that has a suggestion on a recent motherboard that has been
> >> >used with
> >> >> RTNet and showing good results?
> 
> As you found out, most MB BIOSes set the SMI lock bit. No way around it.

According to the documentation the SMI lock bit should only lock the
SMI_EN register bit 0, that is the "global disable" bit. However, on
the last machines where I had SMI issues, the SMI_EN register was
entirely read-only, so there must be other ways than the SMI lock
bit to lock the SMI_EN register, which is why smi.c write then reads
the register, instead of checking the SMI lock bit.

-- 
					    Gilles.
https://click-hack.org

