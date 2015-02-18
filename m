MIME-Version: 1.0
In-Reply-To: <20150218064715.GD17681@hermes.click-hack.org>
References: <CAEMXjGzwez_k+3Qo-_ZJ4FvbOtLV2MjR0aV_tkeiRdGGaq4MAQ@mail.gmail.com>
 <CAEMXjGxtHB43N5oWL58F2y5rOH-yMycNaWtr+EDs009y1QJUcw@mail.gmail.com>
 <CAEMXjGykL_xTAteJ=Bz10jjL0xr9Uw1YBJpV=sV43Fkw=GAwug@mail.gmail.com>
 <9cf75cdcc753b7abfa0763ebd5ae1d91@grandegger.com>
 <3f27a9331a6514bb01d05d67fca0da4f@grandegger.com>
 <CAEMXjGyDGUf6nGNGfibgv0NzRD=EdFfKBwa2DiS17caskPzsaw@mail.gmail.com>
 <CAEMXjGymm-vZz-0enXbMy1MAm+f+_2EbhwK9xpZbC=pskDeqQQ@mail.gmail.com>
 <CAEMXjGyV=pJMa=ivg89R_bsQyDsfTvn4YwiYSF6RhfwFnU26QQ@mail.gmail.com>
 <20150217182752.GC17681@hermes.click-hack.org>
 <CAEMXjGxoC_ZXcdY+P1O8RO-yiHQA3nw76i1Py42gq6jSbDDMvw@mail.gmail.com>
 <20150218064715.GD17681@hermes.click-hack.org>
Date: Wed, 18 Feb 2015 11:02:40 -0800
Message-ID: <CAEMXjGxpuChBHg9bHLGBgag9BPNPDUYUjCWuXAbii_LRiKm0-Q@mail.gmail.com>
From: Steve B <sbattazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] 16550 serial driver on Beaglebone Black
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On Tue, Feb 17, 2015 at 10:47 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On Tue, Feb 17, 2015 at 02:58:40PM -0800, Steve B wrote:
> > On Tue, Feb 17, 2015 at 10:27 AM, Gilles Chanteperdrix <
> > gilles.chanteperdrix@xenomai.org> wrote:
> >
> > > On Tue, Feb 17, 2015 at 10:22:32AM -0800, Steve B wrote:
> > > > On Fri, Feb 13, 2015 at 4:40 PM, Steve B <sbattazzo@gmail.com>
> wrote:
> > > >
> > > > >
> > > > > On Thu, Feb 12, 2015 at 11:53 PM, Steve B <sbattazzo@gmail.com>
> wrote:
> > > > >
> > > > >>
> > > > >>
> > > > >> On Thu, Feb 12, 2015 at 11:14 PM, Wolfgang Grandegger <
> > > wg@grandegger.com>
> > > > >> wrote:
> > > > >>
> > > > >>> On Fri, 13 Feb 2015 08:10:23 +0100, Wolfgang Grandegger
> > > > >>> <wg@grandegger.com> wrote:
> > > > >>> ...
> > > > >>> > Maybe unbinding the Linux device from the driver as shown below
> > > (for
> > > > >>> > another
> > > > >>> > device) already helps:
> > > > >>> >
> > > > >>> > # echo f0002400.serial \
> > > > >>> >    /sys/devices/f000.soc5200/f0002400.serial/driver/unbind
> > > > >>>
> > > > >>> Oops, the redirection ">" is missing!
> > > > >>>
> > > > >>> Wolfgang,
> > > > >>>
> > > > >>>
> > > > >>>
> > > > >> Thanks Wolfgang, I will give that a try. Otherwise I think it
> looks
> > > > >> promising that just playing with the device tree settings may be
> > > enough to
> > > > >> get the peripheral clock and power enabled without actually
> binding
> > > the
> > > > >> driver!
> > > > >>
> > > > >> Steve
> > > > >>
> > > > >
> > > > > Hmm, unfortunately this one didn't work. I think it un-did the
> clock
> > > > > enable.
> > > > >
> > > > > By doing something ugly as I mentioned before with the device tree
> I
> > > can
> > > > > get the driver running and the register reads/writes seem OK, but
> for
> > > some
> > > > > reason I'm not seeing any IRQs, so I can't get any bytes out on TX.
> > > > >
> > > > > I tried adding the right IRQ number into my "sacrificed" UART's
> device
> > > > > tree entry and that caused some other issue entirely.
> > > > >
> > > >
> > > > Hello all, in case anybody is curious I have an update.
> > > >
> > > > I still haven't found/verified a proper way to load the driver with
> the
> > > > device tree such that the pinmux and clock enable happen as they
> need to,
> > > > but I think maybe I should build an of_match_table into the driver so
> > > that
> > > > the device tree can connect the dots with compatible =
> "ti,xeno_16550A"
> > > or
> > > > something to that effect (as I think Gilles was hinting at last
> week).
> > > >
> > > > Also I realized that I was naively trying to invoke the modprobe of
> > > > xeno_16550A using the actual hardware IRQ number that I see in the
> AM335X
> > > > TRM and the device tree for this UART, which is not the IRQ number
> that's
> > > > in the OS. Fixing that to the correct IRQ number, I was able to send
> > > > something out on the UART once before totally locking up my CPU, so I
> > > think
> > > > I'm stuck in the ISR somehow. But at least it's some progress!
> > >
> > > What I was saying was that you should use the same compatible string
> > > as the one used by the TI driver (otherwise you will not match the
> > > device tree data). And put this in a file, compiled as a separate
> > > module. Not xeno_16550A. I makes no sense to have this in the
> > > xeno_16550A module. You can probably get the irq module
> > > automatically via DT.
> > >
> > > --
> > >                                             Gilles.
> > >
> >
> > OK, but wouldn't there be a problem that it has the same string as the
> > non-RT driver?
> > What about giving it its own compatible string and updating the device
> tree
> > to look for that one?
> > I want to keep most of my UARTs in the non-RT domain and use the RT
> driver
> > on just one UART in my particular application,
>
> As Wolfgang said, you can bind/unbind device to a particular driver.
>
> >
> >
> > Also, after taking a look at the code, I have found a couple of extra
> > things needed to make this compatible with TI's UART on the Beaglebone
> > Black (and presumably OMAP devices as well):
> > According to AM335x TRM, the DLH and DLL registers need to be set to zero
> > when setting up the FIFO (writing to FCR).
> >
> > Also, with the xeno_16550A driver as-is, the driver gets stuck in the
> > while(1) loop in the ISR after a TX is initiated once, freezing my OS.
> > This is because the operation that masks the TX interrupt is not done
> until
> > that loop has been cleared.
> > But with this UART the TX interrupt stays active as long as the TX fifo
> is
> > not full beyond a certain threshold.
> > I have solved this by masking the TX interrupt and posting the
> > rtdm_event_signal(&ctx->out_event) when ctx->out_npend goes to zero
> within
> > the tx_interrupt function instead of outside of that while(1) loop. Is
> > there any reason why I should not be doing it that way?
>
> All this make it clear that you need another driver for the TI UART
> (as I said already twice), say xeno_ti16550A.You just have to
> arrange to factor the common code and not copy/paste it.
>
> --
>                                             Gilles.
>

OK, thanks for the help.
For now I will run keeping my changes local, and when I have some time I
will clean it up the right way and push it back if somebody wants it.

Steve
