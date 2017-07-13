From: Philippe Gerum <rpm@xenomai.org>
References: <1499675553334.21481@kth.se>
 <1674e595-4155-488f-64a0-3017bb4cb994@xenomai.org>
 <1499789361790.71907@kth.se>
Message-ID: <70fd0e46-9f9e-8c21-40e2-d90f06863187@xenomai.org>
Date: Thu, 13 Jul 2017 10:43:10 +0200
MIME-Version: 1.0
In-Reply-To: <1499789361790.71907@kth.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Kernel Warning : I-pipe: Detected illicit call from
 head domain 'Xenomai'
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Nitin Kulkarni <nitink@kth.se>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/11/2017 06:09 PM, Nitin Kulkarni wrote:
> Hi Philippe,
> Thanks for the answer. Can you refer me to any DMA driver that you integrated with ipipe ?

SDMA often found on the i.MX6 series can be adapted this way. The code
supporting TI's EDMA too, although this is more tricky.

> I found out that the DMA driver running is that idam64 and as you mentioned it hooks to the generic DMA engine frame work
> with the handlers implemented in idma64.c .
> 
> I still have one question though, Do we adda real-time irq handler or  keep the existing non-realtime interrupt (through request_irq) for the DMA ? We need the callback to be in real-time, so how is that possible without adding a realtime irq ?
> 

This is not possible doing sane things, hence the trickiness of dealing
with that issue.

> I think a reference will help me understand how to port the dma driver. 
> 

I'm not the copyright holder of that particular customer code, only the
author. Besides, each DMA backend requires a specific implementation for
that purpose, I don't think you could generalize the SDMA/EDMA hooks I
mentioned in order to use them with another backend.

To summarize the idea, the "only" issue is the requirement for sharing
the DMA chip with regular Linux operations. This option I mentioned
involves:

1- allocating Rx/Tx DMA channels for your rt SPI transfers the usual
way, e.g. calling dma_request_slave_channel(). That operation would be
done from a non-rt context, so you would get them once at init.
2- providing a rt capable dmaengine handler for kicking the DMA transfer
on a channel; rt capable meaning which may be called from primary mode
safely. You should see this as a basic, stateless "pulse" mode
operation, i.e. when called, the handler routine triggers the DMA
transfer immediately on the proper channel. That code needs to go to the
idma64 backend driver.

Since setting up the DMA for the next pulse has to be a very basic
operation, you would have to work with a fixed DMA buffer of coherent
memory attached to the channel, that should never change. Or maybe you
could just run your channel strictly in continuous cyclic mode,
programming your DMA channels to reset themselves after each transfer
for the next run, in that case start and stop would be the only
operations required.

Instead of waiting for a completion IRQ, working asynchronously, maybe
you could inspect the DMA channel status (on the chip) directly at some
point in time later, to make sure the last transfer has completed right
before starting the next one. Assuming your Linux-based SoC is the SPI
master and the SPI bus is dedicated to rt traffic, a single software
controller is likely to pace the overall transfer anyway.

If you really have to work with an async notification of transfer
completions, then you could look for a way to have the SPI controller
issue the interrupt after a burst is received/sent, not the DMA chip.
Maybe playing with the Rx/Tx FIFO thresholds if your SPI controller
supports this. If you manage to do that, then grabbing the IRQ source of
a SPI controller dedicated to rt processing is fine, you would not have
to share this with the regular kernel. Again, it all depends on your
requirements, provided you can work with fixed size transfers over a
dedicated SPI bus, etc. YMMV.

Ok, this is pretty much all I have on that topic. In any case, the key
to success is to guarantee that such DMA "fast path" remains transparent
with respect to the regular Linux operations using the same DMA engine.

-- 
Philippe.

