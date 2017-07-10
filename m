References: <1499675553334.21481@kth.se>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <1674e595-4155-488f-64a0-3017bb4cb994@xenomai.org>
Date: Mon, 10 Jul 2017 20:25:16 +0200
MIME-Version: 1.0
In-Reply-To: <1499675553334.21481@kth.se>
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

On 07/10/2017 10:32 AM, Nitin Kulkarni wrote:
> Hi,
> 
> I am getting this message from I-Pipe trace when I enabled the I-pipe debug option.
> 
> Does this affect the performance of my driver in terms of execution time ? and does this mean it switches mode from primary to
> 
> secondary mode ?

This message basically means that your system is no more in a reliable
state, you just can't ignore it.

> 
> Background:
> 
> I am trying to port the linux spi-driver to rtdm driver and instead of going all the way from scratch
> 
> I thought of just trying to remove all the linux related scheduling and try to initiate the transfer directly in
> 
> real-time domain. I think I have done that partially (dma completion interrupt is still in non-real time domain) but I get this message the first time when I send some data over spi. I know that it is because of some memory allocation for setting the dma buffers
> 
> but the transmission is successful and quite quick now because I removed the mechanism used by linux which used tasklets
> 
> and work queues to schedule the transfer.  I just want the transfer to start as soon as possible triggered by an interrupt.
> 
Sharing the DMA engine between the regular Linux kernel and the Cobalt
co-kernel would require significant adjustments to the DMA engine code,
you can't do that by simply calling the DMA API from primary mode, this
would be fundamentally unsafe.

Bottom line: both kernels run asynchronously for the most part, with
Cobalt preempting the Linux kernel in sections that are otherwise deemed
atomic, from Linux's standpoint. The interrupt pipeline machinery makes
this possible. The price to pay for this is that you may not re-enter
the regular Linux kernel code from a context which might have preempted
it in the middle of nowhere, so to speak.

Some hints about a working approach I've used a couple of times already
for sharing a DMA engine. Assuming the DMA chip on this board is driven
by the generic dmaengine framework, it is possible to extend the latter
with a couple of (per-chip) handlers allowing to prepare and monitor
transfers from a real-time  context (i.e. Cobalt primary mode). Those
handlers are defined in the dma_device structure, and implemented in the
DMA backend code which is DMA engine-specific.

Cobalt would then use a dedicated set of DMA channels obtained via
dma_request_slave_channel() as usual, but controlled exclusively from
these new handlers, for running real-time SPI transfers.

Typically, you would have a handler to prepare a transfer, maybe another
one to wait for an ongoing transfer to finish, all from/to a real-time
Cobalt context, instead of a plain Linux context. You would have to make
 sure that your implementation never attempts to synchronize/serialize
on  regular Linux spinlocks/mutexes/sema4 etc.

Interfacing with the IRQ subsystem for asynchronous handling of the DMA
completion may be the main issue here if you need to, because the normal
linux activities would still expect to receive end-of-transfer IRQs in
the "root" domain as usual (request_irq interface) in parallel to the
real-time activities, which would then be incompatible with assigning
the DMA IRQ to the head/Cobalt domain (rtdm_irq_request()) exclusively.
If you can live with receiving end-of-transfer IRQs without rt
guarantees in the Linux domain though, then you don't have to deal with
this problem.

-- 
Philippe.

